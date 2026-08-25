local ActivityLilyComp, Super = System.NewClass("ActivityLilyComp", ActivityMagicStoryComp)
local UIAnimationController = CS.Z1Client.UIAnimationController
local T_PlayableDirector = typeof(CS.UnityEngine.Playables.PlayableDirector)

function ActivityLilyComp:ctor(res, activityTid, model, params)
  self.ui = UI_Events_Panel_LilyResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.resonanceGroupId = CommonDefine.LilyResonance
  self.produceTid = ActivityDataUtils.GetProduceTid(self.activityTid)
  self.hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  self.audioPlay = true
  if params then
    self.audioPlay = params.audioPlay
  end
  self.playableDirector = self.ui.uiNode:GetComponent(T_PlayableDirector)
end

function ActivityLilyComp:OnBind(binder)
  self.currencyObjList = {
    {
      imgObj = self.ui.Image_Currency_01,
      txtObj = self.ui.Text_Currency_01
    },
    {
      imgObj = self.ui.Image_Currency_02,
      txtObj = self.ui.Text_Currency_02
    },
    {
      imgObj = self.ui.Image_Currency_03,
      txtObj = self.ui.Text_Currency_03
    }
  }
  Super.OnBind(self, binder)
  binder:BindToVisible(self.ui.Image_Homology, function()
    return not ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  end)
end

function ActivityLilyComp:BindShopItem()
  local binder = self.binder
  self.ui.Btn_Shop:SetActive(true)
  local currencyTidList = {}
  local shopTypeList = ShopExtModel.Instance:GetShopTypeListByActivityTid(self.activityTid)
  local currencyTypeCount = 0
  for idx, tid in ipairs(shopTypeList) do
    local shopTypeConfig = ShopExtModel.Instance:GetShopTypeConfig(tid)
    local currencyTid = shopTypeConfig and shopTypeConfig.ShowMoney and shopTypeConfig.ShowMoney[1]
    local objs = self.currencyObjList[idx]
    local currencyIconObj = objs.imgObj
    local currencyTextObj = objs.txtObj
    if currencyIconObj and currencyTextObj then
      table.insert(currencyTidList, currencyTid)
      local isValidCurrency = currencyTid and currencyTid > 0
      currencyIconObj:SetActive(isValidCurrency)
      if isValidCurrency then
        binder:BindToText(currencyTextObj, function()
          do return ItemDataUtils.GetItemNum end
          return ItemDataUtils.GetItemNum, currencyTid
        end)
        binder:SetImageSync(currencyIconObj, ItemDataUtils.GetIcon(currencyTid))
        currencyTypeCount = currencyTypeCount + 1
      end
    end
  end
  for index = currencyTypeCount + 1, #self.currencyObjList do
    local objs = self.currencyObjList[index]
    if objs.imgObj then
      objs.imgObj:SetActive(false)
    end
    if objs.txtObj then
      objs.txtObj:SetActive(false)
    end
  end
  binder:BindToRaw(function(_, nValTbl)
    if not nValTbl then
      return
    end
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Currency)
  end, function()
    local valueTable = {}
    for _, tid in ipairs(currencyTidList) do
      if tid then
        valueTable[tid] = {
          ItemDataUtils.GetItemNum(tid)
        }
      end
    end
    return valueTable
  end)
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    ShopController.Instance:OpenActivityShopView(self.activityTid)
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.Red_Shop, nil, nil, System.fn(self, self._RedFunc)))
end

function ActivityLilyComp:BindAchievementProgress()
  Super.BindAchievementProgress(self)
end

function ActivityLilyComp:BindSubPlotRecord()
  if self.hasFinishedActivity then
    self.ui.Btn_Record:SetActive(false)
    return
  end
  Super.BindSubPlotRecord(self)
end

function ActivityLilyComp:BindBtnChallenge()
  if self.hasFinishedActivity then
    self.ui.Btn_Challenge:SetActive(false)
    return
  end
  self.binder:BindZ1Button(self.ui.Btn_Challenge, function()
    ActivityController.Instance:OpenActivityStageGroupPanel(self.activityData, self.resonanceGroupId)
  end)
  local stageGroupTypeId = self.activityConfig.ActivityPara1[1]
  local stageGroupList = CopyDataUtils.GetStageGroupIdList(stageGroupTypeId)
  self:BindNewStageGroupRed(stageGroupList)
end

function ActivityLilyComp:_RedFunc()
  local shopTypeList = ShopExtModel.Instance:GetShopTypeListByActivityTid(self.activityTid)
  do return RedPointDataUtils.GetShopRedByShopTypes end
  return RedPointDataUtils.GetShopRedByShopTypes, shopTypeList
end

function ActivityLilyComp:OnOpenAnim(callback)
  if self.playableDirector then
    self.playableDirector:Stop()
    self.playableDirector.time = 0
    self.playableDirector:Play()
  end
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(self.audioPlay)
  if not self.audioPlay then
    self.audioPlay = true
  end
end

function ActivityLilyComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_Lily_Close")
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  if self.playableDirector then
    self.playableDirector:Stop()
  end
  callback()
end

return ActivityLilyComp
