-- @FileName:   RoundPrizeShowAwardPanel.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-12-23 17:22:33
-- @Copyright:   (LY) 2024 锚点降临

module("game.roundPrize.RoundPrizeShowAwardPanel", Class.impl(ShowAwardPanel))

UIRes = UrlManager:getUIPrefabPath("roundPrize/RoundPrizeShowAwardPanel.prefab")

function getInstance(self)
    -- 每次关闭都会被销毁，不用单例
    -- if(not self.mInstance)then
    local destroyView = function()
        self.mInstance:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.mInstance = nil

        if self.waitList and #self.waitList > 0 then
            self:openView(self.waitList)
        end
        self.waitList = {}
    end

    if not self.mInstance then
        self.mInstance = roundPrize.RoundPrizeShowAwardPanel.new()
        self.mInstance:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end

    -- end
    return self.mInstance
end

function __closeOpenAction(self)
    if (self.panelType ~= 1 and not self.isCloseing) then
        self.isCloseing = true
        local tweenTime = AnimatorUtil.getAnimatorClipTime(self.mAni, "RoundPrizeShowAwardPanel_Exit")
        gs.UIBlurManager.SetSuperBlur(false, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)

        if self.mBlurMask then
            gs.GameObject.Destroy(self.mBlurMask)
            self.mBlurMask = nil
        end
        if self.UIObject then
            self.mAni:SetTrigger("exit")
            local _viewTweenFinishCall = function()
                if self.isPop == 1 then
                    self:close()
                end
            end
            self:addTimer(tweenTime, tweenTime, _viewTweenFinishCall)
        end
    end
end


-- 服务器奖励模版列表
function showPropsAwardMsg(self, cusPropsList, closeCall)
    self:setCallFun(closeCall)
    local list = {}
    for _, v in ipairs(cusPropsList) do
        local configVo = props.PropsManager:getPropsConfigVo(v.tid)
        if configVo.type == PropsType.EQUIP then
            -- 服务器发来的会自动合并tid一样的，前端先全部拆分
            local count = v.count
            v.count = 1
            for i = 1, count do
                local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
                equipVo:setPropsAwardMsgData(v)
                table.insert(list, equipVo)
            end
        else
            local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
            propsVo:setPropsAwardMsgData(v)
            table.insert(list, propsVo)
        end
    end

    self:openView(list)
end


function createPropsGrid(self, list)
    self.mlist = list
    self:removeAllTimer()
    self:clearItem()
    self:getChildGO("mImgToucher"):SetActive(true)
    local showAwardNum = math.ceil(self.mScroller.rect.size.x / 130)
    if #self.mlist >= showAwardNum then
        self.mImgNext:SetActive(true)
    else
        self.mImgNext:SetActive(false)
    end

    for i = 1, #self.mlist do
        if self.mlist[i].num and self.mlist[i].num > 0 then
            self.mlist[i].count = self.mlist[i].num
        end
        if (self.mlist[i].count and self.mlist[i].count > 0) then
            local grid = ShowAwardItem:poolGet()
            grid:setParentTrans(self.mScrollContent, 0)

            table.insert(self.mItemList, grid)
        end
    end

    local create_index = #self.mlist
    self:addTimer(0.25, #self.mlist, function ()
        local grid = self.mItemList[create_index]
        local propsVo = self.mlist[create_index]
        grid:setData(nil, propsVo)

        if create_index <= 1 then
            self:getChildGO("Viewport"):GetComponent(ty.RaycastEmptyEvent).enabled = #self.mlist > 8
            self:getChildGO("mImgToucher"):SetActive(false)
        end

        create_index = create_index - 1
    end)

end

function close(self)
    super.close(self)

    GameDispatcher:dispatchEvent(EventName.ROUNDPRIZE_CLOSE_SHOWAWARDPANEL)
end

return _M
