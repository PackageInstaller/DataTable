local UIUserNameCreate = class("UIUserNameModify", UIBaseWindow)
local base = UIBaseWindow
local LotteryRtUtil = require("Game.Lottery.UI.LotteryRtUtil")
local cs_RenderTextureFormat = CS.UnityEngine.RenderTextureFormat
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")

function UIUserNameCreate:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_RandomName, self, self.OnclickRandomNameBtn)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickCreateUserConfirm)
  UIUtil.AddButtonListener(self.ui.btn_boy, self, self.OnClickBoySex)
  UIUtil.AddButtonListener(self.ui.btn_girl, self, self.OnClickGrilSex)
  self.isGril = PlayerDataCenter.inforData:GetSex()
  local maxInputNum = ConfigData.game_config.playerNameLengthLimit
  self.characterLimit = maxInputNum
  self.ui.input_UserName.characterLimit = maxInputNum
  self:initModel()
  self:RefreshPannel()
end

function UIUserNameCreate:InitUIUserNameCreate()
  self.ui.tex_text:SetIndex(0, tostring(self.characterLimit))
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and ControllerManager:GetController(ControllerTypeId.HomeController):IsNormalState() then
    self._needChangeHomeState = true
    homeWin:OpenOtherCoverWin()
  end
end

function UIUserNameCreate:initModel()
  GameGlobalUtil.InitCustomLightingGlobalValue()
  local isSupARGBHalf = LotteryRtUtil.SupportsRenderTextures(cs_RenderTextureFormat.ARGBHalf)
  for index, go in ipairs(self.ui.modelViews) do
    go:SetActive(isSupARGBHalf)
  end
  if not isSupARGBHalf then
    return
  end
  self.male_texture = LotteryRtUtil.GetARGBHalfRtTemporary(143, 241, 24)
  self.ui.boy_ImgCamera.texture = self.male_texture
  self.ui.boy_ImgCamera.gameObject:SetActive(true)
  self.ui.boy_camera.targetTexture = self.male_texture
  self:__InitModelTranform(self.ui.dmodel_professor)
  self.female_texture = LotteryRtUtil.GetARGBHalfRtTemporary(143, 241, 24)
  self.ui.gril_ImgCamera.texture = self.female_texture
  self.ui.gril_ImgCamera.gameObject:SetActive(true)
  self.ui.gril_camera.targetTexture = self.female_texture
  self:__InitModelTranform(self.ui.dmodel_professor_boy)
end

function UIUserNameCreate:__InitModelTranform(model)
  if model ~= nil then
    model.transform.localPosition = CS.UnityEngine.Vector3(0, -0.5, 0)
    model.transform.rotation = CS.UnityEngine.Vector3(0, 180, 0)
  end
end

function UIUserNameCreate:OnClickBoySex()
  self.isGril = false
  self:RefreshPannel()
end

function UIUserNameCreate:OnClickGrilSex()
  self.isGril = true
  self:RefreshPannel()
end

function UIUserNameCreate:RefreshPannel()
  if self.isGril then
    self.ui.canvas_boy.alpha = 0.4
    self.ui.canvas_girl.alpha = 1
    local var = self.ui.obj_Select.transform.anchoredPosition
    self.ui.obj_Select.transform:SetParent(self.ui.btn_girl.transform)
    self.ui.obj_Select.transform.anchoredPosition = var
  else
    self.ui.canvas_boy.alpha = 1
    self.ui.canvas_girl.alpha = 0.4
    local var = self.ui.obj_Select.transform.anchoredPosition
    self.ui.obj_Select.transform:SetParent(self.ui.btn_boy.transform)
    self.ui.obj_Select.transform.anchoredPosition = var
  end
  self.ui.gril_Ring:SetActive(self.isGril)
  self.ui.boy_Ring:SetActive(not self.isGril)
  self.ui.boy_Icon:SetActive(self.isGril)
  self.ui.gril_Icon:SetActive(not self.isGril)
end

function UIUserNameCreate:BindUIUserNameAction(nextAction)
  self.nextAction = nextAction
end

function UIUserNameCreate:OnclickRandomNameBtn()
  self.ui.input_UserName.text = self:GengrateRandomName()
end

function UIUserNameCreate:GengrateRandomName()
  local famulyName = require("LuaConfigs.player_familyName")
  local firstName = require("LuaConfigs.player_firstName")
  math.randomseed(os.time())
  local num1 = math.random(#famulyName)
  local num2 = math.random(#firstName)
  local arg1 = LanguageUtil.GetLocaleText(famulyName[num1].family_name)
  local arg2 = LanguageUtil.GetLocaleText(firstName[num2].first_name)
  return arg1 .. arg2
end

function UIUserNameCreate:OnClickCreateUserConfirm()
  local inputUserName = self.ui.input_UserName.text
  if string.IsNullOrEmpty(inputUserName) then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(53))
    return
  end
  local inputLength = RenameHelper:GetNameLength(inputUserName)
  if inputLength > self.characterLimit then
    inputUserName = RenameHelper:ClampNameInLength(inputUserName, self.characterLimit)
    self.ui.input_UserName.text = inputUserName
    return
  end
  if self.isGril ~= PlayerDataCenter.inforData:GetSex() then
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_SexMod(self.isGril)
  end
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_UserNameModify(inputUserName, function()
    self:Delete()
    if self.nextAction ~= nil then
      self.nextAction()
    end
  end)
end

function UIUserNameCreate:OnDelete()
  if self.modelResloader ~= nil then
    self.modelResloader:Put2Pool()
    self.modelResloader = nil
  end
  if self.male_texture ~= nil then
    self.ui.boy_camera.targetTexture = nil
    self.ui.boy_ImgCamera.texture = nil
    LotteryRtUtil.ReleaseTemporaryAndDestory(self.male_texture)
    self.male_texture = nil
  end
  if self.female_texture ~= nil then
    self.ui.gril_camera.targetTexture = nil
    self.ui.gril_ImgCamera.texture = nil
    LotteryRtUtil.ReleaseTemporaryAndDestory(self.female_texture)
    self.female_texture = nil
  end
  self.ui.gril_camera.gameObject:SetActive(false)
  self.ui.gril_ImgCamera.gameObject:SetActive(false)
  self.ui.boy_camera.gameObject:SetActive(false)
  self.ui.boy_ImgCamera.gameObject:SetActive(false)
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil and self._needChangeHomeState then
    self._needChangeHomeState = false
    homeWin:BackFromOtherCoverWin()
  end
  base.OnDelete(self)
end

return UIUserNameCreate
