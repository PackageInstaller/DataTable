return function(init_sdk_cb, _product, game_server, player_name)
  local E = require("ejoysdk_lua.ejoysdk")
  local ejoysdk_gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
  local ejoysdk_init = require("ejoysdk_lua.ejoysdk_init")
  local ejoysdk_topic = require("ejoysdk_lua.ejoysdk_topic")
  game_server = game_server or "test_srpc"
  player_name = player_name or "role1"
  local TAG = "cloud_sdk_init"
  
  local function log(s)
    _ejoysdk.log(s)
  end
  
  local function enter_game(player_id)
    local analog = require("demo.sdk_test.analog")
    analog.login(player_id, function(succ)
      if succ then
        _ejoysdk.log("进入游戏成功")
        local player_info = {
          player_id = player_id,
          player_name = player_name,
          server_id = game_server
        }
        E.log(player_info)
        ejoysdk_gangplank.set_player_info(player_info, "enterGame")
      else
        _ejoysdk.log("进入游戏失败")
      end
    end)
  end
  
  local function login_game(game_token)
    local analog = require("sdk_test.analog")
    analog.init(game_token)
    analog.create_player(game_server, player_name, function(succ, player_id)
      if succ then
        _ejoysdk.log("创建角色成功，player id: " .. player_id)
        enter_game(player_id)
      else
        _ejoysdk.log("创建角色失败")
      end
    end)
  end
  
  local function auth_listener(succ, ...)
    if succ then
      local game_token = (...)
      log("-------gangplank login success-------")
      login_game(game_token)
    else
      local code, message = ...
      log("-------gangplank login failure-------")
      log("code: " .. code .. " ,message: " .. message)
    end
  end
  
  local function pay_listener(succ, ...)
    if succ then
      local order_id, ext = ...
      log("-------gangplank pay success-------")
      log("order id: " .. tostring(order_id))
      E.log(ext)
    else
      local order_id, code, msg, ext = ...
      ext = ext or {}
      local sub_code = ext.code
      local sub_msg = ext.msg
      log("-------gangplank pay failure -------")
      log("error order id:  " .. tostring(order_id) .. " ,code: " .. tostring(code) .. " ,msg: " .. tostring(msg) .. ", err_code:" .. tostring(sub_code) .. ", err_msg:" .. tostring(sub_msg))
      E.log(ext)
    end
  end
  
  local function logout_listener()
    log("-------gangplank logout success-------")
  end
  
  local function exit_listener(succ)
    if succ then
      log("-------gangplank exit success-------")
    else
      log("-------gangplank exit failure-------")
    end
  end
  
  local function acquire_listener(succ, ...)
    log("zfm test acquire_listener")
    if succ then
      log("-------cloud gangplank acquire success-------")
      local token, body = ...
      log("回调 token: " .. token .. " ,info token: " .. ejoysdk_gangplank.user_info().token)
      E.LOG.debug(TAG, "acquire_listener result body >>")
      E.log(body)
      ejoysdk_gangplank.get_players(token, function(succ2, ...)
        if succ2 then
          log("-------gangplank 获取角色信息成功-------")
          local players = (...)
          E.log({
            players = players,
            msg = "打印角色信息"
          })
        else
          log("-------gangplank 获取角色信息失败-------")
        end
      end)
    else
      log("-------gangplank acquire failure-------")
      local code, message, info = ...
      log("code: " .. tostring(code) .. " ,message: " .. tostring(message))
      log("第三方登录错误信息 ds_code:" .. tostring(info.ds_code) .. ", ds_server_code:" .. tostring(info.ds_server_code) .. ", info >>>")
      E.log(info)
    end
  end
  
  local gangplank_init_handler
  
  function gangplank_init_handler(succ, ...)
    E.LOG.debug(TAG, "received SUBSCRIBE_GANGPLANK_INITED >>")
    init_sdk_cb(succ, ...)
    ejoysdk_topic.unsubscribe(ejoysdk_init.SUBSCRIBE_GANGPLANK_INITED, gangplank_init_handler)
  end
  
  ejoysdk_topic.subscribe(ejoysdk_init.SUBSCRIBE_GANGPLANK_INITED, gangplank_init_handler)
  local vendors = {
    ALIGAMES = {},
    JF = {
      white_privacy_fields = {
        "imei",
        "brand",
        "model",
        "mac",
        "country",
        "lang",
        "ramSize",
        "availRamSize",
        "hwf",
        "fr",
        "cpu"
      }
    }
  }
  ejoysdk_init.gangplank(vendors, {
    auth_listener = auth_listener,
    pay_listener = pay_listener,
    logout_listener = logout_listener,
    exit_listener = exit_listener,
    acquire_listener = acquire_listener
  })
  ejoysdk_init.holo()
  log("[cloud game] init sdk")
  if _ejoysdk.os() == "ios" then
    E.CONFIG.set_config(E.CONFIG.KEY.APP_VERSION_UPDATE_CHECK, true)
    local NAMESPACE_CLOUDGAME = "ejoy_cloud_game"
    local ECC = require("ejoysdk_lua.ejoysdk_config_center")
    ECC.get_configs_in_whitelist({NAMESPACE_CLOUDGAME}, function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "request_cloud_static_config succ")
        local cloud_game_config = ECC.get_config(NAMESPACE_CLOUDGAME)
        if cloud_game_config and next(cloud_game_config) ~= nil and nil ~= cloud_game_config.config then
          E.log(cloud_game_config)
          local config_data = cloud_game_config.config
          local sdk_config_info = config_data and config_data.cloud_sdk_config or nil
          local is_preview_for_ios = sdk_config_info and sdk_config_info.is_apple_review or false
          if is_preview_for_ios then
            E.LOG.debug(TAG, "yes, it is apple review now!!!!!!!!!!")
            local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
            local product_code = cloud_config.ProductIdAppleReview
            ECC.delete_with_new_product(product_code)
            E.CONFIG.autoconfig("", product_code)
            cloud_config.CloudGameId = cloud_config.CloudGameIdAppleReview
          end
          ejoysdk_init.init()
        else
          ejoysdk_init.init()
        end
      else
        local code, msg = ...
        E.LOG.warn(TAG, "request_cloud_static_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        init_sdk_cb(false, code, msg)
      end
    end)
  else
    ejoysdk_init.init()
  end
end
