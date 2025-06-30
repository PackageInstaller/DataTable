--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeDupItem
@Description    : 代号·希望副本副本item
@date           : 2021-05-13 19:59:17
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.view.item.DupCodeHopeDupItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeDupItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mBtnBg = self:getChildGO("mBtnBg")
    self.mImgPass = self:getChildGO("mImgPass")
    self.mGroupSelect = self:getChildGO("mGroupSelect")
    self.mImgSelect = self:getChildTrans("mImgSelect")
    -- self.bb = self:getChildTrans("bb")
    self.mImgSpecial = self:getChildGO("mImgSpecial")

    self.mImgLock = self:getChildGO("mImgLock")
    self.mGroupPoint = self:getChildTrans("mGroupPoint")

    self.mImgCg = self:getChildGO("mImgCg")
end

--激活
function active(self)
    super.active(self)

    self:addOnClick(self.mBtnBg, self.onClick)
    self:setSelectState(false)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:__killTween()
    self:removeOnClick(self.mBtnBg)
end

function onClick(self)
    local isOpen = dup.DupCodeHopeManager:getDupIsOpen(self:getData().dupId)
    if not isOpen then
        gs.Message.Show(_TT(29140))
        return
    end
    local isPass = dup.DupCodeHopeManager:getChapterIsPass(self.data.chapter)
    if self.data.stageType == 2 and isPass then
        gs.Message.Show(_TT(29141))
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_CODE_HOPE_INFO, self:getData().dupId)
end

function setData(self, cusParent, cusDupId)
    self:setParentTrans(cusParent)

    self:setGuideTrans("funcTips_codeHope_dupItem_" .. cusDupId, self:getChildTrans("mBtnBg"))
    self.data = dup.DupCodeHopeManager:getDupVo(cusDupId)

    self.mTxtName.text = self.data:getName()
    local isPass = dup.DupCodeHopeManager:getDupIsPass(cusDupId)
    self.mImgPass:SetActive(isPass)

    self.mImgCg:SetActive(false)
    if self.data.stageType == 3 then
        self.mImgCg:SetActive(true)
        -- 特殊关卡
        self.mBtnBg:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dupCodeHope/img_dhxw_stage_04.png"))
    elseif self.data.stageType == 5 then
        -- 精英关卡
        self.mBtnBg:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dupCodeHope/img_dhxw_stage_05.png"))
    else
        self.mBtnBg:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("dupCodeHope/img_dhxw_stage_02.png"))
    end

    self.isOpen = dup.DupCodeHopeManager:getDupIsOpen(cusDupId)
    if self.isOpen then
        self.mImgLock:SetActive(false)
        --self.UIObject:SetActive(true)
    else
        self.mImgLock:SetActive(true)
        --self.UIObject:SetActive(false)
    end

    self:setLine()
end

function setLine(self)
    if self.data.lineId == 0 then
        return
    end
    local lineGo = gs.GOPoolMgr:Get(UrlManager:getUIPrefabPath(string.format("dupCodeHope/DupCodeHopeLine_%s.prefab", self.data.lineId)))
    lineGo.transform:SetParent(self.mGroupPoint, false)

    self.lineGo = lineGo
    self.mLineGos, self.mLineTrans = GoUtil.GetChildHash(self.lineGo)
end

function setLineActive(self, isActive)
    self.mGroupPoint.gameObject:SetActive(isActive)
end

function getNextPoint(self, cusId)
    if not self.mLineTrans then
        logError("getNextPoint", self.data.dupId, self.data.lineId, cusId)
        return nil
    end
    return self.mLineTrans[string.format("mPoint_%s", cusId)]
end

function getData(self)
    return self.data
end

function setSelectState(self, value)
    self.mIsTween = value
    self:__tweenArrow1()
end

function __tweenArrow1(self)
    if not self.mIsTween then
        self:__killTween()
        self.mGroupSelect:SetActive(false)
        return
    end

    self.mGroupSelect:SetActive(true)

    -- self.selectTween = TweenFactory:move2LPosY(self.mImgSelect, 86.8, 0.3, nil, function()
    --     self:__tweenArrow2()
    -- end)
end
-- function __tweenArrow2(self)
--     self.selectTween = TweenFactory:move2LPosY(self.mImgSelect, 76, 0.3, nil, function()
--         self:__tweenArrow1()
--     end)
-- end

function __killTween(self)
    if self.selectTween then
        self.selectTween:Kill()
        self.selectTween = nil
    end
end

function poolRecover(self)
    gs.GameObject.Destroy(self.lineGo)
    self.lineGo = nil
    self.lineGoTrans = nil
    self.mGroupSelect = nil
    self:__killTween()
    super.destroy(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(29141):	"章节已通关"
	语言包: _TT(29140):	"前置关卡未通关"
]]