local UILoading = class("UILoading", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader

function UILoading:OnInit()
  self.__permanent = true
  self.onProgressRefresh = BindCallback(self, self.RefreshSceneProgress)
  MsgCenter:AddListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
  self.defaultBg = self.ui.bG.texture
  self.bgResLoader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self._OnClickLeft)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self._OnClickRight)
  self.__isInitShow = true
end

function UILoading:SetLoadingTipsSystemId(systemId)
  self.__systemId = systemId
end

function shuffle(targetTbl)
  math.randomseed(os.time())
  local tblLen = #targetTbl
  while 0 < tblLen do
    local idx = math.random(tblLen)
    targetTbl[tblLen], targetTbl[idx] = targetTbl[idx], targetTbl[tblLen]
    tblLen = tblLen - 1
  end
  return targetTbl
end

function validTips(tipsId)
  local tipCfg = ConfigData.loading_tips[tipsId]
  local valid = CheckCondition.CheckLua(tipCfg.in_condition, tipCfg.in_para1, tipCfg.in_para2) and (#tipCfg.out_condition == 0 or not CheckCondition.CheckLua(tipCfg.out_condition, tipCfg.out_para1, tipCfg.out_para2))
  return valid
end

function UILoading:__InitLoadingTips(systemId)
  local tipsIdListNew = {}
  for k, id in ipairs(ConfigData.loading_tips.systemLoadingTipsDic[0]) do
    if validTips(id) then
      table.insert(tipsIdListNew, id)
    end
  end
  local tipsIdListSource = ConfigData.loading_tips.systemLoadingTipsDic[systemId]
  if tipsIdListSource ~= nil then
    for k, id in ipairs(tipsIdListSource) do
      if validTips(id) then
        table.insert(tipsIdListNew, id)
      end
    end
  end
  self.tipIdList = shuffle(tipsIdListNew)
  self.curTipsIndex = 1
  self:__SetLoadingTips(self.curTipsIndex)
end

function UILoading:__SetLoadingTips(index)
  local tipCfg = ConfigData.loading_tips[self.tipIdList[index]]
  self.ui.tex_Tips.text = LanguageUtil.GetLocaleText(tipCfg.text)
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(tipCfg.title)
  if string.IsNullOrEmpty(tipCfg.pic_path) then
    self.ui.bG.texture = self.defaultBg
  else
    if self.curBgPath ~= tipCfg.pic_path then
      self.ui.bG.texture = self.defaultBg
      self.bgResLoader:Put2Pool()
      self.bgResLoader = cs_ResLoader.Create()
      self.curBgPath = tipCfg.pic_path
    end
    local path = PathConsts:GetImagePath(tipCfg.pic_path)
    if self.__isFirstLoad then
      self.ui.bG.texture = self.bgResLoader:LoadABAsset(path)
    else
      self.bgResLoader:LoadABAssetAsync(path, function(texture)
        self.ui.bG.texture = texture
      end)
    end
  end
end

function UILoading:__ChangeLoadingTips(add)
  self.curTipsIndex = self.curTipsIndex + (add and 1 or -1)
  local maxNum = #self.tipIdList
  if self.curTipsIndex <= 0 then
    self.curTipsIndex = maxNum
  elseif maxNum < self.curTipsIndex then
    self.curTipsIndex = 1
  end
  self:__SetLoadingTips(self.curTipsIndex)
end

function UILoading:_OnClickLeft()
  self:__ChangeLoadingTips(false)
end

function UILoading:_OnClickRight()
  self:__ChangeLoadingTips(true)
end

function UILoading:OnShow()
  self.ui.progressNode:SetActive(false)
  if self.__isInitShow then
    self.__isInitShow = false
    self.ui.loadingTipsNode:SetActive(false)
  else
    self.__isFirstLoad = true
    self:__InitLoadingTips(self.__systemId)
    self.ui.loadingTipsNode:SetActive(true)
    self.__isFirstLoad = false
  end
  base.OnShow(self)
end

function UILoading:OnHide()
  self.__systemId = nil
  self.ui.loadingTipsNode:SetActive(false)
  base.OnHide(self)
end

function UILoading:RefreshSceneProgress(value)
  self.ui.progressNode:SetActive(true)
  local p = value * 100
  self.ui.img_Bar.fillAmount = value
  self.ui.tex_Info:SetIndex(0, tostring(Mathf.Ceil(p)))
end

function UILoading:OnDelete()
  self.bgResLoader:Put2Pool()
  self.bgResLoader = nil
  MsgCenter:RemoveListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
  base.OnDelete(self)
end

return UILoading
