local UICommonInfo = class("UICommonInfo", UIBaseWindow)
local base = UIBaseWindow
local cs_UnityWebRequest = CS.UnityEngine.Networking.UnityWebRequest
local cs_Application = CS.UnityEngine.Application
local UrlUtil = require("Common.UrlUtil")

function UICommonInfo:OnInit()
  UIUtil.SetTopStatus(self, self.__onBackClick, nil, nil, nil, nil, function()
    if ExplorationManager:IsInExploration() then
      UIUtil.SetTopStatusBtnShow(false, false)
    end
  end)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickRootBack)
  self.ui.tex_Rules.onHrefClick:AddListener(BindCallback(self, self.OnClickHerf))
  self.defaultSize = self.ui.tex_Rules.fontSize
end

function UICommonInfo:InitCommonInfo(infoStr, titleStr, backFunc, isNotNeedTop)
  self.ui.tex_Rules.text = infoStr
  self.ui.text_Tile.text = titleStr
  self.onBackCallback = backFunc
  self.isNotNeedTop = isNotNeedTop
  if self.isNotNeedTop then
    UIUtil.HideTopStatus()
  end
  self.ui.tex_Rules.fontSize = self.defaultSize
end

function UICommonInfo:SetCommonInfoFontSize(size)
  self.ui.tex_Rules.fontSize = size
end

function UICommonInfo:InitCommonInfoByRule(ruleId, showTop)
  local ruleCfg = ConfigData.system_rule[ruleId]
  if ruleCfg == nil then
    error("rule cfg is nil " .. tostring(ruleId))
    return
  end
  self:InitCommonInfo(LanguageUtil.GetLocaleText(ruleCfg.rule_text), LanguageUtil.GetLocaleText(ruleCfg.maintitle), nil, not showTop)
end

function UICommonInfo:InitDungeonDropInfo(dungeonTypeID, backFunc)
  self.onBackCallback = backFunc
  local cfg = ConfigData.dungeon_info[dungeonTypeID]
  if cfg == nil then
    error("dungeon_info cfg is Not Find id:" .. tostring(dungeonTypeID))
  end
  self.ui.tex_Rules.text = LanguageUtil.GetLocaleText(cfg.info_text)
end

function UICommonInfo:OnClickHerf(herfStr)
  local arg = {}
  local index = string.find(herfStr, ":")
  arg[1] = string.sub(herfStr, 1, index - 1)
  arg[2] = string.sub(herfStr, index + 1, -1)
  if arg[1] == "GameJump" then
    local typeAndArgs = string.split(arg[2], "=")
    local jumpTypeId = tonumber(typeAndArgs[1])
    local jumpArgs
    if typeAndArgs[2] ~= nil then
      jumpArgs = CommonUtil.SplitStrToNumber(typeAndArgs[2], "_")
    end
    if 0 < jumpTypeId then
      JumpManager:Jump(jumpTypeId, function(jumpCallback)
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, jumpArgs)
    end
  elseif arg[1] == "link" then
    local webLink = arg[2]
    cs_Application.OpenURL(webLink)
  elseif arg[1] == "token" then
    local webLink = arg[2]
    webLink = UrlUtil.GetWebURL(webLink)
    cs_Application.OpenURL(webLink)
  end
end

function UICommonInfo:__OnClickRootBack()
  if self.isNotNeedTop then
    UIUtil.PopFromBackStackByUiTab(self)
    self:__onBackClick()
  else
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UICommonInfo:__onBackClick()
  if self.onBackCallback ~= nil then
    self.onBackCallback()
  end
  base.Delete(self)
end

function UICommonInfo:OnDelete()
  base.OnDelete(self)
end

return UICommonInfo
