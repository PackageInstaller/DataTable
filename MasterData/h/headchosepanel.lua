---@class HeadChosePanel : HeadChosePanel_Generate
---##################### 【HeadChosePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【HeadChosePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local HeadChosePanel = require "HeadChosePanel_Generate"

function HeadChosePanel:InitLogic(data)
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.nowSelectIndex = nil
    self.HeadBoxList = {}
    self.nowSelectId = nil
    self.BoxTime = {}
    self.headList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.changeHeadboxData))
end

--function HeadChosePanel:StartCreating(time)
--
--end

--function HeadChosePanel:StartEnter(time)
--
--end

--function HeadChosePanel:StartRemoving(time)
--
--end

--function HeadChosePanel:StartExit(time)
--
--end

function HeadChosePanel:OnOpen(data, initiative)
    self:SetView()
end

--初始化显示
function HeadChosePanel:SetView()
    local headList = Config.GetAllConfig("HeadportraitTable")
    self.sortedHeadList = {}

    for key, headConfig in pairs(headList) do
        local isHas = Me:getHeadById(headConfig.id)
        headConfig.isHas = isHas ~= nil and 1 or 0
        if headConfig.isOpen == 1 then
            table.insert(self.sortedHeadList, headConfig)
        end
    end

    table.sort(self.sortedHeadList, function(a, b)
        if a.isHas == b.isHas then
            return a.sort < b.sort
        else
            return a.isHas > b.isHas
        end
    end)
    self.HeadBoxList = {}
    self.headList.loopGridView:SetListItemCount(tablex.size(self.sortedHeadList), false)

    local listSize = tablex.size(self.sortedHeadList)
    local loopGridView = self.headList.loopGridView
    for i = 0, listSize - 1 do
        local item = loopGridView:GetShownItemByItemIndex(i)
        if item ~= nil then
            item.transform.localScale = Vector3.New(0.55, 0.55, 1)
            local btn = item.transform:Find("Btn")
            local canvasGroup = btn:GetComponent(TypeInfo.CanvasGroup)
            canvasGroup.alpha = 0
            item.transform:DOKill()
            canvasGroup:DOKill()
            canvasGroup:DOFade(1, 0.15):SetDelay(i * 0.02)
            item.transform:DOScale(0.7, 0.15):SetDelay(i * 0.02)
        end
    end

    for index, headCfg in pairs(self.sortedHeadList) do
        if Me.head == headCfg.id then
            self.nowSelectIndex = index
            self:setShowDetailInfo(headCfg)
            self.nowSelectId = headCfg.id
            if self.HeadBoxList[index] then
                self.HeadBoxList[index].obj.isSelect:SetActive(true)
            end
            break
        end
    end

    --self:SelectBox(self.nowSelectIndex)
end

function HeadChosePanel:changeHeadboxData(gridView, index, row, col)
    local loopListViewItem = gridView:GetShownItemByItemIndex(index)
    if loopListViewItem == nil then
        loopListViewItem = gridView:NewListViewItem("HeadBox")
    end
    local headBox = loopListViewItem.gameObject
    EngineUtil.FillPeer(self.headBox, headBox)

    local needIndex = index + 1
    local HeadConfig = Config.GetHeadportraitInfo(self.sortedHeadList[needIndex].id)
    local resourceFolder = nil
    local isHas = self.sortedHeadList[needIndex].isHas == 1 and true or nil
    headBox.transform.localScale = Vector3.New(0.7, 0.7, 1)

    if tonumber(HeadConfig.folder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(HeadConfig.folder)))
    else
        resourceFolder = HeadConfig.folder
    end
    local scale = 1
    headBox.headIconImg.image.rectTransform.localScale = Vector3.New(scale, scale, 1)
    self:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, HeadConfig.filename), function (s)
        headBox.headIconImg.image.sprite = s
        headBox.headIconImg.canvasGroup.alpha = 1
    end)
    headBox.isSelect:SetActive(self.nowSelectIndex == needIndex)
    headBox.isLock:SetActive(isHas == nil)
    headBox.isEquip:SetActive(Me.head == self.sortedHeadList[needIndex].id)
    headBox.btn.scaleButton.onClick:RemoveAllListeners()
    headBox.btn.scaleButton.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        self:SelectBox(needIndex)
    end)

    local temp = {
        obj = headBox,
        config = HeadConfig,
        index = needIndex,
    }
    self.HeadBoxList[needIndex] = temp

    return loopListViewItem
end

function HeadChosePanel:SelectBox(index)
    if index == self.nowSelectIndex then
        return
    end
    local HeadConfig = {}

    self.HeadBoxList[self.nowSelectIndex].obj.isSelect:SetActive(false)
    self.HeadBoxList[index].obj.isSelect:SetActive(true)
    self.nowSelectIndex = index
    HeadConfig = self.HeadBoxList[index].config
    self.nowSelectId = HeadConfig.id
    self:setShowDetailInfo(HeadConfig)
end

function HeadChosePanel:setShowDetailInfo(HeadConfig)
    local isHas = Me:getHeadById(HeadConfig.id)
    self.okBtn:SetActive(isHas ~= nil)
    local resourceFolder = nil
    if tonumber(HeadConfig.folder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(HeadConfig.folder)))
    else
        resourceFolder = HeadConfig.folder
    end
    local scale = 1
    self.nowHeadBox.headIconImg.image.rectTransform.localScale = Vector3.New(scale, scale, 1)
    self:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, HeadConfig.filename), function (s)
        self.nowHeadBox.headIconImg.image.sprite = s
        self.nowHeadBox.headIconImg.canvasGroup.alpha = 1
    end)
    self.headNameTxt.text.text = HeadConfig.name
    --self.msgTxt.text.text = HeadConfig.desc
    self.getMsgTxt.text.text = HeadConfig.Unlock
end

--function HeadChosePanel:OnClose(initiative)
--
--end

function HeadChosePanel:OnDestroy()
	-- self.super:OnDestroy(self)
    self.super:OnDestroy(self)
end

--function HeadChosePanel:OnRefresh(data)
--
--end

--退出动画
function HeadChosePanel:Out()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

--[[
/Mask onClick  背景遮罩
--]]
function HeadChosePanel:mask_Button_onClick(mask)
    self:Out()
end

--[[
/BoxBg/CloseBtn onClick 关闭按钮
--]]
function HeadChosePanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:play2DSound(self.btnSoundPath)
    self:Out()
end

--[[
/BoxBg/OkBtn onClick 
--]]
function HeadChosePanel:okBtn_ScaleButton_onClick(okBtn)
    self:play2DSound(self.btnSoundPath)
    if self.nowSelectId == nil then
        UICommonUtils.PopToast("当前选中头像不可更换")
        return
    end

    Me:changeHeadReq({HeadId = self.nowSelectId}, function()
        self:Out()
        UICommonUtils.PopToast("更换成功")
    end)
end

--[[
/BoxBg/Scroll View/Viewport/Content/HeadBox onClick 
--]]
function HeadChosePanel:headBox_ScaleButton_onClick(headBox)

end

return HeadChosePanel
