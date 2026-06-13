local itemView = require("Framework.UI.Component.CircularScrollViewItem")
local PlotAtlasDrawItemCtrl = BaseClass("PlotAtlasDrawItemCtrl", itemView)
local M = PlotAtlasDrawItemCtrl

function M:Init()
    self._data = nil
end

function M:UpdateItem(data)
    self._data = data
    self._view.node_attr.localPosition = Vector3.zero
    self._view.node_info.localPosition = Vector3.zero
    self._view.node_intro.localPosition = Vector3.zero
    self._view.img_icon:SetPic(self._data.bigPicture, false)
    self._view.node_anim:Play("PlotAtlasDrawPopup", -1, 0)
    -- 详情区域 1
    self:_InitArea1()

    -- 属性区域 2
    self:_InitArea2()

    -- 种类区域 3
    self:_InitArea3()

    -- 简介区域 4
    self:_InitArea4()

    -- 报告区域 5
    self:_InitArea5()
end

function M:OnDispose()
    self._data = nil
    M.super.OnDispose(self)
end

function M:_ShowUnlockTip(openId)
    local openCfg = ConfigHelper.GetCfgByLua("openCondition", openId)
    GameHelper.Tips(ConfigHelper.GetLocalString(openCfg.tips))
end

function M:_InitArea1()
    self._view.txt_chTitle1:SetText(self._data.bookTitle1[1])
    local openCondition1 = self._data.openCondition1[1]

    if GameHelper.CheckLockByOpenConditionId(openCondition1) then
        self._view.txt_desc1:SetText(self._data.bookDesc1[1])
    else
        self._view.txt_desc1:SetText(5175)
        self._view.txt_desc1.gameObject:onClick(function(go)
            self:_ShowUnlockTip(openCondition1)
        end)
    end
end

function M:_InitArea2()
    self._view.txt_chTitle2:SetText(self._data.bookTotalTitle2)

    -- go:GetComponent( typeof(CS.GameX.EditorUIView) )
    local parent = self._view.attrItem.transform.parent
    parent:ClearChildren(self._view.attrItem.gameObject)
    for i = 1, #self._data.bookDesc2, 1 do
        local attrItem = self._view.attrItem:Instantiate()
        attrItem:SetActive(true)
        attrItem.node_back:SetActive(i % 2 == 0)
        attrItem:SetParent(parent)
        local openCondition = self._data.openCondition2[i]
        local title = ConfigHelper.GetLocalString(self._data.bookTitle2[i])
        local desc = ConfigHelper.GetLocalString(self._data.bookDesc2[i])

        if GameHelper.CheckLockByOpenConditionId(openCondition) then
            attrItem.txt_desc:SetText(title .. "：" .. desc)
        else
            local str = ConfigHelper.GetLocalString(5175)
            attrItem.txt_desc:SetText(title .. "：" .. str)
            attrItem.txt_desc.gameObject:onClick(function(go)
                self:_ShowUnlockTip(openCondition)
            end)
        end
    end
end

function M:_InitArea3()
    self._view.txt_chTitle3:SetText(self._data.bookTitle3[1])
    local count = #self._data.bookDesc3
    local parent = self._view.txt_desc3.transform.parent
    parent:HideChildren()
    for i = 1, count, 1 do
        local go
        if i <= parent.childCount then
            go = parent:GetChild(i - 1)
        else
            go = self._view.txt_desc3.gameObject:Instantiate()
        end
        go:SetActive(true)
        local openCondition3 = self._data.openCondition3[i]
        go.transform:Find("line"):SetActive(i ~= count)

        local typeText = typeof(CS.UnityEngine.UI.Text)
        if GameHelper.CheckLockByOpenConditionId(openCondition3) then
            go:GetComponent(typeText):SetText(self._data.bookDesc3[i])
        else
            go:GetComponent(typeText):SetText(5175)
            go:onClick(function(go)
                self:_ShowUnlockTip(openCondition3)
            end)
        end
    end
end

function M:_InitArea4()
    self._view.txt_chTitle4:SetText(self._data.bookTitle4[1])
    local count = #self._data.bookDesc4
    local parent = self._view.txt_desc4.transform.parent
    parent:HideChildren()
    for i = 1, count, 1 do
        local go
        if i <= parent.childCount then
            go = parent:GetChild(i - 1)
        else
            go = self._view.txt_desc4.gameObject:Instantiate()
        end
        go:SetActive(true)
        local openCondition4 = self._data.openCondition4[i]
        go.transform:Find("line"):SetActive(i ~= count)

        local typeText = typeof(CS.UnityEngine.UI.Text)
        if GameHelper.CheckLockByOpenConditionId(openCondition4) then
            go:GetComponent(typeText):SetText(self._data.bookDesc4[i])
        else
            go:GetComponent(typeText):SetText(5175)
            go:onClick(function(go)
                self:_ShowUnlockTip(openCondition4)
            end)
        end
    end
end

function M:_InitArea5()
    local descs, text = self._data.bookDesc5, self._view.txt_desc5
    self._view.txt_chTitle5:SetText(self._data.bookTitle5[1])
    local parent, count = text.transform.parent, #descs
    parent:HideChildren()
    for i = 1, count, 1 do
        local go
        if i <= parent.childCount then
            go = parent:GetChild(i - 1)
        else
            go = text.gameObject:Instantiate()
        end
        go:SetActive(true)
        local openCondition5 = self._data.openCondition5[i]
        go.transform:Find("line"):SetActive(i ~= count)

        local typeText = typeof(CS.UnityEngine.UI.Text)
        if GameHelper.CheckLockByOpenConditionId(openCondition5) then
            local str = ConfigHelper.GetLocalStringByPlayerName(descs[i])
            go:GetComponent(typeText):SetText(str)
        else
            go:GetComponent(typeText):SetText(5175)
            go:onClick(function(go)
                self:_ShowUnlockTip(openCondition5)
            end)
        end
    end
end

return PlotAtlasDrawItemCtrl
