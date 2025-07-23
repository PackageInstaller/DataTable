module("maze.MazeItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgBg = self:getChildGO("ImgBg"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    
    self.mGroupEnable = self:getChildGO("mGroupEnable")
    self.mBtnEnableEnter = self:getChildGO("mBtnEnableEnter")

    self.mBtnProgress = self:getChildGO("BtnProgress")
    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mTextProgress = self:getChildGO("TextProgress"):GetComponent(ty.Text)
    self.mTextProgressText = self:getChildGO("TextProgressText"):GetComponent(ty.Text)
    self.mTextPassTime = self:getChildGO("TextPassTime"):GetComponent(ty.Text)

    self.mBtnDisableEnter = self:getChildGO("mBtnDisableEnter")
    self.mGroupDisable = self:getChildGO("mGroupDisable")
    self.mOpenTip = self:getChildGO("mOpenTip"):GetComponent(ty.Text)



end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnEnableEnter, self.__onClickDisbaleEnterHandler)
    self:addUIEvent(self.mBtnDisableEnter, self.__onClickEnableEnterHandler)
    self:addUIEvent(self.mBtnProgress, self.__onClickProgressHandler)
end

function setData(self, param)
    super.setData(self, param)

    local mazeConfigVo = self.data
    local mazeId = mazeConfigVo:getMazeId()
    self.mImgBg:SetImg(UrlManager:getMazeEnterIconUrl(mazeId), true)
    self.mTxtName.text = _TT(mazeConfigVo:getName())

    self:setGuideTrans("funcTips_maze_mazeItem_"..mazeId, self:getChildTrans("mBtnEnableEnter"))

    if(role.RoleManager:getRoleVo():getPlayerLvl() >= mazeConfigVo.limitPlayerLevel)then
        local isLock = false
        if mazeConfigVo.unLockDupId ~= 0 then 
            if not battleMap.MainMapManager:isStagePass(mazeConfigVo.unLockDupId) then
                self.mGroupEnable:SetActive(false)
                self.mGroupDisable:SetActive(true)

                local stageVo = battleMap.MainMapManager:getStageVo(mazeConfigVo.unLockDupId)
                self.mOpenTip.text = _TT(57, stageVo.indexName)

                isLock = true
            end
        end

        if not isLock then 
            self.mGroupEnable:SetActive(true)
            self.mGroupDisable:SetActive(false)

            local mazeVo = maze.MazeManager:getMazeVo(mazeId)
            if(mazeVo)then
                self.mTextPassTime.text = string.format("通关总时长：%s", mazeVo.passTime <= 0 and "--" or TimeUtil.getHMSByTime(mazeVo.passTime))
                self.mTextProgressText.text = "宝箱探索进度："
                self.mTextProgress.text = math.floor(mazeVo:getBoxPro() * 100) .. "%"
                self.mImgProgress.fillAmount = mazeVo:getBoxPro()
            else
                Debug:log_error("MazeItem", "后端没有发来迷宫数据")
            end
        end
    else
        self.mGroupEnable:SetActive(false)
        self.mGroupDisable:SetActive(true)

        self.mOpenTip.text = _TT(46, mazeConfigVo.limitPlayerLevel)
    end
end

function __onClickDisbaleEnterHandler(self, args)
    local mazeConfigVo = self.data
    local mazeId = mazeConfigVo:getMazeId()
    local mazeVo = maze.MazeManager:getMazeVo(mazeId)
    -- if(mazeVo.hasEnter)then
        GameDispatcher:dispatchEvent(EventName.REQ_MAZE_ENTER, {mazeId = mazeId})
    -- else
    --     UIFactory:alertMessge(
    --         string.format("是否开启并进入迷宫？\n(关卡宝箱不重置)\n剩余华丽宝箱数量%s，剩余普通宝箱数量%s，剩余通关宝箱数量%s", mazeVo.remainGorgeousBoxNum, mazeVo.remainNormalBoxNum, mazeVo:getReaminPassBoxNum()),
    --         true,
    --         function()
    --             GameDispatcher:dispatchEvent(EventName.REQ_MAZE_ENTER, {mazeId = mazeId})
    --         end,
    --         _TT(1), --"确定"
    --         nil,
    --         true,
    --         function()
    --         end,
    --         _TT(2),
    --          --"取消"
    --         _TT(4341), --"进入提示"
    --         nil,
    --         RemindConst.XXX)
    -- end
end

function __onClickEnableEnterHandler(self)
    local mazeConfigVo = self.data
    if(role.RoleManager:getRoleVo():getPlayerLvl() >= mazeConfigVo.limitPlayerLevel)then
        if mazeConfigVo.unLockDupId ~= 0 then 
            local stageVo = battleMap.MainMapManager:getStageVo(mazeConfigVo.unLockDupId)
            gs.Message.Show(_TT(57, stageVo.indexName))
        end
    else
        gs.Message.Show(_TT(46, mazeConfigVo.limitPlayerLevel))
    end
end

function __onClickProgressHandler(self)
    -- 策划说屏蔽
    -- local mazeConfigVo = self.data
    -- local mazeId = mazeConfigVo:getMazeId()
    -- local mazeVo = maze.MazeManager:getMazeVo(mazeId)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_PROGRESS_PANEL, {mazeId = mazeId})
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
