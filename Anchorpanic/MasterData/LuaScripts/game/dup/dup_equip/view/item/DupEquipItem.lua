--[[ 
-----------------------------------------------------
@filename       : DupEquipItem
@Description    : 副本item
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('dup.DupEquipItem', Class.impl(BaseComponent))
-- 是否异步
IsAsyn = false
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupEquip/DupEquipBaseItem.prefab")

function __initData(self)
    super.__initData(self)

    self.mGroupActive = nil
    self.mGroupPass = nil
    self.mGroupLock = nil

    self.mTxtActiveStage = nil
    self.mActiveImg = nil
    self.mTxtActiveName = nil
    self.mTxtPassStage = nil
    self.mTxtPass = nil
    self.mTxtPassEn = nil
    self.mTxtLockStage = nil

    self.mActiveIcon = nil
    self.mPassIcon = nil 
    self.mLockIcon = nil


    self.mImgLine = nil
    self.mImgArrow = nil

    self.m_nextPos = nil
    self.m_nextState = nil

    self.mIsTween = nil
    self.arrowTween = nil

    self.mUpPos = nil
    self.mDownPos = nil

    self.mIsSelect = false
end

function __reset(self)
    self:__killTween()
    super.__reset(self)
end

function __initGo(self)
    local rect = self.m_uiGo:GetComponent(ty.RectTransform)
    gs.TransQuick:UIPos(rect, 0, 0)
    gs.TransQuick:Anchor(rect, 0, 1, 0, 1)
    gs.TransQuick:Scale(rect, 1, 1, 1)
end

-- 更新信息显示
function __updateCustomView(self)
    self:__updateState()
    self:__updateDupInfo()
    self:__tweenArrow1()
end

function __removeEventList(self)
    if (self.m_childGos and self.m_childGos["mImgActiveBg"]) then
        self:removeOnClick(self.m_childGos["mImgActiveBg"])
        self:removeOnClick(self.m_childGos["mImgPassBg"])
        self:removeOnClick(self.m_childGos["mImgPassBg_1"])
        self:removeOnClick(self.m_childGos["mImgLockBg"])
    end
end

function __addEventList(self)
    self.mImgActiveBg = self.m_childGos["mImgActiveBg"].transform
    if (self.m_childGos and self.m_childGos["mImgActiveBg"]) then
        self:addOnClick(self.m_childGos["mImgActiveBg"], self.__onClickActive)
    end
    if (self.m_childGos and self.m_childGos["mImgPassBg"]) then
        self:addOnClick(self.m_childGos["mImgPassBg"], self.__onClickActive)
    end
    if (self.m_childGos and self.m_childGos["mImgPassBg_1"]) then
        self:addOnClick(self.m_childGos["mImgPassBg_1"], self.__onClickActive)
    end
    if (self.m_childGos and self.m_childGos["mImgLockBg"]) then
        self:addOnClick(self.m_childGos["mImgLockBg"], self.__onClickActive)
    end
end

function __onClickActive(self)
    local state = self:getDupState()

    -- if self:getDupData().passTimes <= 0 then
    --     -- gs.Message.Show('没有剩余次数')
    --     gs.Message.Show(_TT(118))
    -- else
    if self:getDupData().curId ~= 0 and self:getData().dupId > self:getDupData().curId then
        -- gs.Message.Show('前置关卡未通关')
        gs.Message.Show(_TT(119))
    elseif self:getData().enterLv > role.RoleManager:getRoleVo():getPlayerLvl() then
        -- gs.Message.Show(self.configVo.enterLv .. '级开启')
        gs.Message.Show(_TT(121, self:getData().enterLv))
    elseif battleMap.MainMapManager:isStagePass(self:getData().enterDup) == nil then
        local stageVo = battleMap.MainMapManager:getStageVo(self:getData().enterDup)
        gs.Message.Show(_TT(1215,stageVo.indexName,stageVo:getName()))
    else
        GameDispatcher:dispatchEvent(EventName.DUPDATE_DAILY_DUP_SELECTDATA,self:getData())
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_DUP_INFO, self:getData())
    end
end

function __updateState(self)
    if (self.m_isLoadFinish) then
        if not self.mGroupActive then
            self.mGroupActive = self.m_childGos["mGroupActive"]
            self.mUpPos = self.m_childGos["mUpPos"]
            self.mDownPos = self.m_childGos["mDownPos"]
        end
        if not self.mGroupPass then
            self.mGroupPass = self.m_childGos["mGroupPass"]
        end
        if not self.mGroupLock then
            self.mGroupLock = self.m_childGos["mGroupLock"]
        end

        local state = self:getDupState()
        if state == 1 then
            -- 正在进行
            self.mGroupActive:SetActive(true)
            self.mGroupPass:SetActive(false)
            self.mGroupLock:SetActive(false)
        elseif state == 2 then
            -- 已通关
            self.mGroupActive:SetActive(false)
            self.mGroupPass:SetActive(true)
            self.mGroupLock:SetActive(false)
        else
            -- 未开放
            self.mGroupActive:SetActive(false)
            self.mGroupPass:SetActive(false)
            self.mGroupLock:SetActive(true)
        end

        self.m_childGos["mIsSelect"]:SetActive(self.mIsSelect)
    end
end

function __updateDupInfo(self)
    if (self.m_isLoadFinish) then
        -- 进行中模式
        if not self.mTxtActiveStage then
            self.mTxtActiveStage = self.m_childGos["mTxtActiveStage"]:GetComponent(ty.Text)
        end

        self.mTxtActiveStage.text =self:getData():getName()

        if not self.mActiveIcon then
            self.mActiveIcon = self.m_childGos["mActiveIcon"]:GetComponent(ty.AutoRefImage)
        end

        if not self.mPassIcon then
            self.mPassIcon = self.m_childGos["mImgPassBg"]:GetComponent(ty.AutoRefImage)
        end

        if not self.mLockIcon then
            self.mLockIcon = self.m_childGos["mImgLockBg"]:GetComponent(ty.AutoRefImage)
        end
        
        local iconPath = UrlManager:getPackPath("dup4/dup_icon_"..self:getDupData().type..".png")
        self.mActiveIcon:SetImg(iconPath,false)
        self.mPassIcon:SetImg(iconPath,false)
        self.mLockIcon:SetImg(iconPath,false)


        if not self.mTxtActiveName then
            self.mTxtActiveName = self.m_childGos["mTxtActiveName"]:GetComponent(ty.Text)
        end
        self.mTxtActiveName.text = self:getData():getStageName()
        -- 通关模式
        if not self.mTxtPassStage then
            self.mTxtPassStage = self.m_childGos["mTxtPassStage"]:GetComponent(ty.Text)
        end
        self.mTxtPassStage.text =self:getData():getName()
        -- 
        if not self.mTxtPass then
            self.mTxtPass = self.m_childGos["mTxtPass"]:GetComponent(ty.Text)
        end
        self.mTxtPass.text = _TT(120)--"已通关"
        -- 
        if not self.mTxtPassEn then
            self.mTxtPassEn = self.m_childGos["mTxtPassEn"]:GetComponent(ty.Text)
        end
        self.mTxtPassEn.text = _TT(125)--"CUSTOMS CLEARANCE"
        -- 未开放模式
        if not self.mTxtLockStage then
            self.mTxtLockStage = self.m_childGos["mTxtLockStage"]:GetComponent(ty.Text)
        end
        self.mTxtLockStage.text = self:getData():getName()
    end
end

function __updateParent(self)
    if (self.m_isLoadFinish) then
        if (self.m_parentTrans ~= nil) then
            self.m_uiGo.transform:SetParent(self.m_parentTrans, false)
            LoopManager:addFrame(1, 1, self, self.__updateLine)
        end
    end
end

function __updateLine(self)
    if (self.m_isLoadFinish and self.m_parentTrans) then
        if not self.mImgLine then
            self.mImgLine = self.m_childGos["mImgLine"]
        end
        if not self.m_nextPos then
            self.mImgLine:SetActive(false)
            return
        end
        self.mImgLine:SetActive(true)
        local curPos = self:getCurAnchors()

        local p1 = self.m_parentTrans:InverseTransformPoint(curPos)
     
        local p2 = self.m_parentTrans:InverseTransformPoint(self.m_nextPos)
        local dis = gs.TransQuick:PosDist(p1, p2) - (self.m_nextState == 3 and 0 or 0)
        local angle = gs.Mathf.Atan2((p2.x - p1.x), (p2.y - p1.y))
        local theta = 180 - angle * (180 / gs.Mathf.PI)


        gs.TransQuick:Pos(self.mImgLine.transform, curPos)
        gs.TransQuick:LPosOffsetY(self.mImgLine.transform, -(self.m_nextState == 3 and 0 or 0))
        gs.TransQuick:SizeDelta02(self.mImgLine.transform, dis)
        self.mImgLine.transform.eulerAngles = gs.Vector3(0, 0, theta);


        if self.m_nextState == 1 then
            -- 正在进行
            self.mImgLine:GetComponent(ty.Image).color =  gs.ColorUtil.GetColor("000000FF")
        elseif self.m_nextState == 2 then
            -- 已通关
            self.mImgLine:GetComponent(ty.Image).color =  gs.ColorUtil.GetColor("000000FF")
        else
            -- 未开放
            self.mImgLine:GetComponent(ty.Image).color =  gs.ColorUtil.GetColor("A9ACB0ff")
        end
    end
end

function setLinePos(self, nextPos, nextState)
    self.m_nextPos = nextPos
    self.m_nextState = nextState
    self:__updateLine()
end

-- 获取当前的模式的中心点
function getCurAnchors(self)
    local state = self:getDupState()
    local dupIndex = self:getData().dupIndex
    if dupIndex % 2 == 0 then
        return self.mDownPos.transform.position
    else
        return self.mUpPos.transform.position
    end
end

-- 副本状态
function getDupState(self)
    if self:getDupData().curId == 0 or self:getDupData().curId > self:getData().dupId then
        -- 已通关
        return 2
    elseif self:getDupData().curId < self:getData().dupId or self:getData().enterLv > role.RoleManager:getRoleVo():getPlayerLvl() then
        -- 未开放
        return 3
    else
        -- 正在进行
        return 1
    end
end

function setCurState(self,value)
   
end

function setSelectState(self, value)
    self.mIsSelect = value
    self.m_childGos["mIsSelect"]:SetActive(self.mIsSelect)
    self.mIsTween = value
    self:__tweenArrow1()
end

function __tweenArrow1(self)
    if not self.m_childTrans then
        return
    end

    if not self.mImgArrow then
        self.mImgArrow = self.m_childGos["mImgArrow"]
    end

    if not self.mIsTween then
        self:__killTween()
        self.mImgArrow:SetActive(false)
        return
    end

    self.mImgArrow:SetActive(true)

    self.arrowTween = TweenFactory:move2LPosY(self.mImgArrow.transform, self:getDupState() == 1 and 100 or 100, 0.3, nil, function()
        self:__tweenArrow2()
    end)
end
function __tweenArrow2(self)
    if not self.m_childTrans or not self.mIsTween then
        return
    end
    self.arrowTween = TweenFactory:move2LPosY(self.mImgArrow.transform, self:getDupState() == 1 and 70 or 70, 0.3, nil, function()
        self:__tweenArrow1()
    end)
end

function __killTween(self)
    if self.arrowTween then
        self.arrowTween:Kill()
        self.arrowTween = nil
    end
end

function getDupData(self)
    return dup.DupMainManager:getDupInfoData(self:getData().type)
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
