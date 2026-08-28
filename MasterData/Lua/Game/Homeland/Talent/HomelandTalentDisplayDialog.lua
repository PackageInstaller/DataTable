
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util                  = require 'XLua.util'
local CoWait                = CS.Engine.Lib.CoWait
---@type HomelandTalentConfMgr
local HomelandTalentConfMgr = import("Game.Homeland.Talent.HomelandTalentConfMgr")
---@type HomelandTalentConstants
local HomelandTalentConstants = import("Game.Homeland.Talent.HomelandTalentConstants")
---@type HomelandTalentUtils
local HomelandTalentUtils = import("Game.Homeland.Talent.HomelandTalentUtils")
local UIModule = CS.Engine.UI.UIModule
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Homeland/HomelandTalentDisplayDialog.prefab > name: HomelandTalentDisplayDialog
---@class HomelandTalentDisplayDialog
---@field Env                           	HomelandTalentDisplayDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LabelList                     	SuperScrollView.LoopListView2           	@ 0    
---@field ScrollView                    	SuperScrollView.LoopListView2           	@ 1    
---@field Content                       	UnityEngine.RectTransform               	@ 2    
---@field Reference                     	UnityEngine.RectTransform               	@ 3    
---@field BtnReset                      	UnityEngine.RectTransform               	@ 4    
local HomelandTalentDisplayDialog = Class('HomelandTalentDisplayDialog')


function HomelandTalentDisplayDialog:__init()
    self._selectLabelPos  = 1
    self._selectTalentTreePos = 0
    self._selectTalentDataIndex = 0
end


function HomelandTalentDisplayDialog:__delete()
    self.controller = nil
end


-- function HomelandTalentDisplayDialog:Awake()
-- end


function HomelandTalentDisplayDialog:OnFocus(focus)

end


function HomelandTalentDisplayDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        self:FreshUI()


    end))
    return coWait
end


function HomelandTalentDisplayDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self._referencePosition = self.Reference.transform.position
    end))
    return coWait
end


function HomelandTalentDisplayDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:RemoveListeners()

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function HomelandTalentDisplayDialog:OnInit()
    self:InitData()
    self:InitAction()

end

function HomelandTalentDisplayDialog:InitData()
    ---@type HomelandTalentComponent
    local component     = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HomelandTalentComponent)
    ---@type HomelandTalentLabelVo[]
    local labelVos      = HomelandTalentConfMgr:GetAllHomelandTalentLabelVo()
    local displayLabels = HomelandTalentConfMgr:GetDisplayLabels()

    ---@type HomelandTalentDojo
    local dojo          = component:GetHomelandTalentDojo()

    local vos = {}
    for index, labelVo in ipairs(labelVos) do
        if displayLabels[labelVo.id] then
            table.insert(vos, labelVo)
        end
    end

    self._labelVos      = vos
    self._displayLabels = displayLabels
    self._dojo = dojo

    self:GenerateTalentTreeDataList()
    -- print(table.serialize(self._talentTreeDataList))

    HomelandTalentUtils.SetIsClickTalent()
    component:UpdateHomelandTalentEntryRedPoint()
end

function HomelandTalentDisplayDialog:InitAction()
    local listenerConf = {
        [HomelandTalentConstants.EventNames.RequestSuccess] = Bind(self, self.OnRequestSuccess),
        [HomelandTalentConstants.EventNames.CloseDetailPopup] = Bind(self, self.OnCloseDetailPopup),
    }
    for eventName, func in pairs(listenerConf) do
        Events.AddListener(eventName, func)
    end

    self._listenerConf = listenerConf

end


function HomelandTalentDisplayDialog:RemoveListeners()
    for eventName, func in pairs(self._listenerConf) do
        Events.RemoveListener(eventName, func)
    end
end



--endregion 


--region logic 

function HomelandTalentDisplayDialog:FreshUI()
    self:FreshLabelList(self._labelVos)
    self:RefreshScrollView()
    self:RefreshResetBtn()
end

function HomelandTalentDisplayDialog:RefreshResetBtn()
    SetButtonAction(self.BtnReset.gameObject, Bind(self, self.OnClickResetBtnAction))
end

