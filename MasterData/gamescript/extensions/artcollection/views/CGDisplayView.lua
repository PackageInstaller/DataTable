local Vector3 = CS.UnityEngine.Vector3
local T_RawImage = typeof(CS.UnityEngine.UI.RawImage)
local Texture2D = CS.UnityEngine.Texture2D
local TextureFormat = CS.UnityEngine.TextureFormat
local CGDisplayView, Super = NewClass("CGDisplayView", BaseView)
CGDisplayView.uiResCls = UI_Collection_Panel_SetMainBgResource

function CGDisplayView:ctor(cfgId)
  Super.ctor(self)
  self.curDisplayId = cfgId
  self.curIndex = 0
  self.cgList = {}
  self.isShowAwaker = true
end

function CGDisplayView:OnBuildView()
  Super.OnBuildView(self)
  self.ui.Content_Preview:SetActive(true)
  self.ui.Btn_Comment:SetActive(true)
  self.ui.Content_Preview:SetActive(false)
  self:BuildCGList(self.curDisplayId)
  self:CreateRenderCG()
  self:RefreshView()
end

function CGDisplayView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_SetMainCG, System.fn(self, self.OnClickSetBg))
  self:AddButtonClickListener(self.ui.Btn_DownLoadCG, System.fn(self, self.OnClickDownLoadCG))
  self:AddButtonClickListener(self.ui.Btn_Save, System.fn(self, self.OnClickSave))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancel))
  self:AddButtonClickListener(self.ui.Btn_Next, System.fn(self, self.OnClickNext))
  self:AddButtonClickListener(self.ui.Btn_Before, System.fn(self, self.OnClickBefore))
  self:AddButtonClickListener(self.ui.Btn_FullScreen, System.fn(self, self.OnBtnFullScreen))
  self:AddButtonClickListener(self.ui.Btn_ShowContent, System.fn(self, self.OnBtnShowContent))
  self:AddButtonClickListener(self.ui.Btn_Awaker_Active, System.fn(self, self.OnClickBtnAwakerActive))
  self:AddButtonClickListener(self.ui.Btn_Comment, System.fn(self, self.OnClickBtnComment))
  self:AddViewComponent(self.ui.UI_Common_Btn_Back2, UICompBtnCloseItem, System.fn(self, self.Close))
end

function CGDisplayView:OnClickBtnComment()
  local viewData = {
    commentId = self.curDisplayId
  }
  CommentController.Instance:OpenCommentListView(viewData)
end

function CGDisplayView:RegisterNotifications()
end

function CGDisplayView:BuildCGList(cfgId)
  local cgList = {}
  local curCfg = DT.CollectionHall[cfgId]
  local CollectionType = curCfg.CollectionType
  for id, cfg in pairs(DT.CollectionHall) do
    if not string.isempty(cfg.Picture) and cfg.CollectionType == CollectionType and ArtCollectionModel.Instance:IsUnlock(id) and ArtCollectionModel.Instance:IsItemUnlocked(id) then
      table.insert(cgList, id)
    end
  end
  table.sort(cgList, function(ida, idb)
    local idaCfg = DT.CollectionHall[ida]
    local idbCfg = DT.CollectionHall[idb]
    return idaCfg.BaseSortID < idbCfg.BaseSortID
  end)
  local curIndex = 1
  for index, id in ipairs(cgList) do
    if id == self.curDisplayId then
      curIndex = index
      break
    end
  end
  self.cgList = cgList
  self.curIndex = curIndex
end

