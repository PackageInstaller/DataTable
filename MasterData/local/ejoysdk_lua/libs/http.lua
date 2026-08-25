local JSON = require("ejoysdk_lua.ejoysdk_json")
local URI = require("ejoysdk_lua.libs.uri")
local Class = require("ejoysdk_lua.ejoysdk_class")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local _is_support_native_build_form_data
local M = {}
M.Header = {
  CONTENT_TYPE = {
    CT_URLENCODED = EC.HTTP_CONTENT_TYPE.CT_URLENCODED,
    CT_JSON = EC.HTTP_CONTENT_TYPE.CT_JSON,
    CT_FORMDATA = EC.HTTP_CONTENT_TYPE.CT_FORMDATA
  },
  header_meta_table = {
    __index = function(self, key)
      if 0 == key or 1 == key then
        return
      end
      do return rawget, self, key:lower() end
      return rawget, self, key:lower()
    end,
    __newindex = function(self, key, value)
      local v = value
      if type(v) == "boolean" then
        v = tostring(v)
      elseif type(v) ~= "string" and type(v) ~= "number" then
        _ejoysdk.log("http#headers value error, type:" .. type(v) .. ", key:" .. tostring(key))
      end
      rawset(self, key:lower(), v)
    end
  },
  New = function(headers)
    local obj = {}
    if headers then
      for k, v in pairs(headers) do
        if type(v) == "boolean" then
          v = tostring(v)
        elseif type(v) ~= "string" and type(v) ~= "number" then
          _ejoysdk.log("http#headers value error, type:" .. type(v) .. ", key:" .. tostring(k))
        end
        obj[k:lower()] = v
      end
    end
    do return setmetatable, obj end
    return setmetatable, obj, M.Header.header_meta_table, pairs(headers)
  end
}
local FormData = {}
FormData.__index = FormData

function FormData.New()
  local boundary = FormData.gen_boundary()
  do return setmetatable, {
    params = {},
    boundary = boundary
  } end
  return setmetatable, {
    params = {},
    boundary = boundary
  }, FormData
end

function FormData:add_part(key, data, content_type, content_encoding, filename)
  content_type = content_type or "application/octet-stream"
  local data_type = type(data)
  if "table" == data_type then
    if content_type == M.Header.CONTENT_TYPE.CT_JSON then
      data = JSON.encode(data)
    elseif content_type == M.Header.CONTENT_TYPE.CT_URLENCODED then
      data = URI.encode_query_with_array_separate(data)
    end
  end
  data = tostring(data)
  content_encoding = content_encoding or "binary"
  local params = self.params
  params[#params + 1] = {
    key = key,
    filename = filename,
    content_type = content_type,
    content_encoding = content_encoding,
    data = data
  }
end

