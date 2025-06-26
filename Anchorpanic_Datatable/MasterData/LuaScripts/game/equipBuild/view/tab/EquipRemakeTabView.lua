module("equipBuild.EquipRemakeTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("equipBuild/tab/EquipRemakeTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    -- 当前装备数据vo
    self.mEquipVo = nil

    -- 最大改造部位数量
    self.mMaxRemakeCount = 2

    -- 改造部位
    self.mRemakePosItemDic = {}
end

function configUI(self)
    self.mScrollView = self:getChildTrans('Scroll View')
    self.m_groupContent = self:getChildGO('GroupContent')
    self.m_rightContent = self:getChildGO("RightContent")
    self.m_scrollContent = self:getChildTrans('Content')
    self.m_groupGrid = self:getChildTrans("GroupGrid")
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.m_textEquipName = self:getChildGO("TextEquipName"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.m_imgEmpty = self:getChildGO('ImgEmpty')
    self.m_textEmpty = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    -- self.mTxtAttr = self:getChildGO("mTxtAttr"):GetComponent(ty.Text)

    -- 改造部位相关
    for pos = 1, self.mMaxRemakeCount do
        local item = equipBuild.EquipRemakeInfoItem.new()
        item:setParentTrans(self.m_scrollContent)
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        self.mRemakePosItemDic[pos] = item
    end
    self.mImgBar = self:getChildGO("mImgBar"):GetComponent(ty.Image)

    self.m_transGuide_1 = self:getChildTrans("Guide_1")
    self:setGuideTrans("funcTips_remake_1", self:getChildTrans("Guide_1"))
end

function active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_EQUIP_REMAKE, self.onUpdateRemakeHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_REMAKE_UP_VIEW, self.onOpenEquipRemakeViewHandler, self)
    GameDispatcher:addEventListener(EventName.CHANGE_BRACELETS, self.updateView, self)

    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_REMAKE_TARGET_VIEW,self.onOpenEquipRemakeAgentViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_REMAKE_UP_AGENT_VIEW,self.onOpenEquipRemakeUpAgentViewHandler, self)

    
    self:updateView()
end

function deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_EQUIP_REMAKE, self.onUpdateRemakeHandler, self)
    GameDispatcher:removeEventListener(EventName.OPEN_EQUIP_REMAKE_UP_VIEW, self.onOpenEquipRemakeViewHandler, self)
    GameDispatcher:removeEventListener(EventName.CHANGE_BRACELETS, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.OPEN_EQUIP_REMAKE_TARGET_VIEW,self.onOpenEquipRemakeAgentViewHandler, self)
    GameDispatcher:removeEventListener(EventName.OPEN_EQUIP_REMAKE_UP_AGENT_VIEW,self.onOpenEquipRemakeUpAgentViewHandler, self)
    if self.showItem then
        -- 回收之前打开的
        self.showItem:closeContent()
        self.showItem = nil
    end

    if self.mGrid then
        self.mGrid:poolRecover()
        self.mGrid = nil
    end

    if self.materialPanel then
        self.materialPanel:onClickClose()
    end

    if self.materialAgentPanel then
        self.materialAgentPanel:onClickClose()
    end
    LoopManager:removeFrameByIndex(self.frameId)
end

function initViewText(self)
    self.m_textEmpty.text = _TT(4364)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.HeroEquipReTrofit })
end

-- 改造更新
function onUpdateRemakeHandler(self, args)
    local heroId = args.heroId
    local equipId = args.equipId
    local remakePos = args.remakePos
    if (heroId == self.mEquipVo.heroId and equipId == self.mEquipVo.id) then
        self:updateView()
    end
end

function updateView(self)
    self.mEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
    if self.mGrid then
        self.mGrid:poolRecover()
        self.mGrid = nil
    end
    self.mGrid = EquipGrid3:create(self.m_groupGrid, self.mEquipVo)
    self.mGrid:setClickEnable(false)
    self.mGrid:setShowEquipStrengthenLvl(false)
    self.mGrid:setIdxTap(false)
    -- self.mGrid:setPartScale(2 * 0.65)

    local color = ""
    if self.mEquipVo.color == 1 then
        color = "45cea2ff"
    elseif self.mEquipVo.color == 2 then
        color = "29acffff"
    elseif self.mEquipVo.color == 3 then
        color = "ff72f1ff"
    else
        color = "ff9e35ff"
    end
    self.mImgBar.color = gs.ColorUtil.GetColor(color)

    self.m_textEquipName.text = self.mEquipVo.name
    self.mTxtLv.text = self.mEquipVo.strengthenLvl

    -- 检测装备是否可改造
    if (equipBuild.EquipRemakeManager:isEquipCanRemake(self.mEquipVo.tid)) then
        self.m_groupContent:SetActive(true)
        self.m_imgEmpty:SetActive(false)
        self:updateAttrPosData()
    else
        self.m_groupContent:SetActive(false)
        self.m_imgEmpty:SetActive(true)
    end

    self:updateGuide()

    self:updateStrengthenAttr()
end

