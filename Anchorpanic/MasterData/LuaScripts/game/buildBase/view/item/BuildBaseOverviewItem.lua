module("buildBase.BuildBaseOverviewItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.gridItem = {}
    self.headItem = {}

    self.mImgRoom = self:getChildGO("mImgRoom"):GetComponent(ty.AutoRefImage)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mTxtLvNum = self:getChildTrans("mTxtLvNum"):GetComponent(ty.Text)
    self.mTxtRoomName = self:getChildGO("mTxtRoomName"):GetComponent(ty.Text)
    self.mHeadStateGroup = self:getChildTrans("mHeadStateGroup")
    self.mGrid = self:getChildGO("mGrid")
    self.HeroStateGrid = self:getChildGO("HeroStateGrid")
    self:addOnClick(self:getChildGO("mClickArea"), self.onClickItemHandler)
end

function setData(self, param)
    super.setData(self, param)
    -- self.msgVo = self.data
    self.mConfigVo = buildBase.BuildBaseManager:getBuildBasePosDataByPos(self.data.id)
    self.mConfigLvVo = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(self.mConfigVo.buildType):getLevelDataVo(self.data.lv)
    self:updateView()
end

function updateView(self)
    if  buildBase.BuildBaseManager:getSumStaminaHasZeroByBuildId(self.mConfigVo.id) then 
        RedPointManager:add(self:getChildTrans("mImgRoom"),nil,-158,62)
    else 
        RedPointManager:remove(self:getChildTrans("mImgRoom"))
    end 
    buildBase.BuildBaseManager:checkIsEmpty()
    self:recoverGridItem()
    self.mImgRoom:SetImg(UrlManager:getPackPath(self.mConfigVo.icon))
    self.mImgSelect:SetActive(self.data.select)
    self.mTxtLvNum.text = self.data.lv
    self.mTxtRoomName.text = _TT(self.mConfigVo.name)
    local settleLimit = self.mConfigLvVo.num
    for i=1, 5 do
        local grid = SimpleInsItem:create(self.mGrid, self.mHeadStateGroup, "BuildBaseOverviewItemmGridItem")
        local add = grid:getChildGO("mAdd")
        local none = grid:getChildGO("mImgNone")
        -- local headNode = grid:getChildTrans("mHeadNode")
        add:SetActive(i <= settleLimit)
        none:SetActive(i > settleLimit)
        local function onClickAdd()
            buildBase.BuildBaseManager:setNowBuildId(self.data.id)
            GameDispatcher:dispatchEvent(EventName.OPEN_BUILDBASE_SETTLEINLIST_PANEL, {buildBaseVo = self.data})
        end
        grid:addUIEvent("mAdd", onClickAdd)
        table.insert(self.gridItem, grid)
    end
    self:updateHeadGrid()
end

function updateHeadGrid(self)
    self:recoverHeadGrid()
    for i=1, #self.data.heroList do
        local node = self.gridItem[i]:getChildTrans("mHeadNode")
        local headGrid = buildBase.BuildBaseStateGrid:poolGet()
        headGrid:setData(self.data.heroList[i])
        headGrid:setParent(node)
        table.insert(self.headItem, headGrid)
    end
end

function onClickItemHandler(self)
    if not self.data.select then 
        GameDispatcher:dispatchEvent(EventName.SELECT_OVERVIEW_BUILD, self.data.id)
    end
end

function recoverGridItem(self)
    for k,v in pairs(self.gridItem) do
        v:poolRecover()
    end
    self.gridItem = {}
end

function recoverHeadGrid(self)
    for k,v in pairs(self.headItem) do
        v:poolRecover()
    end
    self.headItem = {}
end

function deActive(self)
    super.deActive(self)
    self:recoverGridItem()
    self:recoverHeadGrid()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]