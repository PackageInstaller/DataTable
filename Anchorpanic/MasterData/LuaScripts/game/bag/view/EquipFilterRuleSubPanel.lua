--[[ 
-----------------------------------------------------
@filename       : EquipPlanPanel
@Description    : 模组方案主界面
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.bag.view.EquipFilterRuleSubPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("bag/EquipFilterRuleSubPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(734, 435)
end

-- 取父容器
function getParentTrans(self)
    return super.getParentTrans(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mItemDic = {}

    self.mType = nil
    self.mSelectList = {}
    self.mTempSelectList = {}
end

function configUI(self)
    super.configUI(self)
    
    self.mTxtPanleTitle = self:getChildGO("mTxtPanleTitle"):GetComponent(ty.Text)

    self.mBtnClear = self:getChildGO("mBtnClear")
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
    
    self.mGroupContent = self:getChildTrans("GroupContent")
    self.mItem = self:getChildGO("Item")
end

function initViewText(self)
    self:setBtnLabel(self.mBtnClear, 4240, "清理")
    self:setBtnLabel(self.mBtnConfirm, 1, "确定")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClear, self.onClickResetHandler)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirmHandler)
end

function close(self)
    super.close(self)
end

function onClickClose(self)
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
end

function active(self, args)
    super.active(self, args)
    self.mType = args.type
    self.mSelectList = args.list
    self.mCallFun = args.callFun
    self.mTempSelectList = {}
    for i = 1, #self.mSelectList do
        table.insert(self.mTempSelectList, self.mSelectList[i])
    end
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self:clearItem()
end

function onClickResetHandler(self)
    self.mTempSelectList = {}
    self:updateView()
end

function onClickConfirmHandler(self)
    self:close()
    if(self.mType == 1)then                         --套装
    elseif(self.mType == 2 or self.mType == 3)then  --主属性 --附加属性
        table.sort(self.mTempSelectList, function(attrVo1, attrVo2)
            if attrVo1:getSort() ~= attrVo2:getSort() then
                return attrVo1:getSort() < attrVo2:getSort()
            end
            return false
        end)
    end
    self.mCallFun(self.mTempSelectList)
end

function updateView(self)
    if(self.mType == 1)then     --套装
        self.mTxtPanleTitle.text = _TT(1316) --"套装属性"
        self:updateSuitView()
    elseif(self.mType == 2)then --主属性
        self.mTxtPanleTitle.text = _TT(1331) --"主属性"
        self:updateMainAttrView()
    elseif(self.mType == 3)then --附加属性
        self.mTxtPanleTitle.text = _TT(1423) --"附加属性"
        self:updateSecondaryAttrView()
    end
end

function updateSuitView(self)
    self:clearItem()
    local suitConfigList = equip.EquipSuitManager:getFormatSuitConfigList(nil, nil)
    for i = 1, #suitConfigList do
        local suitConfigVo = suitConfigList[i]
        local item = SimpleInsItem:create(self.mItem, self.mGroupContent, "mEquipFilterRuleSubPanelItem")
        local goIcon = item:getChildGO("mImgIcon")
        local imgIcon = goIcon:GetComponent(ty.AutoRefImage)
        goIcon:SetActive(true)
        imgIcon:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(suitConfigVo.icon), false)
        local suitCount = suitConfigList[i]:getSuitEquipCount(nil, false)
        local rectContent = item:getChildGO("mTxtContent"):GetComponent(ty.RectTransform)
        local txtContent = item:getChildGO("mTxtContent"):GetComponent(ty.Text)
        if(suitCount > 0)then
            txtContent.text = suitConfigVo.name .. "x" .. suitCount
        else
            txtContent.text = suitConfigVo.name
        end
        gs.TransQuick:LPosXY(rectContent, -105, 0)
        item:getChildGO("mImgSelect"):SetActive(table.indexof(self.mTempSelectList, suitConfigVo) ~= false)
        item:addUIEvent(nil, function()
            local index = table.indexof(self.mTempSelectList, suitConfigVo)
            if(index ~= false)then
                table.remove(self.mTempSelectList, index)
            else
                table.insert(self.mTempSelectList, suitConfigVo)
            end
            self:updateSuitView()
        end)
        self.mItemDic[i] = item
    end
end

function updateMainAttrView(self)
    local dicList = fight.AttrManager:getAttListByMainSecondaryTypeMerge()
    local attrList = dicList[AttConst.AttrMainSecondaryType.Main]
    self:__updateAttrCommonView(attrList)
end

function updateSecondaryAttrView(self)
    local dicList = fight.AttrManager:getAttListByMainSecondaryTypeMerge()
    local attrList = dicList[AttConst.AttrMainSecondaryType.Secondary]
    self:__updateAttrCommonView(attrList)
end

function __updateAttrCommonView(self, attrList)
    self:clearItem()
    for i = 1, #attrList do
        local attrVo = attrList[i]
        local item = SimpleInsItem:create(self.mItem, self.mGroupContent, "mEquipFilterRuleSubPanelItem")
        item:getChildGO("mImgIcon"):SetActive(false)
        local rectContent = item:getChildGO("mTxtContent"):GetComponent(ty.RectTransform)
        local txtContent = item:getChildGO("mTxtContent"):GetComponent(ty.Text)
        txtContent.text = AttConst.getName(attrList[i]:getRefID())
        gs.TransQuick:LPosXY(rectContent, -156, 0)
        item:getChildGO("mImgSelect"):SetActive(table.indexof(self.mTempSelectList, attrVo) ~= false)
        item:addUIEvent(nil, function()
            local index = table.indexof(self.mTempSelectList, attrVo)
            if(index ~= false)then
                table.remove(self.mTempSelectList, index)
            else
                table.insert(self.mTempSelectList, attrVo)
            end
            self:__updateAttrCommonView(attrList)
        end)
        self.mItemDic[i] = item
    end
end

function clearItem(self)
    for _, item in pairs(self.mItemDic) do
        item:poolRecover()
    end
    self.mItemDic = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]