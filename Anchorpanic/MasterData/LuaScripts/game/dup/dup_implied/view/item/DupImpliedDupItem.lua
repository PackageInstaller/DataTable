--[[ 
-----------------------------------------------------
@filename       : DupImpliedDupItem
@Description    : 默示之境副本item
@date           : 2021-07-06 17:11:35
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.view.item.DupImpliedDupItem', Class.impl("lib.component.BaseContainer"))

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function loadAsset(self)
end

function initData(self)
end

function setup(self, rootGo)
    self.UIObject = rootGo
    self.UITrans = self.UIObject.transform
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
    self:configUI()
    self:active()
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    -- self.aa = self:getChildTrans("")
    self.mGroupActive = self:getChildGO("mGroupActive")
    self.mSelect = self:getChildGO("mSelect")
    self.mNormal = self:getChildGO("mNormal")

    self.mImgLock = self:getChildGO("mImgLock")

    self.mImgTime = self:getChildGO("mImgTime")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtNorName = self:getChildGO("mTxtNorName"):GetComponent(ty.Text)
    self.mTxtNorSelectName = self:getChildGO("mTxtNorSelectName"):GetComponent(ty.Text)
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)

    -- self.mTxtTip = self:getChildGO("mTxtTip"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)

    self:addOnClick(self.mGroupActive, self.onClick)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_IMPLIED_DUP_INFO_VIEW,self.onSelect,self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:removeOnClick(self.mGroupActive)

    GameDispatcher:removeEventListener(EventName.OPEN_DUP_IMPLIED_DUP_INFO_VIEW,self.onSelect,self)
end


function setData(self, cusDupId)
    self.dupData = dup.DupImpliedManager:getDupVo(cusDupId)
    self.dupInfo = dup.DupImpliedManager:getDupInfo(self.dupData.dupId)


    self.mTxtNorName.text = self.dupData.name
    self.mTxtNorSelectName.text = self.dupData.name
    self.mImgBg:SetImg(string.format("arts/ui/pack/dupImplied_new/img_checkp_0%s.png",self.dupData.stage),false)

    local isUnLock = self:isUnLock()
    self.mImgBg:SetGray(not isUnLock)

    if not isUnLock then
        self.mImgLock:SetActive(true)
        self.mImgTime:SetActive(false)
        -- self.mGroupActive:SetActive(false)
    else
        if self.dupInfo.roundPassTime > 0 then
            self.mTxtTime.text = TimeUtil.getMSByTime(self.dupInfo.roundPassTime)
            self.mImgTime:SetActive(true)
        else
            self.mImgTime:SetActive(false)
        end
        self.mImgLock:SetActive(false)
    end

    self:onSelect(0)
end

function onClick(self)
    if self:isUnLock() then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_DUP_INFO_VIEW, self.dupData.dupId)
    else
        gs.Message.Show(_TT(29140))
    end
end

function onSelect(self,dupId)
    local isSelect = dupId == self.dupData.dupId
    self.mSelect:SetActive(isSelect)
    self.mNormal:SetActive(not isSelect)
end

-- 是否开放
function isUnLock(self)
    local preDupInfo = dup.DupImpliedManager:getDupInfo(self.dupData.preId)
    if not preDupInfo or preDupInfo.roundPassTime > 0 then
        return true
    end
    return false
end

function getData(self)
    return self.dupData
end

-- function destroy(self)
--     super.destroy(self)
--     self:deActive()
-- end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(29140):	"前置关卡未通关"
]]
