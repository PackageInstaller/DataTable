--[[ 
-----------------------------------------------------
@filename       : AccRechargePanel
@Description    : 累计充值Item
@date           : 2023-3-23 17:27:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("purchase.AccRechargeItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.GroupPro = self:getChildGO("GroupPro")
    self.mBtnHasRec = self:getChildGO("mBtnHasRec")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mImPro = self:getChildGO("mImPro"):GetComponent(ty.Image)
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mIconProps = self:getChildGO("mIconProps"):GetComponent(ty.AutoRefImage)
    self.mGroupItemCan = self:getChildGO("mGroupItem"):GetComponent(ty.CanvasGroup)
    self.mItemList = {}
    self:addOnClick(self.mBtnGet, self.onClickGetHadler)
    self:addOnClick(self.mIconProps.gameObject, self.onClickTipsHadler)
end

function setData(self, param)
    super.setData(self, param)
    self.accVo = self.data
    self.mTxtName.text = _TT(50065, self.accVo.getNum * 10)
    local propsList = AwardPackManager:getAwardListById(self.accVo.dropId)
    self:closeItemList()
    for i = 2, #propsList do
        local propsItem = PropsGrid:create(self.mAwardContent, propsList[i], 1)
        table.insert(self.mItemList, propsItem)
    end
    self.mPropVo = props.PropsManager:getPropsConfigVo(propsList[1].tid)
    self.mTxtDes.text = self.mPropVo.name .. "X" .. propsList[1].num
    self.mIconProps:SetImg(UrlManager:getPropsIconUrl(propsList[1].tid), true)
    self.canGet = purchase.AccRechargeManager:getAccPlyNum() >= self.accVo.getNum
    self.mBtnHasRec:SetActive(purchase.AccRechargeManager:hasGeted(self.accVo.id))
    self.mGroupItemCan.alpha = (self.mBtnHasRec.activeSelf == true) and 0.6 or 1
    self.mBtnGet:SetActive(((self.mBtnHasRec.activeSelf == false) and self.canGet))
    self.GroupPro:SetActive(((self.mBtnGet.activeSelf == false) and (self.mBtnHasRec.activeSelf == false)))
    self.mImPro.fillAmount = self.canGet and 1 or purchase.AccRechargeManager:getAccPlyNum() / self.accVo.getNum
    self.mTxtPro.text = _TT(45013, HtmlUtil:color(purchase.AccRechargeManager:getAccPlyNum() * 10, "1271ffff"), self.accVo.getNum * 10)
end

function onClickGetHadler(self)
    if self.canGet then
        GameDispatcher:dispatchEvent(EventName.GET_ACCAWARD, { id = self.accVo.id })
    else
        gs.Message.Show(_TT(50006))
    end
end

function onClickTipsHadler(self)
    local rect = self.mIconProps.gameObject.transform
    if (self.mPropVo.type ~= PropsType.EQUIP) then
        TipsFactory:propsTips({ propsVo = self.mPropVo, isShowUseBtn = nil }, { rectTransform = rect })
    end
end

function closeItemList(self)
    if #self.mItemList > 0 then
        for _, item in ipairs(self.mItemList) do
            item:poolRecover()
            item = nil
        end
        self.mItemList = {}
    end
end

function deActive(self)
    super.deActive(self)
    self:closeItemList()
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mBtnGet)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(50006):	"并未达到条件,不能获取奖励"
]]