--[[ 
-----------------------------------------------------
@filename       : GradeGiftView
@Description    : 等级礼包
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.GradeGiftView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath('purchase/GradeGiftView.prefab')
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mAwardListL = {}
    self.mAwardListR = {}
    self.mNomalVo = nil
    self.mSeniorVo = nil
end

function configUI(self)
    super.configUI(self)
    self.mImGlow = self:getChildGO("mImGlow")
    self.mImgLockLeft = self:getChildGO("mImgLockLeft")
    self.mImgLockRight = self:getChildGO("mImgLockRight")
    self.mAwardTransL = self:getChildTrans("mAwardTransL")
    self.mAwardTransR = self:getChildTrans("mAwardTransR")
    self.mAwardTransRC = self:getChildTrans("mAwardTransRC")
    self.mAwardTransLC = self:getChildTrans("mAwardTransLC")
    self.mTxtCoinR = self:getChildGO("mTxtCoinR"):GetComponent(ty.Text)
    self.mTxtTitleR = self:getChildGO("mTxtTitleR"):GetComponent(ty.Text)
    self.mTxtTitleL = self:getChildGO("mTxtTitleL"):GetComponent(ty.Text)
    self.mTxtTitleRR = self:getChildGO("mTxtTitleRR"):GetComponent(ty.Text)
    self.mTxtTitleLR = self:getChildGO("mTxtTitleLR"):GetComponent(ty.Text)
    self.mTxtGiftDscR = self:getChildGO("mTxtGiftDscR"):GetComponent(ty.Text)
    self.mTxtTitleLRD = self:getChildGO("mTxtTitleLRD"):GetComponent(ty.Text)
    self.mTxtGiftDscL = self:getChildGO("mTxtGiftDscL"):GetComponent(ty.Text)
    self.mTxtTitleRRD = self:getChildGO("mTxtTitleRRD"):GetComponent(ty.Text)
    self.mImgCoinR = self:getChildGO("mImgCoinR"):GetComponent(ty.AutoRefImage)
    self.mImgIconR = self:getChildGO("mImgIconR"):GetComponent(ty.AutoRefImage)
    self.mBtnReciveR = self:getChildGO("mBtnReciveR"):GetComponent(ty.AutoRefImage)
    self.mBtnReciveL = self:getChildGO("mBtnReciveL"):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID })
    GameDispatcher:addEventListener(EventName.UPDATE_GRADE_GIFT, self.updateInfo, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateRight, self)
    self:updateInfo()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_GRADE_GIFT, self.updateInfo, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateRight, self)
    self:updateBubble(false)
end

function initViewText(self)
    super.initViewText(self)
    self.mTxtTitleL.text = _TT(50043)--基础礼包
    self.mTxtTitleR.text = _TT(50044)--高级礼包
    self.mTxtTitleLRD.text = _TT(50047)--链尉官等级
    self.mTxtTitleRRD.text = _TT(50047)--链尉官等级
    -- self.mTxtDsc.text = "链尉官达到指定等级可以获得相应奖励"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReciveL.gameObject, self.onClickRecHandler, nil, true)
    self:addUIEvent(self.mBtnReciveR.gameObject, self.onClickRecHandler, nil, false)
end

function updateInfo(self)
    self:updateLeft()
    self:updateRight()
end
--低级礼包
function updateLeft(self)
    self:onCloseAwardLlist()
    self.mNomalVo = purchase.GradeGiftManager:getGradeGiftVoByType(1)
    local alpha = ((not self.mNomalVo:getIsCanRec()) or (self.mNomalVo:getIsReced())) and 0 or 1
    self.mBtnReciveL.enabled = alpha > 0
    self.mImGlow:SetActive(alpha > 0)
    self.mTxtGiftDscL.text = (self.mNomalVo:getIsCanRec() == true) and "" or self.mNomalVo:getGiftLvlDsc()
    local btnText1 = self.mNomalVo:getIsReced() and 411 or 412
    local btnText = (not self.mNomalVo:getIsCanRec()) and -1 or btnText1
    self:setBtnLabel(self.mBtnReciveL, btnText, "未达标")
    local content = #self.mNomalVo:getDropAward() > 4 and self.mAwardTransLC or self.mAwardTransL
    for _, awardVo in ipairs(self.mNomalVo:getDropAward()) do
        local propGrid = PropsGrid:create(content, { tid = awardVo.tid, num = awardVo.num ~= nil and awardVo.num or 1 }, 1, false)
        table.insert(self.mAwardListL, propGrid)
    end
    self.mTxtTitleLR.text = self.mNomalVo:getGiftLvl()
    self.mImgLockLeft:SetActive(self.mNomalVo:getIsReced())
    self:updateBubble(true)
