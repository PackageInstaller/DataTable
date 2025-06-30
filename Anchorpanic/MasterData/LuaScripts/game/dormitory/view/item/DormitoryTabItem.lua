module("dormitory.DormitoryTabItem", Class.impl("lib.component.ArcScrollBaseItem"))

function initData(self)
    super.initData(self)
    self.mBtnNomal = self:getChildGO("mBtnNomal")
    self.mBtnSelect = self:getChildGO("mBtnSelect")

    self.mTxtNomalEn = self:getChildGO("mTxtNomalEn"):GetComponent(ty.Text)
    self.mTxtSelectEn = self:getChildGO("mTxtSelectEn"):GetComponent(ty.Text)

    self.mTxtNomal = self:getChildGO("mTxtNomal"):GetComponent(ty.Text)
    self.mTxtSelect = self:getChildGO("mTxtSelect"):GetComponent(ty.Text)
    self.redPoint = self:getChildGO("redPoint")

    self.mImgNomalIcon = self:getChildGO("mImgNomalIcon"):GetComponent(ty.AutoRefImage)
    self.mImgSelectIcon = self:getChildGO("mImgSelectIcon"):GetComponent(ty.AutoRefImage)
end

function onUpdate(self)
    self.mTxtNomalEn.text = self.data.nomalLanEn
    self.mTxtSelectEn.text = self.data.nomalLanEn

    self.mTxtNomal.text = _TT(self.data.nomalLanId)
    self.mTxtSelect.text = _TT(self.data.nomalLanId)

    self.mImgNomalIcon:SetImg(self.data.nomalIcon or "")
    self.mImgSelectIcon:SetImg(self.data.nomalIcon or "")
end

function onSelect(self)
    if not self.mBtnSelect.activeSelf then
        self.mBtnNomal:SetActive(false)
        self.mBtnSelect:SetActive(true)
    end
end

function onNormal(self)
    if not self.mBtnNomal.activeSelf then
        self.mBtnNomal:SetActive(true)
        self.mBtnSelect:SetActive(false)
    end
end

function UpdateRedState(self,state)
    self.redPoint:SetActive(state)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
