module('lib.component.DropDown', Class.impl("lib.component.BaseContainer"))

function ctor(self)
    --所有item对象
    self.listItem = {}
    --当前item数量
    self.itemCount = 0
    --当前选项数据
    self.listStrOptions = {}
    --当前选中索引
    self.curSelectIdx = nil
    --选中回调
    self.optionClickCallBack = nil
end

function destroy(self)
    self:removeOnClick(self.mBtnDropDown)
    self:setUiRef(nil)
    self:clearOptions()
    self:recoverClickMaskObj()
end

function setUiRef(self, refs)
    --Unity 引用
    self.mBtnDropDown = refs and refs.goDropDown or nil
    self.mTxtDropDown = refs and refs.txtDropDown or nil
    self.mTfDownArrow = refs and refs.tfDownArrow or nil
    self.mGoScroll = refs and refs.goScroll or nil
    self.mTfContent = refs and refs.tfContent or nil
    self.mGoItem = refs and refs.goItem or nil
    ---item控件名字
    --一般状态下文本对象名
    self.normalTxtObjName = refs and refs.normalTxtObjName or "mTxtNormal"
    --选中状态下文本对象名
    self.selectTxtObjName = refs and refs.selectTxtObjName or "mTxtSelect"
    --控制选中状态对象名
    self.selectImgObjName = refs and refs.selectImgObjName or "mImgSelect"

    if self.mGoItem then
        self.mGoItem:SetActive(false)
    end
    if self.mGoScroll then
        self.mGoScroll:SetActive(false)
    end
    if self.mBtnDropDown then
        self:addOnClick(self.mBtnDropDown, self.onClickBtnDropDownHandler)
    end
end

--设置点击选中回调 回调会传入选中索引（从1开始）
function setOptionClickCallBack(self, optionClickCallBack)
    self.optionClickCallBack = optionClickCallBack or nil
end

function resetOptions(self, strOptions, curSelectIdx)
    self:clearOptions()
    for _, v in ipairs(strOptions) do
        self:addOption(v)
    end
    self:showItemList(false)
	if curSelectIdx then
        self:setOptionSelect(curSelectIdx, true)
	end
end

--添加单个下拉label
function addOption(self, str)
    local item = SimpleInsItem:create(self.mGoItem, self.mTfContent, "DropDownItem")
    item:getChildGO(self.normalTxtObjName):GetComponent(ty.Text).text = str
    item:getChildGO(self.selectTxtObjName):GetComponent(ty.Text).text = str
    item:getChildGO(self.selectImgObjName):SetActive(false)

    local index = self.itemCount + 1
    item:addUIEvent(nil, function()
        self:setOptionSelect(index, true)
        self:showItemList(false)
    end)

    self.itemCount = index
    self.listItem[index] = item
    self.listStrOptions[index] = str
end

function clearOptions(self)
    self.curSelectIdx = nil
    for _, item in ipairs(self.listItem) do
        item:poolRecover()
    end
    self.listItem = {}
    self.listStrOptions = {}
    self.itemCount = 0
    self.curSelectIdx = nil
end

function setOptionSelect(self, selectIdx, isTriggerOptionClickCallBack)
    if not isTriggerOptionClickCallBack and self.curSelectIdx == selectIdx then
        return
    end
    self.curSelectIdx = selectIdx
    self:updateItemSelectState()
    if isTriggerOptionClickCallBack then
        if self.optionClickCallBack then
            self.optionClickCallBack(self.curSelectIdx)
        end
    end
end

function showItemList(self, isActive)
    if not self.mClickMaskObj then
        self:createClickMaskObj()
    end
    self.mGoScroll:SetActive(isActive)
    self.mClickMaskObj:SetActive(isActive)
    if self.mTfDownArrow then
        gs.TransQuick:SetRotation(self.mTfDownArrow, 0, 0, isActive and 180 or 0)
    end
end

function updateItemSelectState(self)
    for idx, item in ipairs(self.listItem) do
        item:getChildGO(self.selectImgObjName):SetActive(idx == self.curSelectIdx)
    end
    if self.curSelectIdx then
        self.mTxtDropDown.text = self.listStrOptions[self.curSelectIdx]
    end
end

function recoverClickMaskObj(self)
    if self.mClickMaskObj then
        self:removeOnClick(self.mClickMaskObj)
        gs.GameObject.Destroy(self.mClickMaskObj)
        self.mClickMaskObj = nil
		self.mClickMaskTf = nil
    end
end

function createClickMaskObj(self)
    local UIRes = UrlManager:getUIPrefabPath("button/mBtnEmptyFullScreen.prefab")
    AssetLoader.PreLoad(UIRes)
    self.mClickMaskObj = AssetLoader.GetGO(UIRes)
	self.mClickMaskTf = self.mClickMaskObj.transform
    gs.TransQuick:SetParentOrg(self.mClickMaskTf, self.mBtnDropDown.transform)
    self.mClickMaskTf:SetAsFirstSibling()
    self:addOnClick(self.mClickMaskObj, self.onClickClickMaskObjHandler)
end

function onClickBtnDropDownHandler(self)
    self:showItemList(true)
end

function onClickClickMaskObjHandler(self)
    self:showItemList(false)
end

return _M