function HomelandTalentDisplayDialog:RefreshScrollView()
    self._labelType = self:GetLabelType()
    self:FreshScrollView(self:GetTalentTreeDataList())

end


function HomelandTalentDisplayDialog:FreshLabelList(dataList)
    local scrollView = self.LabelList
    local count      = #dataList
    
    if not scrollView.IsListViewInit then
        scrollView:InitListView(count, Bind(self, self.OnGetLabelByIndex))
        scrollView:UpdateDisplayItemCount(HomelandTalentConstants.NodeNames.LabelNode)
    else
        GameUtils.ReloadData(scrollView, count)
    end
end

function HomelandTalentDisplayDialog:OnGetLabelByIndex(listView, index, row, column)
    if index < 0 then return nil end
    local cell = listView:NewListViewItem(HomelandTalentConstants.NodeNames.LabelNode)

    local cellViewMB = GetLuaBehaviour(cell.gameObject, HomelandTalentConstants.EnvPath.HomelandTalentDisplayLabelNode)
    ---@type HomelandTalentDisplayLabelNode
    local mbEnv = cellViewMB.Env
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        if cellViewMB.Env == nil then
            cellViewMB:Init()
        end
        mbEnv = cellViewMB.Env
        mbEnv:SetCallback(Bind(self, self.OnClickLabelNodeAction))
    
    end

    if mbEnv == nil then return end
    local pos       = index + 1
    ---@type HomelandTalentLabelVo
    local labelVo   = self._labelVos[pos]
    -- print(table.toString(labelVo))

    local labelType = labelVo.id
    mbEnv:FreshUI(labelVo, labelType, pos)
    mbEnv:FreshSelectState(pos == self._selectLabelPos)

    if listView.DisplayItemNumber < listView.DisplayItemCount then
        mbEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
        listView.DisplayItemNumber = listView.DisplayItemNumber + 1
    else
        mbEnv:PlayAnimByIdle()
    end

    return cell
end

function HomelandTalentDisplayDialog:FreshLabelSelectState(pos, isSelect)
    local scrollView = self.LabelList
    local item = scrollView:GetShownItemByItemIndex(pos - 1)
    ---@type HomelandTalentDisplayLabelNode
    local cellViewMB = CfUtils.GetLuaScr(item, HomelandTalentConstants.EnvPath.HomelandTalentDisplayLabelNode)
    if isNull(cellViewMB) then
        return
    end
    cellViewMB:FreshSelectState(isSelect)
end

function HomelandTalentDisplayDialog:RefreshTalentTree()
    self._selectTalentTreePos = 0
    self._selectTalentDataIndex = 0

    self:GenerateTalentTreeDataList()
    self:RefreshScrollView()
end

function HomelandTalentDisplayDialog:FreshScrollView(dataList)
    local scrollView = self.ScrollView
    local count = #dataList
    if not scrollView.IsListViewInit then
        scrollView:InitListView(count, Bind(self, self.OnGetCellByIndex))
    else
        GameUtils.ReloadData(scrollView, count)
    end
end

function HomelandTalentDisplayDialog:OnGetCellByIndex(listView, index, row, column)
    if index < 0 then return nil end
    local pos = index + 1
    local talentTreeDataList = self:GetTalentTreeDataList()
    local talentTreeData = talentTreeDataList[pos]
    if next(talentTreeData) == nil then
        return listView:NewListViewItem(HomelandTalentConstants.NodeNames.CellEmpty)
    end    
    local cell = listView:NewListViewItem(HomelandTalentConstants.NodeNames.Cell)

    local cellViewMB = GetLuaBehaviour(cell.gameObject, HomelandTalentConstants.EnvPath.HomelandTalentDisplayCell)
    ---@type HomelandTalentDisplayCell
    local mbEnv = cellViewMB.Env
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        if cellViewMB.Env == nil then
            cellViewMB:Init()
        end
        mbEnv = cellViewMB.Env
        mbEnv:SetCallback(Bind(self, self.OnClickCellAction))
    end

    
    if mbEnv == nil then return end
    
    mbEnv:FreshUI(talentTreeData, talentTreeDataList[pos + 1], pos, self._labelType, self._selectTalentDataIndex, pos == self._selectTalentTreePos)

    return cell
end

