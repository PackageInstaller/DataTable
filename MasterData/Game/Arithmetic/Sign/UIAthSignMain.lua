local base = UIBaseWindow
local UIAthSignMain = class("UIAthSignMain", base)
local UINAthSignDetail = require("Game.Arithmetic.Sign.UINAthSignDetail")
local SkinEnum = require("Game.Skin.SkinEnum")
local cs_ResLoader = CS.ResLoader

function UIAthSignMain:OnInit()
  UIUtil.AddButtonListener(self.ui.background, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  self.detailNode = UINAthSignDetail.New(self)
  self.detailNode:Init(self.ui.aTHDetailItem)
end

function UIAthSignMain:InitAthSignMain(athData, heroData)
  self.athData = athData
  self.heroData = heroData
  self:_LoadHeroPic(heroData:GetResPicName())
  self.ui.tex_Name.text = heroData:GetName()
  self.detailNode:InitAthSignDetail(athData)
end

function UIAthSignMain:_LoadHeroPic(resPicName)
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
  end
  self.bigImgResloader = cs_ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resPicName, SkinEnum.fromWhere.heroInfoAndHandbook), function(prefab)
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(self.ui.picHolder)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end)
end

function UIAthSignMain:ReqAthSign(lockAttrIdx)
  UIManager:ShowWindow(UIWindowTypeID.MessageCommon):ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(21002), self.heroData:GetName()), function()
    local uid = self.athData:GetAthDataUID()
    NetworkManager:GetNetwork(NetworkTypeID.Arithmetic):CS_ATH_Sign(uid, self.heroData.dataId, lockAttrIdx - 1, function()
      self:Delete()
    end)
  end, nil, true)
end

function UIAthSignMain:_OnClickClose()
  self:Delete()
end

function UIAthSignMain:OnDelete()
  self.detailNode:Delete()
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  base.OnDelete(self)
end

return UIAthSignMain
