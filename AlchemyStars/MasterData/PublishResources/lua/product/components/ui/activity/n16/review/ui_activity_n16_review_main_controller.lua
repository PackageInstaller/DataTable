_class("UIActivityN16ReviewMainController", UIController)
UIActivityN16ReviewMainController = UIActivityN16ReviewMainController

function UIActivityN16ReviewMainController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN16ReviewMainController:_PlayAnim(widgetName, animName, time, callback)
  local anim = self:GetUIComponent("Animation", widgetName)
  self:Lock(animName)
  anim:Play(animName)
  self:StartTask(function(TT)
    YIELD(TT, time)
    self:UnLock(animName)
    if callback then
      callback()
    end
  end, self)
end

function UIActivityN16ReviewMainController:_InitWidget()
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIActivityReview)
  end, nil, nil, false, function()
    self:HideBtnOnClick()
  end)
  local progress = UIReviewProgressConst.SpawnObject(self, "_progress", self._reviewData)
end

function UIActivityN16ReviewMainController:_SetProgressData(TT, res)
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  self._reviewData = uiModule:GetReviewData():GetActivityByType(ECampaignType.CAMPAIGN_TYPE_REVIEW_N16)
  self._reviewData:ReqDetailInfo(TT, res)
end

function UIActivityN16ReviewMainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_REVIEW_N16
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignReviewN16ComponentID.ECAMPAIGN_REVIEW_ReviewN16_LINE_MISSION, ECampaignReviewN16ComponentID.ECAMPAIGN_REVIEW_ReviewN16_POINT_PROGRESS)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self:_SetProgressData(TT, res)
end

function UIActivityN16ReviewMainController:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN16.spriteatlas", LoadType.SpriteAtlas)
  self._isOpen = true
  self:_InitWidget()
  self:_SetSpine()
  self:_Refresh()
  self.imgRT = uiParams[1]
  local entermodel = "uieffanim_N16_main_show"
  if self.imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = self.imgRT
    entermodel = "uieffanim_N16_main_show"
    self:_PlayAnim("_anim", entermodel, 1667)
    CutsceneManager.ExcuteCutsceneOut()
  else
    entermodel = "uieffanim_N16_main_in"
    self:_PlayAnim("_anim", entermodel, 1667)
  end
end

function UIActivityN16ReviewMainController:OnHide()
  self._isOpen = false
end

function UIActivityN16ReviewMainController:_Refresh()
  self:_SetLineMissionBtn()
end

function UIActivityN16ReviewMainController:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    self._mainBg:LoadImage(url)
  end
end

function UIActivityN16ReviewMainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n16_kv_1_spine_idle")
end

function UIActivityN16ReviewMainController:_SetLineMissionBtn()
  local componentId = ECampaignReviewN16ComponentID.ECAMPAIGN_REVIEW_ReviewN16_LINE_MISSION
  local obj = self:_SpawnObject("_lineMissionBtn", "UIActivityCommonComponentEnterLock")
  local tb = {
    {"state_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:SwitchState(UIStateType.UIActivityN16ReviewLineMissionController)
  end)
  local img = obj.view:GetUIComponent("Image", "bgstate")
  img.sprite = self._atlas:GetSprite("n16_zjm_di2")
  local text = obj.view:GetUIComponent("UILocalizationText", "txt")
  text.transform:GetComponent("Outline").enabled = true
  text.color = Color.New(0.796078431372549, 0.6901960784313725, 0.35294117647058826)
end

function UIActivityN16ReviewMainController:ShowBtnOnClick()
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(false)
  self:_PlayAnim("_anim", "uieffanim_UIActivityN16ReviewMainController_show", 500)
end

function UIActivityN16ReviewMainController:HideBtnOnClick()
  local showBtn = self:GetGameObject("_showBtn")
  showBtn:SetActive(true)
  self:_PlayAnim("_anim", "uieffanim_UIActivityN16ReviewMainController_hide", 500)
end

function UIActivityN16ReviewMainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN16ReviewMainController:_GetRoleId()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  return pstId
end

function UIActivityN16ReviewMainController:_SetMainTex()
  local rawImage = self:GetUIComponent("RawImage", "TitleImg_RawImage")
  local obj = self:GetGameObject("TitleImg")
  local meshRender = obj:GetComponent(typeof(UnityEngine.MeshRenderer))
  meshRender.material:SetTexture("_MainTex", rawImage.material:GetTexture("_MainTex"))
end
