--[[ 
-----------------------------------------------------
@filename       : 装备信息弹窗
@Description    : 用于解析服务器返回的数据
@date           : 2022-08-11 11:48:27
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("tips.EquipTipsOtherMin", Class.impl(tips.EquipTipsMin))

function __updateView(self)
    self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
    self:__recoverTxtGoDic()
    self:__recoverBtnGoDic()
    self:__recoverBtnPool()
    self:__updateTop()
    self:__updateBottom()
    self:__updateGuide()
    self:getChildGO("BtnUnLock"):SetActive(false)
    self:getChildGO("BtnLock"):SetActive(false)
end

-- 更新突破附加属性
function __updateTuPoAttachAttr(self)
    self.m_childGos["TextTitleTuPoAttach"]:GetComponent(ty.Text).text = "附加属性"--"附加属性"

    local attachAttrList, attachAttrDic = self.m_equipVo:getTuPoAttachAttr()
    table.sort(attachAttrList, function(a, b)
        return a.breakUpRank < b.breakUpRank
    end)
    if (attachAttrList and #attachAttrList > 0) then
        self.m_childGos["GroupTuPoAttachAttr"]:SetActive(true)

        for i = 1, #attachAttrList do
            local attachAttrVo = attachAttrList[i]
            local itemCloneGo = self:__getTxtGo("TuPoAttachAttrItem")
            itemCloneGo.transform:SetParent(self.m_childTrans["ShowTuPoAttachAttr"], false)
            local textAttr = itemCloneGo.transform:Find("TextTuPoAttachAttr"):GetComponent(ty.Text)
            local textAttrTip = itemCloneGo.transform:Find("TextTuPoAttachAttr/TextTuPoAttachAttrTip").gameObject
            local imgUnLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachUnLockIcon").gameObject
            local imgLockIcon = itemCloneGo.transform:Find("ImgTuPoAttachLockIcon").gameObject
            local mImgTuPoAttachLockState = itemCloneGo.transform:Find("mImgTuPoAttachLockState").gameObject
            mImgTuPoAttachLockState:SetActive(false)
            textAttrTip:SetActive(false)
            textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. HtmlUtil:color("+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "3959d2ff"), ColorUtil.PURE_BLACK_NUM)
        end
    else
        self.m_childGos["GroupTuPoAttachAttr"]:SetActive(false)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowTuPoAttachAttr"]);
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupTuPoAttachAttr"]);
end
-- 更新2件套装属性
function __updateSuit_2(self)
    self.m_childGos["mImgSuitDes2LockState"]:SetActive(false)
    super.__updateSuit_2(self)
end
-- 更新4件套装属性
function __updateSuit_4(self)
    self.m_childGos["mImgSuitDes4LockState"]:SetActive(false)
    super.__updateSuit_4(self)
end


return _M