function FormData:add_simple_part(key, data)
  local params = self.params
  params[#params + 1] = {key = key, data = data}
end

function FormData:add_file(_key, _file)
end

local function encode_part(r, entry)
  r[#r + 1] = string.format("content-disposition: form-data; name=\"%s\"", entry.key)
  if entry.filename then
    r[#r + 1] = string.format("; filename=\"%s\"", entry.filename)
  end
  if entry.content_type then
    r[#r + 1] = "\r\ncontent-type: "
    r[#r + 1] = entry.content_type
  end
  if entry.content_encoding then
    r[#r + 1] = "\r\ncontent-transfer-encoding: "
    r[#r + 1] = entry.content_encoding
  end
  r[#r + 1] = "\r\n\r\n"
  r[#r + 1] = entry.data
  r[#r + 1] = "\r\n"
end

function FormData:content_type()
  return "multipart/form-data; boundary=" .. self.boundary
end

function FormData:build()
  local boundary = self.boundary
  local part = "--" .. boundary .. "\r\n"
  local r = {}
  for _, v in ipairs(self.params) do
    r[#r + 1] = part
    encode_part(r, v)
  end
  r[#r + 1] = "--" .. boundary .. "--"
  do return table.concat end
  return table.concat, r, boundary, "--", nil, nil, encode_part, r, v
end

function FormData.gen_boundary()
  local t = {"BOUNDARY-"}
  for i = 2, 17 do
    t[i] = string.char(math.random(65, 90))
  end
  t[18] = "-BOUNDARY"
  do return table.concat end
  return table.concat, t, 1, nil, string.char(math.random(65, 90)), math.random(65, 90)
end

local NativeBuildFormData = {}
NativeBuildFormData.__index = NativeBuildFormData

function NativeBuildFormData.New()
  do return setmetatable, {
    params = {}
  } end
  return setmetatable, {
    params = {}
  }, NativeBuildFormData
end

function NativeBuildFormData:add_file(name, file_path, content_type, filename)
  content_type = content_type or "application/octet-stream"
  local params = self.params
  params[#params + 1] = {
    name = name,
    file_name = filename,
    content_type = content_type,
    file_path = file_path,
    type = "file"
  }
end

function NativeBuildFormData:add_part(name, data)
  local params = self.params
  params[#params + 1] = {
    name = name,
    data = data,
    type = "data"
  }
end

function NativeBuildFormData:get_part()
  return self.params
end

function NativeBuildFormData:content_type()
  return EC.HTTP_CONTENT_TYPE.CT_JSON
end

function NativeBuildFormData:empty_body()
  return {}
end

local Request = Class:Inherit("ej_http_request")

function Request:_init(url, req_params, content_type, body)
  self._data = {
    url = url,
    req_params = req_params,
    content_type = content_type,
    body = body
  }
end

function Request:get(cb)
  M.get(self._data.url, self._data.req_params, cb)
end

function Request:post(cb)
  M.post(self._data.url, self._data.req_params, self._data.content_type, self._data.body, cb)
end

function Request:download_file(down_params, opts, cb, process_cb, header_cb, finish_cb)
  down_params = down_params or {}
  opts = opts or {}
  local req_params = self._data.req_params or {}
  req_params.enable_download_range = opts.enable_download_range
  req_params.connectionTimeout = opts.connectionTimeout
  req_params.dataRetrievalTimeout = opts.dataRetrievalTimeout
  for k, v in pairs(down_params) do
    req_params[k] = v
  end
  req_params.finish_cb = finish_cb
  req_params.progress = process_cb
  req_params.header_cb = header_cb
  M.get(self._data.url, req_params, cb, opts)
end

local RequestBuilder = Class:Inherit("ej_http_request_builder")
Request.Builder = RequestBuilder

function RequestBuilder:Instance(_url, _acceptable, _raw_body, _tag)
  local inst = RequestBuilder:New(_url, _acceptable, _raw_body, _tag)
  return inst
end

function RequestBuilder:_init(_url, _acceptable, _raw_body, _tag)
  self._data = {
    url = _url,
    tag = _tag,
    acceptable = _acceptable,
    raw_body = _raw_body,
    headers = nil,
    content_type = nil,
    body = nil,
    body_parts = nil
  }
end

function RequestBuilder:headers(_headers)
  self._data.headers = _headers
end

function RequestBuilder:add_header(key, value)
  if not self._data.headers then
    self._data.headers = {}
  end
  self._data.headers[key] = value
end

function RequestBuilder:body(content_type, body_data)
  self._data.content_type = content_type
  self._data.body = body_data
end

function RequestBuilder.is_support_native_build_form_data()
  if nil == _is_support_native_build_form_data then
    _is_support_native_build_form_data = _ejoysdk_lua_cjson and _ejoysdk.os() ~= "windows" or false
  end
  return _is_support_native_build_form_data
end

function RequestBuilder:body_add_part(key, data, content_type, content_encoding, filename)
  content_type = content_type or "application/octet-stream"
  local data_type = type(data)
  if "table" == data_type then
    if content_type == M.Header.CONTENT_TYPE.CT_JSON then
      data = JSON.encode(data)
    elseif content_type == M.Header.CONTENT_TYPE.CT_URLENCODED then
      data = URI.encode_query_with_array_separate(data)
    end
  end
  data = tostring(data)
  content_encoding = content_encoding or "binary"
  if not self._data.body_parts then
    self._data.body_parts = {}
  end
  local body_parts = self._data.body_parts
  body_parts[#body_parts + 1] = {
    key = key,
    content_type = content_type,
    content_encoding = content_encoding,
    data = data,
    filename = filename
  }
end

function RequestBuilder:body_add_simple_part(key, data)
  if not self._data.body_parts then
    self._data.body_parts = {}
  end
  local body_parts = self._data.body_parts
  body_parts[#body_parts + 1] = {key = key, data = data}
end

function RequestBuilder:body_add_file_path(key, file_path, content_type, filename)
  content_type = content_type or "application/octet-stream"
  if not self._data.body_parts then
    self._data.body_parts = {}
  end
  local body_parts = self._data.body_parts
  body_parts[#body_parts + 1] = {
    key = key,
    file_name = filename,
    content_type = content_type,
    file_path = file_path
  }
end

function RequestBuilder:_parse_req_params_body_parts(body_parts, out_params)
  local has_filepath_data = false
  local has_content_encoding_data = false
  for _, part in ipairs(body_parts) do
    if part.content_encoding and part.content_type then
      has_content_encoding_data = true
    end
    if part.file_path then
      has_filepath_data = true
    end
  end
  if not (not has_content_encoding_data and has_filepath_data) or not RequestBuilder.is_support_native_build_form_data() then
    local formdata = FormData:New()
    for _, part in ipairs(body_parts) do
      if part.file_path then
        local E = require("ejoysdk_lua.ejoysdk")
        local data = E.File.readfile_fullpath(part.file_path)
        formdata:add_part(part.key, data, false, false, part.file_name)
      elseif part.content_type and part.content_encoding then
        formdata:add_part(part.key, part.data, part.content_type, part.content_encoding, part.file_name)
      else
        formdata:add_simple_part(part.key, part.data)
      end
    end
    self._data.content_type = formdata:content_type()
    self._data.body = formdata:build()
  else
    local formdata = NativeBuildFormData.New()
    for _, part in ipairs(self._data.body_parts) do
      if part.file_path then
        formdata:add_file(part.key, part.file_path, part.content_type, part.file_name)
      else
        formdata:add_part(part.key, part.data)
      end
    end
    self._data.content_type = formdata:content_type()
    self._data.body = formdata:empty_body()
    out_params.safe_formdata = formdata:get_part()
  end
end

function RequestBuilder:build()
  local request_params = {}
  local part_count = self._data.body_parts and #self._data.body_parts or 0
  if part_count > 0 then
    self:_parse_req_params_body_parts(self._data.body_parts, request_params)
  end
  request_params.taskId = self._data.tag
  request_params.acceptable = self._data.acceptable
  request_params.headers = self._data.headers or {}
  if request_params.headers["Content-Type"] then
    assert(request_params.headers["Content-Type"] == self._data.content_type)
  end
  request_params["Content-Type"] = self._data.content_type
  do return Request.New, Request, self._data.url, request_params, self._data.content_type end
  return Request.New, Request, self._data.url, request_params, self._data.content_type, self._data.body
end

function M.post(url, params, _content_type, body, cb)
  assert(nil ~= _content_type, "content_type should not be nil")
  if type(body) == "table" then
    body = M.body_tostring(body, _content_type)
  end
  local E = require("ejoysdk_lua.ejoysdk")
  E.HTTP.process_post(url, params, _content_type, body, cb)
end

function M.get(url, params, cb)
  local E = require("ejoysdk_lua.ejoysdk")
  E.HTTP.process_get(url, params, cb)
end

function M.stop(_task_id_arr, params, cb)
  params = params or {}
  local E = require("ejoysdk_lua.ejoysdk")
  E.HTTP.process_stop(_task_id_arr, params, cb)
end

function M.download_file(url, down_params, opts, cb, process_cb, header_cb, finish_cb)
  opts = opts or {}
  down_params = down_params or {}
  down_params.enable_download_range = opts.enable_download_range
  down_params.connectionTimeout = opts.connectionTimeout
  down_params.dataRetrievalTimeout = opts.dataRetrievalTimeout
  down_params.progress = process_cb
  down_params.header_cb = header_cb
  down_params.finish_cb = finish_cb
  M.get(url, down_params, cb)
end

function M.body_tostring(body, content_type)
  if type(body) == "string" then
    return body
  elseif nil == body then
    return ""
  end
  assert(type(body) == "table")
  if content_type == M.Header.CONTENT_TYPE.CT_JSON then
    do return JSON.encode end
    return JSON.encode, body, body
  elseif content_type == M.Header.CONTENT_TYPE.CT_URLENCODED then
    do return URI.encode_query_with_array_separate end
    return URI.encode_query_with_array_separate, body, body
  end
  assert(false, content_type)
end

M.FormData = FormData
M.NativeBuildFormData = NativeBuildFormData
M.Request = Request
return M
