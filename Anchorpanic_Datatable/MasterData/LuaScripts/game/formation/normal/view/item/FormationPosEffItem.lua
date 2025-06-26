module("formation.FormationPosEffItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("formation/item/FormationPosEffItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)
    self.mTxtPosEffDes = self:getChildGO("mTxtPosEffDes"):GetComponent(ty.Text)
    --self.mBgPosEffColor = self:getChildGO("mBgPosEffColor"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mImgSkillBg = self:getChildGO("mImgSkillBg"):GetComponent(ty.AutoRefImage)
    self.mImgSkillIcon = self:getChildGO("mImgSkillIcon"):GetComponent(ty.AutoRefImage)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData

    self:updateView()
end

function updateView(self)
    local skillVo = fight.SkillManager:getSkillRo( self.mData.effSkillId)
    self.mTxtPosEffDes.text = skillVo:getDesc()
    self.mTxtTitle.text = skillVo:getName()
    self.mImgSkillIcon:SetImg(UrlManager:getIconPath("posEff/".. self.mData.icon),false)
    --self.mImgSkillBg:SetImg(UrlManager:getCommon5Path( self.mData.backGround),false)
end

return _M