function HomelandTalentDisplayDialog:FreshCellSelectState(isSelect, cellIndex, dataIndex)
    local scrollView = self.ScrollView
    local item = scrollView:GetShownItemByItemIndex(cellIndex - 1)
    ---@type HomelandTalentDisplayCell
    local cellViewMB = CfUtils.GetLuaScr(item, HomelandTalentConstants.EnvPath.HomelandTalentDisplayCell)
    if isNull(cellViewMB) then
        return
    end
    cellViewMB:FreshSelectState(isSelect, dataIndex)
end

function HomelandTalentDisplayDialog:FreshTalentTreeCell(pos, data, nextData, dataIndex, isPlayUpgradeEff)
    local item = self:GetTalentCell(pos)
    ---@type HomelandTalentDisplayCell
    local cellViewMB = CfUtils.GetLuaScr(item, HomelandTalentConstants.EnvPath.HomelandTalentDisplayCell)
    if isNull(cellViewMB) then
        return
    end
    -- print(dataIndex, pos == self._selectTalentTreePos)
    cellViewMB:FreshUI(data, nextData, pos, self._labelType, dataIndex, pos == self._selectTalentTreePos, isPlayUpgradeEff)
end

function HomelandTalentDisplayDialog:FreshDetailPopup()
    ---@type HomelandTalentDetailsPopup
    local env = self._detailPopupEnv
    if isNull(env) then
        return
    end

    local cell = self:GetTalentCell(self._selectTalentTreePos)
    -- if isNotNull(cell) then
    --     local position = cell.transform.position
        
    --     local diff = position.x - self._referencePosition.x
    --     if diff > 0 then
    --         local contentPos = self.Content.position
    --         self.Content.position = Vector3.New(contentPos.x - diff, contentPos.y, contentPos.z) 
    --     end
    -- end


    local talentTreeData = self:GetTalentTreeDataList()[self._selectTalentTreePos]
    local talentData = talentTreeData[self._selectTalentDataIndex]
    env:FreshUI(talentData, self._labelType)
end

function HomelandTalentDisplayDialog:PlayDetailPopupUpgradeEff()
    ---@type HomelandTalentDetailsPopup
    local env = self._detailPopupEnv
    if isNull(env) then
        return
    end
    env:PlayUpgradeEffect()
        
end

--endregion 


--region get/set 


function HomelandTalentDisplayDialog:GetLabelType()
    ---@type HomelandTalentLabelVo
    local labelVo = self._labelVos[self._selectLabelPos]
    local labelType = labelVo.id
    return labelType
end

function HomelandTalentDisplayDialog:GenerateTalentTreeDataList()
    local labelType      = self:GetLabelType()
    local talentConfData = self._displayLabels[labelType]
    local talentId2Data  = self._dojo:GetTalentId2Data()
    self._talentTreeDataList = HomelandTalentUtils.GenerateTalentTreeDataList(talentConfData, talentId2Data)

    table.insert(self._talentTreeDataList, {})
    table.insert(self._talentTreeDataList, {})

    return self:GetTalentTreeDataList()
end

function HomelandTalentDisplayDialog:GetTalentTreeDataList()
    return self._talentTreeDataList
end

function HomelandTalentDisplayDialog:GetTalentCell(pos)
    local scrollView = self.ScrollView
    local item = scrollView:GetShownItemByItemIndex(pos - 1)
    return item
end

---endregion 


--region handler 

--- 重置天赋按钮
function HomelandTalentDisplayDialog:OnClickResetBtnAction()
    local canReset = false
    local treeData = self:GetTalentTreeDataList()
    local location1 = treeData[1]
    for i, data in ipairs(location1) do
        if checkNumber(data.talentLv) > 0 then
            canReset = true
            break
        end
    end

    if not canReset then
        GameUtils.Toast(localize("没有可重置的战略点"))
        return
    end

    local curLabelType = self:GetLabelType()
    local vo = HomelandTalentConfMgr:GetHomelandTalentLabelVo(curLabelType)
    if isNull(vo) then
        printError(string.format("未找到切页 %d 配表信息", checkNumber(curLabelType)))
        return
    end
    local consumes = vo.resetConsumes

    GameUtils.SecondConfirm(localize("确认消耗以下材料重置当前路线上的全部战略点?"), function()
        local realConsume, errorTip = GoodsUtils.CheckGoodConsume(consumes)
        if errorTip then
            GoodsUtils.CheckConsumeDataCondition(consumes)
            return
        end

        ---@type HomelandTalentComponent
        local component = GameUtils.GetEntityCompByType(ECSComponentType.Constants.HomelandTalentComponent)
        component:RequestResetTalent(curLabelType, realConsume)
    end, nil, nil, 4, consumes, true, nil, nil, nil, UIModule.RootCanvas.transform, 2)
