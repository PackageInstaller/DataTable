module("cycle.CycleShowAwardPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("cycle/CycleShowAwardPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

function getInstance(self)
    -- 每次关闭都会被销毁，不用单例
    local destroyView = function()
        self.mInstance:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.mInstance = nil

        if self.waitList and #self.waitList > 0 then
            self:openView(self.waitList)
        end
        self.waitList = {}
    end
    if not self.mInstance then
        self.mInstance = cycle.CycleShowAwardPanel.new()
        self.mInstance:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    -- end
    return self.mInstance
end

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mItemList = {}
    self.mCloseCall = nil
    self.mlist = {}
    self.mIsNoTween = nil
end

function configUI(self)

    self.mImgCollIcon = self.m_childGos["mImgCollIcon"]:GetComponent(ty.AutoRefImage)
    self.mTxtName = self.m_childGos["mTxtName"]:GetComponent(ty.Text)
    self.mTxtDes_01 = self.m_childGos["mTxtDes_01"]:GetComponent(ty.Text)
    self.mTxtDes_02 = self.m_childGos["mTxtDes_02"]:GetComponent(ty.Text)
    --  self.mImgTitle = self:getChildGO('mImgTitle'):GetComponent(ty.AutoRefImage)
end

function active(self, args)
    super.active(self, args)
    self.UIRootNode:SetParent(GameView.story, false)

    self:setAdapta()
    self:setGuideTrans("guide_ShowAwardPanel_close", self.mask.transform)
    GameDispatcher:dispatchEvent(EventName.SHOW_AWARD_PANEL_OPEN)
end

function deActive(self)
    super.deActive(self)
    -- self.m_scroller:ResetItem()

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


function runCallFun(self)
    if self.mCloseCall then
        self.mCloseCall()
        self.mCloseCall = nil
    end
end

-- 道具tid列表
function showTidList(self, colletionTid, closeCall, isNoTween)
    -- logError("==========showTidList")
    self:setCallFun(closeCall)

    self:openView()
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
    self:openView()
end

-- 掉落表奖励id
function showAwardId(self, awardId, closeCall, isNoTween)
    self:setCallFun(closeCall)
    local list = AwardPackManager:getAwardListById(awardId)
    table.sort(list, bag.BagManager.sortPropsListByDescending)
    self:openView()
end

-- 服务器奖励模版列表
function showPropsAwardMsg(self, colletionTid, closeCall)
    if colletionTid > 0 then
        self.colletionTid = colletionTid
        self:setCallFun(closeCall)
        self:openView()
    else
        logError("Msg colletionTid 不在配置表中")
    end
end

function openView(self, list)
    local instance = self:getInstance()
    if instance.isPop == 1 then
        -- if not self.waitList then
        --     self.waitList = {}
        -- end
        -- for i, v in ipairs(list) do
        --     table.insert(self.waitList, v)
        -- end
    else
        instance:createPropsGrid()
        instance:open()
    end
end

function createPropsGrid(self)
    -- self.mlist = list
    self:removeAllTimer()

    self:getChildGO("mImgToucher"):SetActive(true)
    -- local showAwardNum = math.ceil(self.mScroller.rect.size.x / 130)
    -- if #self.mlist >= showAwardNum then
    --     self.mImgNext:SetActive(true)
    -- else
    --     self.mImgNext:SetActive(false)
    -- end
    self:setTimeout(0.23, function()
        -- for i = #self.mlist, 1, -1 do
        --     if self.mlist[i].num and self.mlist[i].num > 0 then
        --         self.mlist[i].count = self.mlist[i].num
        --     end
        --     if (self.mlist[i].count and self.mlist[i].count > 0) then
        --         local propsVo = self.mlist[i]
        --         local grid = ShowAwardItem:poolGet()
        --       --  grid:setData(self.mScrollContent, propsVo)
        --         table.insert(self.mItemList, grid)
        --     end
        -- end
        local collectionVo = cycle.CycleManager:getCycleCollectionDataById(self.colletionTid)
        self.mImgCollIcon:SetImg(UrlManager:getCycelCollectionIcon(collectionVo.icon), false)
        self.mTxtName.text = _TT(collectionVo.name)
        self.mTxtDes_01.text = _TT(collectionVo.des2)
        self.mTxtDes_02.text = _TT(collectionVo.des)
        self:getChildGO("mImgToucher"):SetActive(false)
    end)

end



function setImgTitle(self, str)
    self.mImgTitle:SetImg(str)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
