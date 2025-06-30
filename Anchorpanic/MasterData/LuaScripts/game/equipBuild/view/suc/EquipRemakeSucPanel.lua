module("equipBuild.EquipRemakeSucPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/success/EquipRemakeSucPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(828, 333)
    -- self:setTxtTitle(_TT(4360))
end

-- 初始化数据
function initData(self)
    self.mAttrList = {}
end

function configUI(self)
    super.configUI(self)
    self.m_btnCancel = self:getChildGO("BtnCancel")
    self.m_btnReplace = self:getChildGO("BtnReplace")

    self.m_groupFirst = self:getChildGO("FirstGroup")
    self.m_groupNotFirst = self:getChildGO("NotFirstGroup")
    self.m_textOldAttr = self:getChildTrans("TextOldAttr")
    self.m_textCurAttr = self:getChildTrans("TextCurAttr")
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.AutoRefImage)
    self.mTxtScoreOld = self:getChildGO("mTxtScoreOld"):GetComponent(ty.AutoRefImage)
    self.mTxtScoreCur = self:getChildGO("mTxtScoreCur"):GetComponent(ty.AutoRefImage)
    self.BtnSure = self:getChildGO("BtnSure")


    self.mAttrGroup = self:getChildGO("mAttrGroup")
    self.AttrFirstPoint = self:getChildTrans("AttrFirstPoint")
end

-- 设置全屏透明遮罩
function setMask(self)
    if not self.mask then
        self.mask = AssetLoader.GetGO(UrlManager:getPrefabPath('base/MaskLayer.prefab'))
        if not self.UIRootNode then
            self:createUIRootNode()
        end
        self.mask.transform:SetParent(self.UIRootNode, false)
    end
    self:__updateSiblingIndex()
end

function active(self, args)
    super.active(self, args)
    self:setData(args.oldEquipVo, args.curEquipVo, args.remakePos)
    self.m_click = false
end

function deActive(self)
    self.m_click = false
    super.deActive(self)
    self:recoverAttrList()
end

function initViewText(self)
    self:setBtnLabel(self.m_btnCancel, 2, "取消")
    self:setBtnLabel(self.m_btnReplace, 71443, "替换")
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_btnCancel, self.__onCancelHandler)
    self:addUIEvent(self.m_btnReplace, self.__onReplaceHandler)
    self:addUIEvent(self.BtnSure, self.onClickClose)
end

function __onCancelHandler(self)
    if self.m_click then
        return
    end
    self.m_click = true
    self:close()
end

function __onReplaceHandler(self)
    if self.m_click then
        return
    end
    self.m_click = true
    GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_CONFIRM_REMAKE, {})
    self:close()
end

function setData(self, oldEquipVo, curEquipVo, remakePos)
    self.curEquipVo = curEquipVo
    self.remakePos = remakePos

    local remakePosAttrList, remakePosAttrDic = oldEquipVo:getRemakeAttr()
    local isFirst =  remakePosAttrDic[remakePos] == nil and true or false

    self:recoverAttrList()
    self.m_groupFirst:SetActive(isFirst)
    self.m_groupNotFirst:SetActive(not isFirst)
    -- 是否首次
        -- 当前
    if isFirst then
        local remakePosAttrList, remakePosAttrDic = curEquipVo:getRemakeAttr()
        local attrData = remakePosAttrDic[remakePos]
        self:createAttrGroup(self.AttrFirstPoint, attrData, 1)
        local pro = attrData.value / attrData.maxValue
        local score = self:getScoreUrl(attrData.value , attrData.maxValue)
        self.mTxtScore:SetImg(score)
    elseif (not isFirst) then
        -- 上一次
        local remakePosAttrList, remakePosAttrDic = oldEquipVo:getRemakeAttr()
        local oldAttrData = remakePosAttrDic[remakePos]
        self:createAttrGroup(self.m_textOldAttr, oldAttrData, 4, 1)
        local pro = oldAttrData.value / oldAttrData.maxValue
        local scoreOld = self:getScoreUrl( oldAttrData.value , oldAttrData.maxValue)
        self.mTxtScoreOld:SetImg(scoreOld)

        -- 当前
        local remakePosAttrList, remakePosAttrDic = curEquipVo:getRemakeAttr()
        local attrData = remakePosAttrDic[remakePos]
        local type = 1
        if attrData.key == oldAttrData.key then 
            if attrData.value == oldAttrData.value then 
                type = 2 
            elseif attrData.value <= oldAttrData.value then 
                type = 3
            end
        else
            type = 2 
        end
        self:createAttrGroup(self.m_textCurAttr, attrData, type, 1)
        local pro = attrData.value / attrData.maxValue
        local scoreCur = self:getScoreUrl(attrData.value,attrData.maxValue)
        self.mTxtScoreCur:SetImg(scoreCur)
        self.mTxtScore:SetImg(scoreCur)
    end
end