function CGDisplayView:RefreshView()
  local collectCfg = DT.CollectionHall[self.curDisplayId]
  if not collectCfg then
    return
  end
  if collectCfg.ActivityType then
    self:ShowActivityPrefab(collectCfg.ActivityType)
  elseif collectCfg.Picture then
    self:SetImageSync(self.ui.Image_CG, collectCfg.Picture, true)
    self.imgRectTrans = self.imgRectTrans or self.ui.Image_CG:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local sizeDelta = self.imgRectTrans.sizeDelta
    local w, h = ArtCollectionController.Instance:ResizeWidthAndHeight(sizeDelta.x, sizeDelta.y)
    sizeDelta.x = w
    sizeDelta.y = h
    self.imgRectTrans.sizeDelta = sizeDelta
    self:ChangeRenderCG()
  end
  if ArtCollectionModel.Instance:IsBg(self.curDisplayId) then
    self:SetButtonState(self.ui.Btn_SetMainCG, cd.Z1ButtonState.High)
  else
    self:SetButtonState(self.ui.Btn_SetMainCG, cd.Z1ButtonState.Normal)
  end
  self.ui.Group_Hide_Awaker:SetActive(not self:IsAllowShowAwaker())
  self.ui.Btn_Awaker_Active:SetActive(self:IsAllowShowAwaker())
  self.ui.Container_Awaker:SetActive(self:IsAllowShowAwaker() and self.isShowAwaker)
  if self:IsAllowShowAwaker() and not self.awakerPortrait then
    self:CreateAwakerPortrait()
  end
  self.ui.Btn_Next:SetActive(true)
  self.ui.Btn_Before:SetActive(true)
  self.ui.Content_LoginPV:SetActive(false)
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, self.curDisplayId)
end

function CGDisplayView:ShowActivityPrefab(actType)
  local activityDefine = ActivityDefine.ActivityCompClsInfo[actType]
  if not activityDefine or not activityDefine.resPath then
    return
  end
  if self.activityComp then
    self.activityComp.binder:teardown()
  end
  local isPlayMusic = true
  UIManager.Instance:CloseByUrl(Urls.MainPanel)
  self.activityComp = self.binder:BindNewComponent(self.ui.Image_CG, CGActivityComp, activityDefine.resPath, activityDefine, isPlayMusic)
  self:ChangeRenderCG()
end

function CGDisplayView:IsAllowShowAwaker()
  do return ArtCollectionModel.Instance.IsAllowShowAwaker, ArtCollectionModel.Instance end
  return ArtCollectionModel.Instance.IsAllowShowAwaker, ArtCollectionModel.Instance, self.curDisplayId
end

function CGDisplayView:CreateAwakerPortrait()
  local extParams = {animationMode = true}
  local model = self.binder:createModel(MainPanelModel, self.ui)
  local resNum = AwakerDataUtils.GetAwakerResNum(model.showAwakerTid)
  self.awakerPortrait = self.binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, nil, resNum, nil, nil, extParams))
  PortraitManager.Instance:AddAwakerPortrait(self.awakerPortrait)
end

function CGDisplayView:CreateRenderCG()
  local prefab = self:LoadAsset("UI/UI_Collection/UI_Collection_CG.prefab")
  self.cgGo = self:Instantiate(prefab)
  self.LuaBakeRenderTexture = AddLuaCompOnce(self.cgGo.transform:GetChild(0), LuaBakeRenderTexture)
  self.LuaBakeRenderTexture:SetTarget(self.ui.Image_RT)
  local cameraPos = Vector3(0, 0, -2)
  local targetImgPos = Vector3(0, 0, 0)
  local targetImgScale = Vector3(1, 1, 1)
  local orthographicSize = 40.3
  self.LuaBakeRenderTexture:SetTargetImageInfo(targetImgPos, targetImgScale, cameraPos, orthographicSize)
end

function CGDisplayView:ChangeRenderCG()
  local collectCfg = DT.CollectionHall[self.curDisplayId]
  if self.cgGo and collectCfg and collectCfg.Picture then
    local material = self.cgGo:GetComponentInChildren(typeof(CS.UnityEngine.MeshRenderer)).material
    local sprite = self:LoadAsset(collectCfg.Picture)
    if sprite then
      material:SetTexture("_MainTex", sprite.texture)
    end
  end
  local rawImgCom = self.ui.Image_RT.gameObject:GetComponent(typeof(T_RawImage))
  if rawImgCom.texture then
    local tex = Texture2D(rawImgCom.texture.width, rawImgCom.texture.height, TextureFormat.RGBA32, false)
    local prev = CS.UnityEngine.RenderTexture.active
    CS.UnityEngine.RenderTexture.active = rawImgCom.texture
    tex:ReadPixels(CS.UnityEngine.Rect(0, 0, rawImgCom.texture.width, rawImgCom.texture.height), 0, 0)
    tex:Apply()
    CS.UnityEngine.RenderTexture.active = prev
  end