end

---OnClickLabelNodeAction
---@param pos number
function HomelandTalentDisplayDialog:OnClickLabelNodeAction(pos)
    if self._selectLabelPos == pos then return false end
    local oldPos = self._selectLabelPos
    self._selectLabelPos = pos

    self:RefreshTalentTree()
    self:FreshLabelSelectState(oldPos, false)

    return true
end

function HomelandTalentDisplayDialog:OnClickCellAction(_, pos, dataIndex)
    if self._selectTalentDataIndex > 0 and self._selectTalentTreePos > 0 then
        self:FreshCellSelectState(false, self._selectTalentTreePos, self._selectTalentDataIndex)
    end

    self._selectTalentTreePos = pos
    self._selectTalentDataIndex = dataIndex

    if self._isLoading then
        return
    end

    self:FreshCellSelectState(true, pos, dataIndex)
    
    if isNotNull(self._detailPopupEnv) then
        self:FreshDetailPopup()
    else
        self._isLoading = true
        UICommonUtils.LoadGameObject(HomelandTalentConstants.PrefabPath.HomelandTalentDetailsPopup, function (go)
            if isNull(self) then return end
            self._isLoading = false
            self._detailPopupEnv = CfUtils.GetLuaScr(go, HomelandTalentConstants.EnvPath.HomelandTalentDetailsPopup)
            self:FreshDetailPopup()
        end, self.controller.transform)
    end
    
    -- GameUtils.LoadBundleAsync(HomelandTalentConstants.PrefabPath.HomelandTalentDetailsPopup, self.P)
    -- CfUtils.DialogOpen(Constants.UITypeIds.HomelandTalentDetailsPopup, {data = data, labelType = self._labelType})

end

function HomelandTalentDisplayDialog:OnRequestSuccess(interface, resultData, requestData)
    if interface == Interfaces.TalentUnlock or interface == Interfaces.TalentUpgrade then
        local selectTalentPos = self._selectTalentTreePos
        local dataIndex       = self._selectTalentDataIndex
        local talentTreeDataList = self:GetTalentTreeDataList()
        ---更新当期位置的天赋树数据
        local talentTreeData = talentTreeDataList[selectTalentPos]
        local talentData     = talentTreeData[dataIndex]
        talentData = HomelandTalentUtils.UpdateTalentDataStatus(talentData, resultData)
        talentTreeData[dataIndex] = talentData
        talentTreeDataList[selectTalentPos] = talentTreeData

        ---更新下一位置的天赋树数据
        local nextTalentTreeData = talentTreeDataList[selectTalentPos + 1]
        if nextTalentTreeData then
            nextTalentTreeData = HomelandTalentUtils.UpdateTalentTreeData(nextTalentTreeData, self._dojo:GetTalentId2Data())
            talentTreeDataList[selectTalentPos + 1] = nextTalentTreeData
        end

        self:FreshTalentTreeCell(selectTalentPos, talentTreeData, nextTalentTreeData, dataIndex, true)
        if nextTalentTreeData then
            self:FreshTalentTreeCell(selectTalentPos + 1, nextTalentTreeData, talentTreeDataList[selectTalentPos + 2])
        end

        self:PlayDetailPopupUpgradeEff()
    elseif interface == Interfaces.TalentReset then
        self:RefreshTalentTree()
    end
end

function HomelandTalentDisplayDialog:OnCloseDetailPopup()
    if self._selectTalentDataIndex > 0 and self._selectTalentTreePos > 0 then
        self:FreshCellSelectState(false, self._selectTalentTreePos, self._selectTalentDataIndex)
    end

end

---endregion 


return HomelandTalentDisplayDialog
