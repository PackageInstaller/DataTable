module("bag.BagConsumeScrollerItem", Class.impl(bag.BagScrollerItem))

function onInit(self, go)
    super.onInit(self, go)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end


function setGrid(self)
    local selectVo = self.data
    self.propsVo = selectVo:getDataVo()

    if (self.propsVo) then
        if (self.mPropsGrid) then
            self.mPropsGrid:poolRecover()
        end
        self.mPropsGrid = PropsSelectGrid:poolGet()
        self.mPropsGrid:setData(self.propsVo)
        self.mPropsGrid:setParent(self.mTransAction)
        self.mPropsGrid:setIsShowUseInTip(true)
        self.mPropsGrid:setClickEnable(false)
        self.mPropsGrid.onDefaultClickHandler = function()
            if self.mPropsGrid == nil then
                return
            end
            local isNew = read.ReadManager:isModuleRead(ReadConst.NORMALBAGITEM, self.propsVo.tid)
            if isNew then
                GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NORMALBAGITEM, id = self.propsVo.tid })
            end

            TipsFactory:propsTips({ propsVo = self.propsVo, isShowUseBtn = self.mPropsGrid:getIsShowUseInTip() }, { rectTransform = self.mPropsGrid:getIconRect() })
        end


        -- 此处屏蔽，由PropsGrid默认的触发tip动画
        -- self.mPropsGrid:setCallBack(self, self.onClickGridHandler)
        -- self:setNormalSelect(selectVo:getSelect())
        -- 分解选中
        if selectVo:getArgs() and selectVo:getArgs().selectBreak then
            self:setDecomposeSelect(selectVo:getArgs().selectBreak)
        else
            self:setDecomposeSelect(false)
        end
        bag.BagManager:addEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)
        self:updateBubbleState()
    else
        self:deActive()
    end

end

function updateBubbleState(self)
    if self.data.m_dataVo then
        self:updateBubbleView()
    end

end

function onClickGridHandler(self, args)
    local selectVo = self.data

    local rect = self.mPropsGrid:getIconRect()
    local id = self.propsVo.id or 0
    local isNew = read.ReadManager:isModuleRead(ReadConst.NORMALBAGITEM, self.propsVo.tid)
    if isNew then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NORMALBAGITEM, id = self.propsVo.tid })
    end
    logInfo("道具id：" .. id .. ", tid: " .. self.propsVo.tid)
    bag.BagManager:dispatchEvent(bag.BagManager.SELECT_PROPS_GRID, { selectVo = selectVo, isShowUseBtn = self.mPropsGrid:getCanUseInTip(), rectTransform = rect })
    -- self:updateBubbleView(false)
end

function updateBubbleView(self)
    if (read.ReadManager:isModuleRead(ReadConst.NORMALBAGITEM, self.propsVo.tid)) then
        if self.UIObject then
            RedPointManager:remove(self.m_childTrans["GroupAction"])
            RedPointManager:add(self.m_childTrans["GroupAction"], UrlManager:getCommon5Path("common_0223.png"), 45, 59.2)
        end
    else
        local showRed = true
        if self.propsVo.effectType == UseEffectType.USE_GET_HEROEGG then
            local maxCount = bag.BagManager:getPropsCountByTid(self.propsVo.tid)
            local needCount = self.propsVo.effectList[1] 
            showRed = maxCount >= needCount
        end
        if self.UIObject and showRed then
            RedPointManager:remove(self.m_childTrans["GroupAction"])
            RedPointManager:add(self.m_childTrans["GroupAction"], nil, 64, 64)
        else
            RedPointManager:remove(self.m_childTrans["GroupAction"])
        end
    end
end

function destroy(self)
    super.destroy(self)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]