-- type:样式 -- 1.全显且属性值提升 18EC68ff
----------------2.全显且属性类型变化 ffffffff
----------------3.全显且属性值下降 fa3a2bff
----------------4.仅显示属性和值
-- pivotType: 0.左对齐
--------------1.中心
function createAttrGroup(self, parent, attrData, type, pivotType)
    local item = SimpleInsItem:create(self.mAttrGroup, parent, "remakeAttrGroup"..type)
    local key = item:getChildGO("TextFirstAttr"):GetComponent(ty.Text)
    local value = item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
    local image = item:getChildGO("mImgChange"):GetComponent(ty.Image)
    local range = item:getChildGO("mTxtRange"):GetComponent(ty.Text)
    local group = item:getChildGO("mGroup"):GetComponent(ty.RectTransform)
    key.text = AttConst.getName(attrData.key)
    value.text = AttConst.getValueStr(attrData.key, attrData.value)
    range.text = "("..AttConst.getValueStr(attrData.key, attrData.minValue) .. "-"..AttConst.getValueStr(attrData.key, attrData.maxValue)..")"
    value.color = gs.ColorUtil.GetColor("ffffffff")
    range.gameObject:SetActive(true)
    image.gameObject:SetActive(true)
    if pivotType then 
        gs.TransQuick:Pivot(item:getTrans(), 0.5, 0.5)
    else
        gs.TransQuick:Pivot(item:getTrans(), 0, 0.5)
    end
    gs.TransQuick:UIPos(item:getTrans(), 0, 0)
    if type == 1 then 
        value.color = gs.ColorUtil.GetColor("18EC68ff")
        image.color = gs.ColorUtil.GetColor("18EC68ff")
        image:GetComponent(ty.RectTransform).eulerAngles = gs.Vector3.zero
    elseif type == 2 then 
        image.gameObject:SetActive(false)
    elseif type == 3 then 
        value.color = gs.ColorUtil.GetColor("fa3a2bff")
        image.color = gs.ColorUtil.GetColor("fa3a2bff")
        image:GetComponent(ty.RectTransform).eulerAngles = gs.Vector3(180, 0, 0)
    elseif type == 4 then 
        range.gameObject:SetActive(false)
        image.gameObject:SetActive(false)
    end
    LoopManager:addFrame(1, 1, self, function()
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(group)
    end)
    table.insert(self.mAttrList, item)
end

function showConfirmSucc(self)
    self.m_groupFirst:SetActive(true)
    self.m_groupNotFirst:SetActive(false)
end

function showConfirmAgentSucc(self)
    self.m_groupFirst:SetActive(true)
    self.m_groupNotFirst:SetActive(false)

    --local vo,pos,id,color = equipBuild.EquipRemakeManager:getNeedRemakeAgentInfo()
    local remakePosAttrList, remakePosAttrDic = self.curEquipVo:getRemakeAttr()
    local attrData = remakePosAttrDic[self.remakePos]
    self:createAttrGroup(self.AttrFirstPoint, attrData, 1)
    local pro = attrData.value / attrData.maxValue
    local score = self:getScoreUrl(attrData.value , attrData.maxValue)
    self.mTxtScore:SetImg(score)


end

function getScoreUrl(self, value,maxValue)

    local orValue = math.floor(maxValue * (sysParam.SysParamManager:getValue(1913) / 1000) + 0.5)
    local viValue = math.floor(maxValue * (sysParam.SysParamManager:getValue(1912) / 1000) + 0.5)
    local blValue = math.floor(maxValue * (sysParam.SysParamManager:getValue(1911) / 1000) + 0.5)
    local colorType = 0
    if value >= orValue then
        colorType = RemakeType.ORANGE
    elseif value < orValue and value >= viValue then
        colorType = RemakeType.VIOLET
    elseif value < viValue and value >= blValue then
        colorType = RemakeType.BLUE
    else
        colorType = RemakeType.GREEN
    end

    return UrlManager:getPackPath("chip/mozu_icon_0" .. (colorType + 4) .. ".png")

    -- local url = ""
    -- if pro >= sysParam.SysParamManager:getValue(1913) / 1000 then
    --     url = UrlManager:getPackPath("chip/mozu_icon_08.png")
    -- elseif pro < sysParam.SysParamManager:getValue(1913) / 1000 and pro >= sysParam.SysParamManager:getValue(1912) / 1000 then
    --     url = UrlManager:getPackPath("chip/mozu_icon_07.png")
    -- elseif pro < sysParam.SysParamManager:getValue(1912) / 1000 and pro >= sysParam.SysParamManager:getValue(1911) / 1000 then
    --     url = UrlManager:getPackPath("chip/mozu_icon_06.png")
    -- else
    --     url = UrlManager:getPackPath("chip/mozu_icon_05.png")
    -- end

    -- return url
end

function recoverAttrList(self)
    for k,v in pairs(self.mAttrList) do
        v:poolRecover()
    end
    self.mAttrList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71442):	"获得新的改造属性"
	语言包: _TT(71441):	"改造结果"
	语言包: _TT(71401):	"当前属性"
]]
