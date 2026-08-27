local UICommonCollectRes = class("UICommonCollectRes", UIBaseWindow)
local base = UIBaseWindow
local CCRProductionItem = require("Game.CommonUI.CollectRes.UICCRProductionItem")
local cs_DOTween = CS.DG.Tweening.DOTween

function UICommonCollectRes:OnInit()
  self.isDetailState = false
  self.__onSyllabusComplete = BindCallback(self, self.__OnSyllabusComplete)
  self.__onDetailComplete = BindCallback(self, self.__OnDetailComplete)
  self.__onCollectAllAnimaComplete = BindCallback(self, self.__OnCollectAllAnimaComplete)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.__OnCollectAllClick)
  UIUtil.AddButtonListener(self.ui.btn_GetAllSmall, self, self.__OnCollectAllClick)
  UIUtil.AddButtonListener(self.ui.btn_ShowSyllabus, self, self.__OnShowSyllabusClick)
  UIUtil.AddButtonListener(self.ui.btn_ShowDetail, self, self.__OnShowDetailClick)
  self:__SetDetailUI(self.isDetailState)
  self.buildProduction = {}
  self.ProductItemDic = {}
  self.productionItemPool = UIItemPool.New(CCRProductionItem, self.ui.obj_ProductionItem)
  self.ui.obj_ProductionItem:SetActive(false)
  self.CollectResAction = nil
end

function UICommonCollectRes:SetCommonCollectRes(action)
  self.CollectResAction = action
end

function UICommonCollectRes:UpdateProduction(id, resTabSort)
  if self.buildProduction ~= nil then
    if self.buildProduction[id] == nil then
      self.getNewOne = true
    else
      self.getNewOne = false
    end
    self.buildProduction[id] = resTabSort
  end
  self:__UpdateProductionUI()
end

function UICommonCollectRes:__UpdateProductionUI()
  if self.buildProduction == nil then
    return
  end
  if self.isAllClickAnima then
    return
  end
  self.productionItemPool:HideAll()
  for buildId, buildData in pairs(self.buildProduction) do
    if buildData ~= nil then
      for i = 1, #buildData do
        local Item = self.productionItemPool:GetOne()
        if self.getNewOne then
          Item:InitProductionItem(buildId, buildData[i])
        else
          Item:UpdateProductionInfo(buildData[i])
        end
      end
    end
  end
end

function UICommonCollectRes:__OnCollectAllClick()
  if self.buildProduction == nil then
    return
  end
  local sequence = cs_DOTween.Sequence()
  self.fristAppend = true
  for index, item in ipairs(self.productionItemPool.listItem) do
    if self.fristAppend then
      sequence:Append(item:GetRingUI():DOFillAmount(0, self.ui.ringTime))
    else
      sequence:Join(item:GetRingUI():DOFillAmount(0, self.ui.ringTime))
    end
  end
  sequence:AppendCallback(self.__onCollectAllAnimaComplete)
  self.isAllClickAnima = true
  self.CollectAllTween = sequence
end

function UICommonCollectRes:__OnCollectAllAnimaComplete()
  self.isAllClickAnima = false
  if self.CollectResAction ~= nil then
    self.CollectResAction(self.buildProduction)
  end
end

function UICommonCollectRes:__OnShowSyllabusClick()
  if self.isDetailState == false then
    return
  end
  self.isDetailState = false
  self.ui.tween_side.onRewind:AddListener(self.__onSyllabusComplete)
  self.ui.tween_side:DOPlayBackwards()
end

function UICommonCollectRes:__OnSyllabusComplete()
  self.ui.tween_side.onRewind:RemoveListener(self.__onSyllabusComplete)
  self:__SetDetailUI(false)
end

function UICommonCollectRes:__OnShowDetailClick()
  if self.isDetailState == true then
    return
  end
  self.isDetailState = true
  self.ui.tween_side.onComplete:AddListener(self.__onDetailComplete)
  self.ui.tween_side:DORestart()
  self:__SetDetailUI(true)
end

function UICommonCollectRes:__OnDetailComplete()
  self.ui.tween_side.onComplete:RemoveListener(self.__onDetailComplete)
end

function UICommonCollectRes:ShowTween()
  self.ui.tween_fade:DOPlayBackwards()
end

function UICommonCollectRes:HideTween()
  self.ui.tween_fade:DORestart()
end

function UICommonCollectRes:__SetDetailUI(isDetail)
  self.ui.btn_GetAll.gameObject:SetActive(isDetail)
  self.ui.btn_GetAllSmall.gameObject:SetActive(not isDetail)
  self.ui.btn_ShowSyllabus.gameObject:SetActive(isDetail)
  self.ui.btn_ShowDetail.gameObject:SetActive(not isDetail)
  self.ui.obj_Text:SetActive(isDetail)
end

function UICommonCollectRes:OnDelete()
  if not IsNull(self.ui.tween_side) then
    self.ui.tween_side:DOKill()
  end
  if self.CollectAllTween ~= nil then
    self.CollectAllTween:Kill()
    self.CollectAllTween = nil
  end
  base.OnDelete(self)
end

return UICommonCollectRes
