local E = require("ejoysdk_lua.ejoysdk")
local MEDIA_API = require("ejoysdk_lua.album.ejoysdk_media_api")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local TAG = "image_process"
local M = {}
M.image_process_event_name = {
  pick_image = "sdk.image.pick",
  edit_image = "sdk.image.edit",
  upload_image = "sdk.image.upload_succ",
  chat_send_image = "sdk.image.chat_send_succ"
}
local image_compress_size = {
  thumbnail_portrait_default_width = 384,
  thumbnail_portrait_max_height_ratio = 2,
  thumbnail_landscape_default_height = 384,
  thumbnail_landscape_max_width_ratio = 2,
  preview_default_quality = 90
}

function M.get_image_adaptive_compress_params(compress_data, image_type, image_params)
  compress_data = compress_data or {}
  if "preview" == image_type then
    local compress_quality = compress_data.quality or image_compress_size.preview_default_quality
    do return string.format, "/quality,q_%d" end
    return string.format, "/quality,q_%d", compress_quality, nil, nil, nil, nil, nil, nil, nil, nil, nil
  elseif "thumbnail" == image_type and image_params then
    local image_width, image_height = image_params.width, image_params.height
    local compress_size = compress_data.size
    if not image_width or not image_height then
      compress_size = compress_size or image_compress_size.thumbnail_portrait_default_width
      do return string.format, "/resize,w_%d/crop,x_0,y_0,w_%d,h_%d/quality,q_90", compress_size, compress_size end
      return string.format, "/resize,w_%d/crop,x_0,y_0,w_%d,h_%d/quality,q_90", compress_size, compress_size, compress_size, nil, nil, nil, nil, nil
    end
    image_width = image_width > 0 and image_width or image_compress_size.thumbnail_portrait_default_width
    image_height = image_height > 0 and image_height or image_compress_size.thumbnail_landscape_default_height
    local is_portrait_image = image_width < image_height
    local compress_width, compress_height, compress_param
    if is_portrait_image then
      compress_size = compress_size or image_compress_size.thumbnail_portrait_default_width
      local compress_ratio = compress_size / image_width
      compress_width = compress_ratio < 1 and compress_size or image_width
      compress_height = compress_ratio < 1 and image_height * compress_ratio or image_height
      compress_param = string.format("/resize,w_%d", compress_width)
      if compress_height > compress_width * image_compress_size.thumbnail_portrait_max_height_ratio then
        compress_param = string.format("%s/crop,x_0,y_0,w_%d,h_%d", compress_param, compress_width, compress_width * image_compress_size.thumbnail_portrait_max_height_ratio)
      end
    else
      compress_size = compress_size or image_compress_size.thumbnail_landscape_default_height
      local compress_ratio = compress_size / image_height
      compress_height = compress_ratio < 1 and compress_size or image_height
      compress_width = compress_ratio < 1 and image_width * compress_ratio or image_width
      compress_param = string.format("/resize,h_%d", compress_height)
      if compress_width > compress_height * image_compress_size.thumbnail_landscape_max_width_ratio then
        compress_param = string.format("%s/crop,x_0,y_0,w_%d,h_%d", compress_param, compress_height * image_compress_size.thumbnail_landscape_max_width_ratio, compress_height)
      end
    end
    do return string.format, "%s/quality,q_90" end
    return string.format, "%s/quality,q_90", compress_param, compress_param, compress_height * image_compress_size.thumbnail_landscape_max_width_ratio, compress_height
  end
end

function M.pick_images(picker_params, cb)
  picker_params = picker_params or {}
  QL.commit_event(M.image_process_event_name.pick_image, picker_params)
  picker_params.media_type = "image"
  E.picker(picker_params, function(succ, ...)
    if succ then
      local images = (...)
      for i = 1, #images do
        local image = images[i]
        local image_name = E.Utils.split_string(image.image_path, "/")
        image_name = image_name[#image_name]
        if image.is_edited then
          QL.commit_event(M.image_process_event_name.edit_image, {
            image_width = image.width,
            image_height = image.height,
            image_size = image.size,
            image_name = image_name
          })
        end
      end
    end
    cb(succ, ...)
  end)
end

function M.upload_images(images, upload_media_group, single_upload_result_cb)
  for i = 1, #images do
    local image = images[i]
    local image_path = image.image_path
    MEDIA_API.get_oss_policy(upload_media_group, function(policy_succ, ...)
      if not policy_succ or not image_path then
        local code, msg = ...
        E.LOG.d(TAG, "[image_process] get_oss_policy fail, code: " .. tostring(code) .. ", msg: " .. msg)
        if single_upload_result_cb then
          single_upload_result_cb(false, code, msg, image)
        end
        return
      end
      local oss_policy_result = (...)
      MEDIA_API.upload_file(image_path, MEDIA_API.INPUT_TYPE.PATH, "image", oss_policy_result, function(upload_succ, ...)
        if not upload_succ then
          local code, msg = ...
          E.LOG.d(TAG, "[image_process] upload_image fail, code: " .. tostring(code) .. ", msg: " .. msg)
          if single_upload_result_cb then
            single_upload_result_cb(false, code, msg, image)
          end
          return
        end
        local res_id = oss_policy_result.media_id
        local upload_result = (...)
        local res_key = upload_result.data and upload_result.data.key
        local image_url = MEDIA_API.get_image_full_url(res_key)
        E.LOG.d(TAG, "[image_process] upload_image succ, res_id: " .. res_id .. ", image_url: " .. image_url)
        local image_name = E.Utils.split_string(image_path, "/")
        image_name = image_name[#image_name]
        QL.commit_event(M.image_process_event_name.upload_image, {
          image_url = image_url,
          image_size = image.size,
          scene = upload_media_group,
          image_name = image_name
        }, true)
        local cb_data = {
          index = i,
          res_id = res_id,
          image_url = image_url
        }
        if single_upload_result_cb then
          single_upload_result_cb(true, cb_data)
        end
      end)
    end)
  end
end

function M.pick_and_upload_images(picker_params, upload_media_group, pick_results_batch_cb, single_upload_result_cb)
  M.pick_images(picker_params or {}, function(pick_succ, ...)
    if not pick_succ then
      local code, msg = ...
      E.LOG.d(TAG, "[image_process] select image failed, code: " .. tostring(code) .. ", msg: " .. msg)
      if pick_results_batch_cb then
        pick_results_batch_cb(false, ...)
      end
      return
    end
    local images = (...)
    if pick_results_batch_cb then
      pick_results_batch_cb(true, images)
    end
    M.upload_images(images, upload_media_group, single_upload_result_cb)
  end)
end

return M