end

function CGDisplayView:OnClickSetBg()
  if ArtCollectionModel.Instance:IsBg(self.curDisplayId) then
    CollectionHallCfgUtils.ResetMainBgCG()
    return
  end
  self.ui.Content_Preview:SetActive(not self.ui.Content_Preview.activeSelf)
  self.ui.Btn_SetMainCG:SetActive(not self.ui.Content_Preview.activeSelf)
  self.ui.Btn_Comment:SetActive(not self.ui.Content_Preview.activeSelf)
  self.ui.Btn_DownLoadCG:SetActive(false)
  self.ui.UI_Common_Btn_Back2:SetActive(not self.ui.UI_Common_Btn_Back2.activeSelf)
end

function CGDisplayView:OnClickDownLoadCG()
  local rawImgCom = self.ui.Image_RT.gameObject:GetComponent(typeof(T_RawImage))
  if rawImgCom.texture then
    local tex = Texture2D(rawImgCom.texture.width, rawImgCom.texture.height, TextureFormat.RGBA32, false)
    local prev = CS.UnityEngine.RenderTexture.active
    CS.UnityEngine.RenderTexture.active = rawImgCom.texture
    tex:ReadPixels(CS.UnityEngine.Rect(0, 0, rawImgCom.texture.width, rawImgCom.texture.height), 0, 0)
    tex:Apply()
    CS.UnityEngine.RenderTexture.active = prev
    if SteamSdk.Instance:IsSteam() or ApplicationUtils.IsWindowsOrEditor() then
      local savePath = SdkMgr.Instance:GetShare():SaveTex_2_PersistentData(tex)
      local tipsId = CS.System.IO.FileInfo(savePath).Exists and 10723 or 10724
      Alert.Show(tipsId)
    else
      SdkMgr.Instance:GetShare():SaveTex_2_PhoneAlbum(tex)
    end
  end
end

function CGDisplayView:OnBtnFullScreen()
  self.ui.Content_CG:SetActive(false)
end

function CGDisplayView:OnBtnShowContent()
  self.ui.Content_CG:SetActive(true)
end

function CGDisplayView:OnClickBtnAwakerActive()
  local isShow = not self.isShowAwaker
  self.isShowAwaker = isShow
  self.ui.Container_Awaker:SetActive(isShow)
  self.ui.Group_Hide:SetActive(isShow)
  self.ui.Group_Display:SetActive(not isShow)
end

function CGDisplayView:OnClickSave()
  ClientDataUtils.SetData(cd.ClientDataMainKey.AVG, "MainBgTid", self.curDisplayId)
  self:BackToMainPanel()
end

function CGDisplayView:BackToMainPanel()
  SceneMgr.Instance:EnterTown(true)
end

function CGDisplayView:OnClickCancel()
  self:OnClickSetBg()
end

function CGDisplayView:OnClickNext()
  if self.curIndex < #self.cgList then
    self.curIndex = self.curIndex + 1
  else
    self.curIndex = 1
  end
  self.curDisplayId = self.cgList[self.curIndex]
  self:RefreshView()
end

function CGDisplayView:OnClickBefore()
  if self.curIndex > 1 then
    self.curIndex = self.curIndex - 1
  else
    self.curIndex = #self.cgList
  end
  self.curDisplayId = self.cgList[self.curIndex]
  self:RefreshView()
end

function CGDisplayView:OnSwip(direction)
  if direction == cd.SwipeDirection.SwipeLeftToRight then
    self:OnClickBefore()
  end
  if direction == cd.SwipeDirection.SwipeRightToLeft then
    self:OnClickNext()
  end
end

return CGDisplayView
