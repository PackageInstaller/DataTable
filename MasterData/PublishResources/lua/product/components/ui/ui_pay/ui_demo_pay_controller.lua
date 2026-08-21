_class("UIDemoPayController", UIController)
UIDemoPayController = UIDemoPayController
local defaultItemIdStr = "com.tencent.baiye60"
local defaultItemIdStrIntl = "com.tencent.baiyeint.testdust60"
local defaultItemIdStrAndroid = "com.tencent.baiye.item1"
local defaultItemNumStr = "1"
local defaultDiamondNumStr = "1000"
local defaultServiceCode = "testcard1"

function UIDemoPayController:OnShow(uiParams)
  self:AttachEvent(GameEventType.AchieveUpdate)
  self:GetUIComponent("InputField", "count_input").text = defaultDiamondNumStr
  self:GetUIComponent("InputField", "item_num_input").text = defaultItemNumStr
  self:GetUIComponent("InputField", "service_code_input").text = defaultServiceCode
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    if IsIos() then
      self:GetUIComponent("InputField", "item_id_input").text = defaultItemIdStr
    elseif IsAndroid() or IsUnityEditor() then
      self:GetUIComponent("InputField", "item_id_input").text = defaultItemIdStrAndroid
    end
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    self:GetUIComponent("InputField", "item_id_input").text = defaultItemIdStrIntl
  end
end

function UIDemoPayController:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIDemoPayController:btnPayGameOnClick(go)
  local pay_module = self:GetModule(PayModule)
  if IsUnityEditor() then
    Log.error("UIDemoPayController:btnPayGameOnClick pay is invalid in Unity Editor")
    return
  elseif IsIos() then
    local item_id_text = self:GetUIComponent("InputField", "item_id_input").text
    if string.isnullorempty(item_id_text) then
      Log.error("[Pay]ios game pay productId can't be empty")
      return
    end
    pay_module:GamePay(item_id_text, "")
  elseif IsAndroid() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      local diamond_count_str = self:GetUIComponent("InputField", "count_input").text
      if string.isnullorempty(diamond_count_str) then
        Log.error("[Pay]android game pay diamond count can't be empty")
        return
      end
      pay_module:GamePay("", diamond_count_str)
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      local item_id_text = self:GetUIComponent("InputField", "item_id_input").text
      if string.isnullorempty(item_id_text) then
        Log.error("[Pay]android international game pay productId can't be empty")
        return
      end
      pay_module:GamePay(item_id_text, "")
    end
  end
end

function UIDemoPayController:btnAddDiamondOnClick(go)
  local diamond_text = self:GetUIComponent("InputField", "count_input").text
  if string.isnullorempty(diamond_text) then
    Log.fatal("wrong diamond count")
    return
  end
  local diamond_count = tonumber(diamond_text)
  self:StartTask(self.AddDiamond, self, diamond_count)
end

function UIDemoPayController:btnUseDiamondOnClick(go)
  local diamond_text = self:GetUIComponent("InputField", "count_input").text
  if string.isnullorempty(diamond_text) then
    Log.fatal("wrong diamond count")
    return
  end
  local diamond_count = tonumber(diamond_text)
  self:StartTask(self.UseDiamond, self, diamond_count)
end

function UIDemoPayController:btnBuyGoodsOnClick(go)
  local item_id_str = self:GetUIComponent("InputField", "item_id_input").text
  local item_num_str = self:GetUIComponent("InputField", "item_num_input").text
  if string.isnullorempty(item_id_str) or string.isnullorempty(item_num_str) then
    Log.fatal("UIDemoPayController:btnBuyGoodsOnClick item_id and item_num can't be empty")
    return
  end
  local item_num = tonumber(item_num_str)
  if not Cfg.cfg_buy_goods[item_id_str] then
    return
  end
  if item_num == 0 then
    return
  end
  self:StartTask(self.BuyGoodsTask, self, item_id_str, item_num)
end

function UIDemoPayController:btnBuySubscribeOnClick(go)
  local productID = self:GetUIComponent("InputField", "item_id_input").text
  if string.isnullorempty(productID) then
    Log.error("UIDemoPayController:UIbtnBuySubscribeOnClick productID can't be empty")
    return
  end
  local serviceType = MidasServiceType.SERVICETYPE_NORMAL
  local autoPay = false
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    autoPay = true
  end
  self:GetModule(PayModule):BuySubscribeByProductId(productID, serviceType, autoPay)
