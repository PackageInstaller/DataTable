--[[ 
-----------------------------------------------------
@filename       : DupEquipEnterItem
@Description    : 芯片入口item
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('dup.DupEquipEnterItem', Class.impl(BaseComponent))
UIRes = UrlManager:getUIPrefabPath('dupEquip/DupEquipEnterItem.prefab')


function __initData(self)
    super.__initData(self)
    self.mImgBg = nil
    self.mTxtName = nil
    self.mTxtDes = nil
    self.mImgLock = nil
    self.mTxtLock = nil
    self.mGroupInfo = nil
    self.mBtnGroup = nil

    self.mLockBg = nil
end

-- 更新其他的信息显示
function __updateCustomView(self)
    self:__updateInfo()
    self:__updateName()
    self:__updateDes()
    self:__updateState()
end

function __removeEventList(self)
    if self.mBtnGroup then
        self:removeOnClick(self.mBtnGroup, self.onClickItemHandler)
    end
end

function __addEventList(self)
    if not self.mBtnGroup then
        self.mBtnGroup = self.m_childGos["mImgBg"]
    end

    self:addOnClick(self.mBtnGroup, self.onClickItemHandler)
end

function __updateInfo(self)
    if (self.m_isLoadFinish) then
        if not self.mImgBg then
            self.mImgBg = self.m_childGos["mImgBg"]:GetComponent(ty.AutoRefImage)
        end
        self.mImgBg:SetImg(UrlManager:getPackPath(string.format("dup4/dup_daily_enter_%d.png", self:getData().type)), true)
    end
end

function __updateName(self)
    if (self.m_isLoadFinish) then
        if not self.mTxtName then
            self.mTxtName = self.m_childGos["mTxtName"]:GetComponent(ty.Text)
        end
        self.mTxtName.text = self:getData():getName()
    end
end
function __updateDes(self)
    if (self.m_isLoadFinish) then
        if not self.mTxtDes then
            self.mTxtDes = self.m_childGos["mTxtDes"]:GetComponent(ty.Text)
        end
        self.mTxtDes.text = self:getData():getDes()
    end
end
function __updateState(self)
    if (self.m_isLoadFinish) then
        if not self.mImgLock then
            self.mImgLock = self.m_childGos["mImgLock"]
        end
        if not self.mGroupInfo then
            self.mGroupInfo = self.m_childGos["mGroupInfo"]:GetComponent(ty.CanvasGroup)
        end
        if not self.mTxtLock then
            self.mTxtLock = self.m_childGos["mTxtLock"]:GetComponent(ty.Text)
        end

        self.mLockBg = self.m_childGos["mImgLockBg"]
        if funcopen.FuncOpenManager:isOpen(self:getData().funcId, false) == false then
            local vo = funcopen.FuncOpenManager:getFuncOpenData(self:getData().funcId)
            local str = _TT(44503)
            self.mTxtLock.text = str
            self.mLockBg:SetActive(true)
        else
            self.mLockBg:SetActive(false)
            self.mGroupInfo.alpha = 1
        end

        if dup.DupEquipBaseManager:canFight(self:getData().type,false) then
            
        else
            self.mLockBg:SetActive(true)
            if(self:getData().type == DupType.DUP_EQUIP_MID) then
                self.mTxtLock.text = _TT(53606)
            else
                self.mTxtLock.text = _TT(53607)
            end
        end

        self.mGroup = self.m_childGos["mGroupInfo"]:GetComponent(ty.RectTransform)
        -- if(self:getData().scrollIndex % 2 == 0) then
        --     gs.TransQuick:UIPosY(self.mGroup,-250)
        -- end
    end
end

function onClickItemHandler(self)
    -- if self:getData().lvl > role.RoleManager:getRoleVo():getPlayerLvl() then
    --     -- UIFactory:alertMessge('未达到副本解锁等级要求', false)
    --     UIFactory:alertMessge(_TT(117), false)
    --     return
    -- end
    if funcopen.FuncOpenManager:isOpen(self:getData().funcId, true) == false then
        return
    end
    
    if dup.DupEquipBaseManager:canFight(self:getData().type,true) then
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP, { dupType = self:getData().type })
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
