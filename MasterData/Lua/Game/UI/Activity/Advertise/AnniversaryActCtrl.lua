local AnniversaryActCtrl = class("AnniversaryActCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
AnniversaryActCtrl._mapNodeConfig = {
  btnJump = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Jump"
  },
  btnName = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Name"
  },
  txtBtnSkin = {nCount = 2, sComponentName = "TMP_Text"},
  txtBtnChar = {nCount = 2, sComponentName = "TMP_Text"},
  txtBtnJump1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Advertise_Skin_201018"
  },
  txtBtnJump2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Advertise_Package_201018"
  },
  txtBtnJump3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Advertise_Bonus_201018"
  },
  txtBtnJump4 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Advertise_ChargeReset_201018"
  },
  txtDiscount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Advertise_PackageDiscount_201018"
  },
  reddotMall = {}
}
AnniversaryActCtrl._mapRedDotConfig = {
  [RedDotDefine.Mall_Page] = {
    sNodeName = "reddotMall",
    param = {
      AllEnum.MallToggle.Activity
    }
  }
}

function AnniversaryActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self.AdConfig = ConfigTable.GetData("AdControl", self.nActId)
  self:RefreshAct()
end

local tbCharId = {110, 155}
local tbSkinId = {11003, 15503}

function AnniversaryActCtrl:RefreshAct()
  local tbTxtSkin = self._mapNode.txtBtnSkin
  local tbTxtChar = self._mapNode.txtBtnChar
  for i = 1, #tbSkinId do
    local mapSkinCfg = ConfigTable.GetData_CharacterSkin(tbSkinId[i])
    if mapSkinCfg == nil then
      printError(string.format("CharacterSkin表里找不到皮肤id：%d", tbSkinId[i]))
    end
    NovaAPI.SetTMPText(tbTxtSkin[i], mapSkinCfg ~= nil and mapSkinCfg.Name or "")
    local mapCharCfg = ConfigTable.GetData_Character(tbCharId[i])
    if mapCharCfg == nil then
      printError(string.format("Character表里找不到角色id：%d", tbCharId[i]))
    end
    NovaAPI.SetTMPText(tbTxtChar[i], mapCharCfg ~= nil and mapCharCfg.Name or "")
  end
end

function AnniversaryActCtrl:OnBtnClick_Name(btn, nIndex)
  local function callback()
    EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Skin)
  end
  
  EventManager.Hit(EventId.SetTransition, 5, callback)
end

function AnniversaryActCtrl:OnBtnClick_Jump(btn, nIndex)
  local nEndTime = self.actData:GetActEndTime()
  local nCurTime = ClientManager.serverTimeStamp
  if nEndTime < nCurTime then
    return
  end
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  
  local function callback()
    if nIndex == 1 then
      EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Skin)
    elseif nIndex == 2 then
      EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Package)
    elseif nIndex == 3 then
      EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Activity)
    elseif nIndex == 4 then
      EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
    end
  end
  
  EventManager.Hit(EventId.SetTransition, 5, callback)
end

return AnniversaryActCtrl
