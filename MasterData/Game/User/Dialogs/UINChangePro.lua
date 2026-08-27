local UINChangePro = class("UINChangePro", UIBaseNode)
local base = UIBaseNode
local LotteryRtUtil = require("Game.Lottery.UI.LotteryRtUtil")
local cs_RenderTextureFormat = CS.UnityEngine.RenderTextureFormat
local cs_Shader = CS.UnityEngine.Shader
local cs_Vector4 = CS.UnityEngine.Vector4

function UINChangePro:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Male, self, self.OnClickBoySex)
  UIUtil.AddButtonListener(self.ui.btn_Female, self, self.OnClickGrilSex)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.Close)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.Confirm)
  self.isGril = PlayerDataCenter.inforData:GetSex()
  self:initModel()
end

function UINChangePro:initModel()
  local isSupARGBHalf = LotteryRtUtil.SupportsRenderTextures(cs_RenderTextureFormat.ARGBHalf)
  for index, go in ipairs(self.ui.modelViews) do
    go:SetActive(isSupARGBHalf)
  end
  for index, go in ipairs(self.ui.picViews) do
    go:SetActive(not isSupARGBHalf)
  end
  if not isSupARGBHalf then
    return
  end
  self.male_texture = LotteryRtUtil.GetARGBHalfRtTemporary(345, 420, 24)
  self.ui.male_ImgCamera.texture = self.male_texture
  self.ui.male_ImgCamera.gameObject:SetActive(true)
  self.ui.male_Camera.targetTexture = self.male_texture
  self.female_texture = LotteryRtUtil.GetARGBHalfRtTemporary(345, 420, 24)
  self.ui.female_ImgCamera.texture = self.female_texture
  self.ui.female_ImgCamera.gameObject:SetActive(true)
  self.ui.female_Camera.targetTexture = self.female_texture
end

function UINChangePro:OnClickBoySex()
  self.isGril = false
  self:RefreshPannel()
end

function UINChangePro:OnClickGrilSex()
  self.isGril = true
  self:RefreshPannel()
end

function UINChangePro:_ShowUI()
  self:Show()
  self:RefreshPannel()
  self:__SetCharacterLight()
end

function UINChangePro:RefreshPannel()
  if self.isGril then
    self.ui.img_Male.color = self.ui.color_unselect
    self.ui.img_Female.color = self.ui.color_select
    self.ui.male_Ring:SetActive(not self.isGril)
    self.ui.female_Ring:SetActive(self.isGril)
    self.ui.boy_unSelect.gameObject:SetActive(true)
    self.ui.boy_Select.gameObject:SetActive(false)
    self.ui.gril_unSelect.gameObject:SetActive(false)
    self.ui.gril_Select.gameObject:SetActive(true)
  else
    self.ui.img_Male.color = self.ui.color_select
    self.ui.img_Female.color = self.ui.color_unselect
    self.ui.male_Ring:SetActive(not self.isGril)
    self.ui.female_Ring:SetActive(self.isGril)
    self.ui.boy_unSelect.gameObject:SetActive(false)
    self.ui.boy_Select.gameObject:SetActive(true)
    self.ui.gril_unSelect.gameObject:SetActive(true)
    self.ui.gril_Select.gameObject:SetActive(false)
  end
end

function UINChangePro:__SetCharacterLight()
  cs_Shader.SetGlobalVector(cs_Shader.PropertyToID("_CustomLightDir"), cs_Vector4(0.0, 0.5, -0.8, 1.0))
  cs_Shader.SetGlobalColor(cs_Shader.PropertyToID("_GlobalCharColor"), Color.white)
end

function UINChangePro:BindCloseFun(CloseFun)
  self.closeFun = CloseFun
end

function UINChangePro:Close()
  if self.closeFun ~= nil then
    self.closeFun()
  end
end

function UINChangePro:Confirm()
  if self.isGril ~= PlayerDataCenter.inforData:GetSex() then
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_SexMod(self.isGril)
  end
  self:Close()
end

function UINChangePro:OnDelete()
  if self.modelResloader ~= nil then
    self.modelResloader:Put2Pool()
    self.modelResloader = nil
  end
  if self.male_texture ~= nil then
    self.ui.male_Camera.targetTexture = nil
    self.ui.male_ImgCamera.texture = nil
    LotteryRtUtil.ReleaseTemporaryAndDestory(self.male_texture)
    self.male_texture = nil
  end
  if self.female_texture ~= nil then
    self.ui.female_Camera.targetTexture = nil
    self.ui.female_ImgCamera.texture = nil
    LotteryRtUtil.ReleaseTemporaryAndDestory(self.female_texture)
    self.female_texture = nil
  end
  base.OnDelete(self)
end

return UINChangePro
