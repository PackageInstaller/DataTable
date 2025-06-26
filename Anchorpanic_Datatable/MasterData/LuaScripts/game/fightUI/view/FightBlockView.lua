
module('fightUI.FightBlockView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
	super.initData(self, rootGo)

	local function _blockActionCall()
		if self.m_blockCDTime>0 then return end
        if ABBlock.ABBlockMgr:isNeedBlock() == false then
            return
        end
		if ABBlock.ABBlockMgr:isEnoughBlockVal()~=true then
            gs.Message.Show2(_TT(3044), true)
            ABBlock.ABBlockMgr:palyABBlockWarnAduio()
            return
        end
        if ABBlock.ABBlockMgr:isFirst() then
            if ABBlock.ABBlockMgr:setCanBlock(true)==false then
                self:setBlockCD()
                ABBlock.ABBlockMgr:palyABBlockMissAduio()
            else
                self:setBlockSuccessCD()
                ABBlock.ABBlockMgr:playABBlockShowAudio()
            end
        else
            -- 过了可点击范围, 但还要加CD
            self:setBlockCD()
            ABBlock.ABBlockMgr:palyABBlockMissAduio()
        end	
	end

	self.m_blockBtn = self:getChildGO('BlockBtn')
    self:addOnClick(self.m_blockBtn, _blockActionCall,"")
    self.m_blockImg = self.m_blockBtn:GetComponent(ty.AutoRefImage)
    self.m_eventTrigger = self.m_blockBtn:GetComponent(ty.LongPressOrClickEventTrigger)
    
	self.m_blockCDGO = self:getChildGO('BlockMask')
	self.m_blockCDMask = self.m_blockCDGO:GetComponent(ty.Image)
	self.m_blockCDTxt = self:getChildGO('BlockCDTxt'):GetComponent(ty.Text)
    
	self.m_blockValTxt = self:getChildGO('BlockValTxt'):GetComponent(ty.Text)
	self.m_blockTotalValTxt = self:getChildGO('BlockTotalValTxt'):GetComponent(ty.Text)
	self.m_blockBarValImg = self:getChildGO('BlockBarValImg'):GetComponent(ty.Image)
    
	self.m_selectTipsImg = self:getChildGO('SelectTipsImg')
	self.m_imgBlockArrow = self:getChildTrans('ImgBlockArrow')

	self.m_blockTotalCDTime = 0
	self.m_blockCDTime = 0
	self.m_blockTotalVal = sysParam.SysParamManager:getValue(SysParamType.BLOCK_INIT_VAL, 100)

    GameDispatcher:addEventListener(EventName.CLOSE_FIGHT_SKILL_TIPS, self.onCloseSkillTips, self)
end

function show(self)
	GameDispatcher:addEventListener(EventName.BLOCK_VAL_UPDATE_EVENT, self.updateBlockVal, self)
	local function _onLongPress()
        self.m_selectTipsImg:SetActive(true)
        GameDispatcher:dispatchEvent(EventName.OPEN_FIGHT_SKILL_TIPS, { skillId = 0 })
    end
    if self.m_eventTrigger then
        self.m_eventTrigger.onLongPress:AddListener(_onLongPress)
    end
    -- self:setActive(true)
    self:updateBlockVal()
end

function close(self)
	if self.m_eventTrigger then
        self.m_eventTrigger.onLongPress:RemoveAllListeners()
    end
    RateLooper:removeFrameByIndex(self.m_blockCDSn)
	GameDispatcher:removeEventListener(EventName.BLOCK_VAL_UPDATE_EVENT, self.updateBlockVal, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_FIGHT_SKILL_TIPS, self.onCloseSkillTips, self)
end

function onCloseSkillTips(self)
    if self.m_selectTipsImg then
        self.m_selectTipsImg:SetActive(false)
    end
end

function updateBlockVal(self)
	self.m_blockTotalValTxt.text = self.m_blockTotalVal
	local val = fight.FightManager:getBlockVal(1)
	-- print("updateBlockVal==========", val)
	if val and val >= 0 then
        local rate = val/self.m_blockTotalVal * (3/4)
		self.m_blockBarValImg.fillAmount = rate
		self.m_blockValTxt.text = val

        
        -- 外面的小黄箭头
        local r = 63 --半径
        local x1 = r * gs.Mathf.Sin((3/4 - rate) * 360 * gs.Mathf.PI / 180)
        local y1 = r * gs.Mathf.Cos((3/4 - rate) * 360 * gs.Mathf.PI / 180)

        gs.TransQuick:UIPos(self.m_imgBlockArrow, x1, y1)
        gs.TransQuick:SetLRotation(self.m_imgBlockArrow, 0, 0, -360 * (3/4 - rate))

		-- if ABBlock.ABBlockMgr:isEnoughBlockVal() then
		-- 	self.m_blockImg:SetGray(false)
		-- else
		-- 	self.m_blockImg:SetGray(true)
		-- end
	else
		self.m_blockBarValImg.fillAmount = 0
		self.m_blockValTxt.text = "0"
		-- self.m_blockImg:SetGray(true)
	end
end

function _blockCDCall(self, dt)
    if not self.m_blockTotalCDTime or self.m_blockTotalCDTime==0 then
        self.m_blockCDGO:SetActive(false)
        RateLooper:removeFrameByIndex(self.m_blockCDSn)
        self.m_blockCDSn = 0
        return
    end

    self.m_blockCDTime = self.m_blockCDTime + dt
    if self.m_blockCDTime > self.m_blockTotalCDTime then
        self.m_blockCDTime = 0
        RateLooper:removeFrameByIndex(self.m_blockCDSn)
        self.m_blockCDSn = 0
        self.m_blockCDGO:SetActive(false)
        return
    end
    self.m_blockCDMask.fillAmount = 1 - self.m_blockCDTime / self.m_blockTotalCDTime
    self.m_blockCDTxt.text = string.format("%0.2fs", self.m_blockTotalCDTime - self.m_blockCDTime)
end

function setBlockCD(self)
    RateLooper:removeFrameByIndex(self.m_blockCDSn)
    self.m_blockCDSn = 0
    self.m_blockTotalCDTime = sysParam.SysParamManager:getValue(SysParamType.BLOCK_CD_TIME, 0) / 1000
    if self.m_blockTotalCDTime==0 then
        self.m_blockCDGO:SetActive(false)
        return
    end

    self.m_blockCDGO:SetActive(true)
    self.m_blockCDTxt.text = string.format("%0.2fs", self.m_blockTotalCDTime)
    self.m_blockCDMask.fillAmount = 1    
    self.m_blockCDSn = RateLooper:addFrame(0, -1, self, self._blockCDCall)
end

function setBlockSuccessCD(self)
    RateLooper:removeFrameByIndex(self.m_blockCDSn)
    self.m_blockCDSn = 0
    self.m_blockTotalCDTime = sysParam.SysParamManager:getValue(SysParamType.BLOCK_SUCCESS_CD_TIME, 0) / 1000
    if self.m_blockTotalCDTime==0 then
        self.m_blockCDGO:SetActive(false)
        return
    end

    self.m_blockCDGO:SetActive(true)
    self.m_blockCDTxt.text = string.format("%0.2fs", self.m_blockTotalCDTime)
    self.m_blockCDMask.fillAmount = 1    
    self.m_blockCDSn = RateLooper:addFrame(0, -1, self, self._blockCDCall)
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3044):	"力场值不足"
]]