function updateStrengthenAttr(self)
    -- local mainAttrList, _ = self.mEquipVo:getMainAttr()
    -- if #mainAttrList > 0 then
    --     local preKey = mainAttrList[1].key
    --     local preValue = mainAttrList[1].value
    --     self.mTxtAttr.text = AttConst.getName(preKey) .. "   +" .. AttConst.getValueStr(preKey, preValue)
    -- end
end

-- 更新改造属性列表数据
function updateAttrPosData(self)
    local remakePosAttrList, remakePosAttrDic = self.mEquipVo:getRemakeAttr()
    local remakeCount = equipBuild.EquipRemakeManager:getRemakeCount(self.mEquipVo.tid)
    for pos = 1, remakeCount do
        local attrData = remakePosAttrDic[pos]
        local item = self.mRemakePosItemDic[pos]
        item:setData(pos, self.mEquipVo, attrData)
    end

    self:setMovementType()
end

function onItemChange(self, args)
    self.m_scrollContent:GetComponent(ty.ContentSizeFitter).enabled = false
    self.m_scrollContent:GetComponent(ty.ContentSizeFitter).enabled = true
    if args.isShow then
        if self.showItem then
            -- 回收之前打开的
            self.showItem:closeContent()
            self.showItem = nil
        end
        self.showItem = args.item
        self:onScollTo(args.item)
    else
        self.showItem = nil
        gs.TransQuick:LPosY(self.m_scrollContent, 0)
    end

    self:setTimeout(0.1, function()
        self:setMovementType()
    end)
end

function onScollTo(self, item)
    local scollTo = function()
        if self.m_scrollContent.rect.size.y >= self.mScrollView.rect.size.y then
            local posY = -item.UITrans.anchoredPosition.y - (item.UITrans.rect.size.y) / 2 - 10
            posY = math.max(posY, 0)
            posY = math.min(posY, (self.m_scrollContent.rect.size.y - self.mScrollView.rect.size.y))
            TweenFactory:move2LPosY(self.m_scrollContent, posY, 0.3)
        end
    end
    self.frameId = LoopManager:addFrame(3, 1, self, scollTo)
end

-- 修改滚动模式
function setMovementType(self)
    local h = self.m_scrollContent.rect.size.y
    local scrollTrans = self.mScrollView
    local scrollRect = self.mScrollView:GetComponent(ty.ScrollRect)
    if h > scrollTrans.rect.size.y then
        scrollRect.movementType = gs.ScrollRect.MovementType.Elastic
    else
        scrollRect.movementType = gs.ScrollRect.MovementType.Clamped
    end
end

function updateGuide(self)
    -- 检测装备是否可改造
    if (not equipBuild.EquipRemakeManager:isEquipCanRemake(self.mEquipVo.tid)) then
        self:setGuideTrans("weak_hero_equip_remake_1", self.m_transGuide_1)
    end
end

function onOpenEquipRemakeViewHandler(self, args)
    -- self.m_groupContent:SetActive(false)

    if self.materialPanel == nil then
        self.materialPanel = equipBuild.EquipRemakeUpView.new()
        local function _onDestroyPanelHandler(self)
            self.materialPanel:removeEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
            self.materialPanel = nil
            self:updateView()
        end
        self.materialPanel:addEventListener(View.EVENT_VIEW_DESTROY, _onDestroyPanelHandler, self)
    end

    -- local function _showRightView(visible, materialVo)
    --     -- self.m_rightContent:SetActive(not visible)
    --     -- self.mBtnFuncTips:SetActive(not visible)
    --     self.mSelectEquipVo = materialVo
    -- end
    -- self.materialPanel:setVisibleCall(_showRightView)
    self.materialPanel:setData(args)
    self.materialPanel:open()
end

function onOpenEquipRemakeAgentViewHandler(self,args)
    if self.materialAgentPanel == nil then
        self.materialAgentPanel = equipBuild.EquipRemakeUpTargetView.new()
        local function _onDestoryPanelHandler(self)
            self.materialAgentPanel:removeEventListener(View.EVENT_VIEW_DESTROY, _onDestoryPanelHandler, self)
            self.materialAgentPanel = nil
            
        end
        self.materialAgentPanel:addEventListener(View.EVENT_VIEW_DESTROY, _onDestoryPanelHandler, self)
    end
    self.materialAgentPanel:open(args)
end

function onOpenEquipRemakeUpAgentViewHandler(self,args)
    if self.materialUpAgentPanel == nil then
        self.materialUpAgentPanel = equipBuild.EquipRemakeUpAgentView.new()
        local function _onDestoryPanelHandler(self)
            self.materialUpAgentPanel:removeEventListener(View.EVENT_VIEW_DESTROY, _onDestoryPanelHandler, self)
            self.materialUpAgentPanel = nil
            
        end
        self.materialUpAgentPanel:addEventListener(View.EVENT_VIEW_DESTROY, _onDestoryPanelHandler, self)
    end
    self.materialUpAgentPanel:setData(args)
    self.materialUpAgentPanel:open(args)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]