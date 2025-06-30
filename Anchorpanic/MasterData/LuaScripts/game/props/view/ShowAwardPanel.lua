module("ShowAwardPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("reward/ShowAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

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
        self.mInstance = ShowAwardPanel.new()
        self.mInstance:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end

    -- end
    return self.mInstance
end

-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 460)
    -- self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
    self.mItemList = {}
    self.mCloseCall = nil
    self.mlist = {}
    self.mIsNoTween = nil
end

function configUI(self)
    self.mScrollContent = self:getChildTrans("Content")
    self.mScroller = self:getChildTrans("Scroll View")
    self.mImgNext = self:getChildGO('mImgNext')
    self.mAni = self.UIObject:GetComponent(ty.Animator)
    self.mImgTitle = self:getChildGO('mImgTitle'):GetComponent(ty.AutoRefImage)
end

-- 设置全屏透明遮罩
function setMask(self)
    super.setMask(self)

    self:setGuideTrans("guide_ShowAwardPanel_CloseBtn", self.mask.transform)
end

function active(self, args)
    super.active(self, args)
    self:setGuideTrans("guide_ShowAwardPanel_close", self.mask.transform)
    GameDispatcher:dispatchEvent(EventName.SHOW_AWARD_PANEL_OPEN)
end

function deActive(self)
    super.deActive(self)
    -- self.m_scroller:ResetItem()
    self:clearItem()
end

function close(self)
    super.close(self)
    self:runCallFun()
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_basic_gain.prefab")
end

-- 按照策划要求合并道具
function getMergePropsList(self, list)
    -- 按照策划要求不合并道具
    -- 后端说后端会进行合并
    -- return list
    local mergeList = {}
    for i = 1, #list do
        local vo = nil
        for j = 1, #mergeList do
            if ((list[i].type == PropsType.Money or list[i].type == PropsType.NORMAL or list[i].type == PropsType.SPECIAL) and list[i].tid == mergeList[j].tid) then
                vo = mergeList[j]
                break
            end
        end
        if (vo) then
            vo.count = vo.count + list[i].count
        else
            table.insert(mergeList, list[i])
        end
    end
    return mergeList
end

-- 回调方法相关
function setCallFun(self, callFun)
    self.mCloseCall = callFun
end

function getCallFun(self)
    return self.mCloseCall
end

function __closeOpenAction(self)
    if (self.panelType ~= 1 and not self.isCloseing) then
        self.isCloseing = true
        local tweenTime = AnimatorUtil.getAnimatorClipTime(self.mAni, "ShowAwardPanel_Exit")
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

function runCallFun(self)
    if self.mCloseCall then
        self.mCloseCall()
        self.mCloseCall = nil
    end
end

-- 道具tid列表
function showTidList(self, cusTidList, closeCall, isNoTween)
    -- logError("==========showTidList")
    self:setCallFun(closeCall)
    local list = {}
    for i = 1, #cusTidList do
        local propsVo = props.PropsManager:getPropsVo({ tid = cusTidList[i], num = 1 })
        table.insert(list, propsVo)
    end
    table.sort(list, bag.BagManager.sortPropsListByDescending)
    self:openView(list)
end

-- 道具实体vo列表
function showPropsList(self, cusPropsList, closeCall, isNoTween, isMerge)
    self.isMerge = isMerge == nil and false or true
    self:setCallFun(closeCall)
    local list = cusPropsList
    table.sort(list, bag.BagManager.sortPropsListByDescending)
    if self.isMerge then
        list = self:getMergePropsList(list)
    end
    self:openView(list)
end

-- 掉落表奖励id
function showAwardId(self, awardId, closeCall, isNoTween)
    self:setCallFun(closeCall)
    local list = AwardPackManager:getAwardListById(awardId)
    -- table.sort(list, bag.BagManager.sortPropsListByDescending)
    self:openView(list)
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
    table.sort(list, bag.BagManager.sortPropsListByDescending)

    if self:checkEggRewardShow(list) then
        return
    else
        self:openView(list)
    end
    -- local instance = self:getInstance()
    -- instance:createPropsGrid(list)
    -- instance:open()
end

--dnaEgg开道具动画
function checkEggRewardShow(self, award_propsVoList)
    local isOpenEggProps = bag.BagManager:getIsOpenEggProps()
    --检查是否打开过相关道具
    if not isOpenEggProps then
        return false
    end
    --检查是否包含dna蛋道具
    local isEggProp, eggMaxQuality = false, 0
    for _, propsVo in ipairs(award_propsVoList) do
        if propsVo.type == PropsType.HEROEGG then
            isEggProp = true
            local eggCfgVo = dna.DnaManager:getSingleEggDataCfgVoByItemId(propsVo.tid)
            if eggCfgVo.quality > eggMaxQuality then
                eggMaxQuality = eggCfgVo.quality
            end
        end
    end
    if not isEggProp then
        return false 
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_DNA_OPEN_BOX_EFX_PANEL, {
        eggMaxQuality = eggMaxQuality,
        callBack = function ()
            self:openView(award_propsVoList)
        end
    })

    return true
end

function openView(self, list)
    local instance = self:getInstance()
    if instance.isPop == 1 then
        if not self.waitList then
            self.waitList = {}
        end
        for i, v in ipairs(list) do
            table.insert(self.waitList, v)
        end
    else
        instance:createPropsGrid(list)
        instance:open()
    end
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
    self:setTimeout(0.23, function()
        for i = #self.mlist, 1, -1 do
            if self.mlist[i].num and self.mlist[i].num > 0 then
                self.mlist[i].count = self.mlist[i].num
            end
            if (self.mlist[i].count and self.mlist[i].count > 0) then
                local propsVo = self.mlist[i]
                local grid = ShowAwardItem:poolGet()
                grid:setData(self.mScrollContent, propsVo)
                table.insert(self.mItemList, grid)
            end
        end
        self:getChildGO("Viewport"):GetComponent(ty.RaycastEmptyEvent).enabled = #self.mlist > 8
        self:getChildGO("mImgToucher"):SetActive(false)
    end)

end

function clearItem(self)
    for i = #self.mItemList, 1, -1 do
        self.mItemList[i]:poolRecover()
        self.mItemList[i] = nil
    end
    self.mItemList = {}
end

function setImgTitle(self, str)
    self.mImgTitle:SetImg(str)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]