end
--高级礼包
function updateRight(self)
    self:onCloseAwardRlist()
    self.mSeniorVo = purchase.GradeGiftManager:getGradeGiftVoByType(2)
    local alpha = ((self.mSeniorVo:getIsReced())) and 0 or 1
    self.mBtnReciveR.enabled = alpha > 0
    self.mTxtGiftDscR.text = self.mSeniorVo:getIsCanRec() and "" or self.mSeniorVo:getGiftLvlDsc()
    self.mImgCoinR:SetImg(MoneyUtil.getMoneyIconUrlByType(self.mSeniorVo:getCostType()), true)
    self.mImgCoinR.gameObject:SetActive(not self.mSeniorVo:getIsReced())
    local content = #self.mSeniorVo:getDropAward() > 4 and self.mAwardTransRC or self.mAwardTransR
    for _, awardVo in ipairs(self.mSeniorVo:getDropAward()) do
        local propGrid = PropsGrid:create(content, { tid = awardVo.tid, num = awardVo.num ~= nil and awardVo.num or 1 }, 1, false)
        table.insert(self.mAwardListR, propGrid)
    end
    self.mTxtTitleRR.text = self.mSeniorVo:getGiftLvl()
    local btnText = self.mSeniorVo:getIsSeniorCan() and HtmlUtil:color(self.mSeniorVo:getCostCoinNum(), "ffffffff") or HtmlUtil:color(self.mSeniorVo:getCostCoinNum(), "fa3a2bff")
    local endText = self.mSeniorVo:getIsReced() and HtmlUtil:colorAndSize(_TT(25011), "202226ff", 30) or HtmlUtil:size(btnText, 32)
    self.mImgLockRight:SetActive(self.mSeniorVo:getIsReced())
    self.mTxtCoinR.text = endText
end

--领取奖励
function onClickRecHandler(self, isNomal)
    if isNomal then
        if self.mNomalVo:getIsReced() then
            gs.Message.Show(_TT(25011))
            return
        end
        if self.mNomalVo:getIsCanRec() then
            GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_GRADE_GIFT, { id = self.mNomalVo.sort, type = self.mNomalVo:getCostType() })
        else
            gs.Message.Show(self.mNomalVo:getGiftLvlDsc())
            return
        end
    else
        if self.mSeniorVo:getIsReced() then
            gs.Message.Show(_TT(25011))
            return
        end
        if MoneyUtil.getMoneyCountByTid(MoneyTid.PAY_ITIANIUM_TID) < self.mSeniorVo.costCoin then
            UIFactory:alertMessge(_TT(66), true, function()
                GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
            return
        end
        if self.mSeniorVo:getIsCanRec() == true then
            GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_GRADE_GIFT, { id = self.mSeniorVo.sort, type = self.mSeniorVo:getCostType() })
        else
            gs.Message.Show(self.mSeniorVo:getGiftLvlDsc())
            return
        end
    end
end

--删除普通奖励
function onCloseAwardLlist(self)
    if #self.mAwardListL > 0 then
        for _, item in ipairs(self.mAwardListL) do
            item:poolRecover()
        end
        self.mAwardListL = {}
    end
end

function updateBubble(self, isShow)
    local isBubble = purchase.GradeGiftManager:getIsGradeGiftBubble()
    if (isBubble and isShow) then
        RedPointManager:add(self.mBtnReciveL.transform, nil, 186.5, 30.8)
    else
        RedPointManager:remove(self.mBtnReciveL.transform)
    end
end

--删除进阶奖励
function onCloseAwardRlist(self)
    if #self.mAwardListR > 0 then
        for _, item in ipairs(self.mAwardListR) do
            item:poolRecover()
        end
        self.mAwardListR = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]