end

function UIDemoPayController:btnBuySubscribeBySCOnClick(go)
  local serviceCode = self:GetUIComponent("InputField", "service_code_input").text
  if string.isnullorempty(serviceCode) then
    Log.error("UIDemoPayController:btnBuySubscribeBySCOnClick serviceCode can't be empty")
    return
  end
  local serviceType = MidasServiceType.SERVICETYPE_NORMAL
  local autoPay = false
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    autoPay = true
  end
  self:GetModule(PayModule):BuySubscribeByServiceCode(serviceCode, serviceType, autoPay)
end

function UIDemoPayController:btnGetActivityInfoOnClick(go)
  self:GetModule(PayModule):GetInfo("mp")
end

function UIDemoPayController:btnGetSubscribeInfoOnClick(go)
  if IsUnityEditor() then
    Log.error("UIDemoPayController:btnGetSubscribeInfoOnClick pay is invalid in Unity Editor")
    return
  end
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    self:StartTask(self.QuerySubscribeInfo, self)
  else
    Log.error("UIDemoPayController:btnGetSubscribeInfoOnClick pay is invalid without msdk")
  end
end

function UIDemoPayController:AddDiamond(TT, count)
  Log.debug("UIDemoPayController:AddDiamond")
  local module = self:GetModule(PayModule)
  local res = module:RequestAddDiamond(TT, count)
  if not res:GetSucc() then
    Log.fatal("增加钻石失败 ", res:GetResult())
    return
  end
end

function UIDemoPayController:UseDiamond(TT, count)
  Log.debug("UIDemoPayController:UseDiamond")
  local module = self:GetModule(PayModule)
  local res = module:RequestUseDiamond(TT, count)
  if not res:GetSucc() then
    if res:GetResult() == PayErrorCode.PAY_ERROR_NOT_ENOUGH_BALANCE then
      Log.error("UIDemoPayController:UseDiamond diamond is not enough ,error code ", res:GetResult())
      return
    end
    Log.fatal("UIDemoPayController:UseDiamond diamond failed, error code ", res:GetResult())
    return
  end
end

function UIDemoPayController:BuyGoodsTask(TT, item_id, item_num)
  Log.debug("UIDemoPayController:BuyGoodsTask")
  local pay_module = self:GetModule(PayModule)
  if IsAndroid() or IsUnityEditor() then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      local res, replyEvent = pay_module:SendBuyGoodsRequest(TT, item_id, item_num)
      Log.debug("UIDemoPayController:BuyGoodsTask IsAndroid start res ", res.m_result)
      if not res:GetSucc() then
        if res.m_result == PayErrorCode.PAY_ERROR_NOT_USE_MIDAS then
          PopupManager.Alert("UIDemoCommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "直购失败", "道具直购须在服务器开启米大师使用开关", nil, "确认")
        else
          PopupManager.Alert("UIDemoCommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "直购失败", "道具直购失败,请稍后重试", nil, "确认")
        end
      elseif not replyEvent then
        Log.debug("UIDemoPayController:BuyGoodsTask failed no replyEvent")
      elseif res.m_result == PayErrorCode.PAY_SUCC then
        local token = replyEvent.token
        local url = replyEvent.url_params
        Log.debug("UIDemoPayController:BuyGoodsTask success token ", token, " url ", url)
        pay_module:BuyGoodsByUrl(url)
      end
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
      pay_module:BuyGoodsByProductid(item_id, item_num)
    end
  elseif IsIos() then
    Log.debug("UIDemoPayController:BuyGoodsTask IsIos start, item_id", item_id, " item_num ", item_num)
    pay_module:BuyGoodsByProductid(item_id, item_num)
  end
end

function UIDemoPayController:OnGameEvent(gameEventType, ...)
  if gameEventType == GameEventType.AchieveUpdate then
    self:RefreshUI()
  end
end

function UIDemoPayController:RefreshUI()
end

function UIDemoPayController:QuerySubscribeInfo(TT)
  self:GetModule(PayModule):OnBuySuscribeSuccess(TT)
end
