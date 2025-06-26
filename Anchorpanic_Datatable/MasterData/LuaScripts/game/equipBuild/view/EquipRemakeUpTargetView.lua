module('game.equipBuild.view.EquipRemakeUpTargetView', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipRemakeUpTargetView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
blurTweenTime = 0 -- 模糊背景的渐变时间（仅2弹窗面板有效，默认不渐变，单位秒）
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(nil, nil)
    self:setTxtTitle('')
end

-- 初始化数据
function initData(self)

end

function configUI(self)
    super.configUI(self)
    self.mAttrContent = self:getChildTrans("mAttrContent")
    self.mAttrItem = self:getChildGO("mAttrItem")
    self.mColorContent = self:getChildTrans("mColorContent")
    self.mColorItem = self:getChildGO("mColorItem")

    self.BtnConfirm = self:getChildGO("BtnConfirm")

    self.mTxtRemakeSelectCount = self:getChildGO("mTxtRemakeSelectCount"):GetComponent(ty.Text)
    self.mTxtRemakeSelectColorCount = self:getChildGO("mTxtRemakeSelectColorCount"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.mEquipVo = args.equipVo
    self.openPos = args.pos
    self:showPanel()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:clearColorItemList()
    self:clearItemList()

end

function initViewText(self)
    self:getChildGO("mTxtRemake"):GetComponent(ty.Text).text = _TT(71463)
    self:getChildGO("mTxtRemakeSelect"):GetComponent(ty.Text).text = _TT(71464)
    self:getChildGO("mTxtRemakeSelectColor"):GetComponent(ty.Text).text = _TT(71465)
    self:getChildGO("mTxtConfirm"):GetComponent(ty.Text).text = _TT(71466)
end

function addAllUIEvent(self)
    self:addUIEvent(self.BtnConfirm, self.onBtnConfirm)
end

function onBtnConfirm(self)
    if #self.clickIdList == 0 then
        gs.Message.Show(_TT(71470))
        return
    end

    if #self.clickChildIdList == 0 then
        gs.Message.Show(_TT(71471))
        return
    end
    --self.maxColor



    equipBuild.EquipRemakeManager:setNeedRemakeAgentInfo(self.mEquipVo, self.openPos, self.clickIdList, self.clickChildIdList)
    self:close()
    GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_REMAKE_UP_AGENT_VIEW, {
        pos = self.openPos,
        equipVo = self.mEquipVo
    })
end

function showPanel(self)
    self:clearItemList()
    -- self.clickId = 11

   

    self.maxAttr = sysParam.SysParamManager:getValue(SysParamType.REMAAKE_MAX_SELECT_TYPE1)
    self.maxColor = sysParam.SysParamManager:getValue(SysParamType.REMAAKE_MAX_SELECT_TYPE2)

    self.mTxtRemakeSelectColorCount.text = _TT(25139, 1, self.maxColor)
    self.mTxtRemakeSelectCount.text = _TT(25139, 1, self.maxAttr)


    self.clickIdList = {11}
    local remakePosAttrList, remakePosAttrDic = self.mEquipVo:getRemakeAttr()

    local remId = 0
    if #remakePosAttrList == 2 then
        for k, v in pairs(remakePosAttrDic) do
            if v.remakePos ~= self.openPos then
                remId = v.key
            end
        end
    end

    -- openPos
    local remDic = equipBuild.EquipRemakeManager:getRemakeAttrData()
    for id, vo in pairs(remDic) do
        if self.first == nil and id ~= remId then
            -- self.clickId = id
            self.clickIdList = {id}
            self.first = true
        end
        local item = SimpleInsItem:create(self.mAttrItem, self.mAttrContent, "equipRemItem")
        item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = fight.AttrManager:getAttName(id)
        item:getChildGO("mImgSelect"):SetActive(false)
        item:getChildGO("mImgNot"):SetActive(id == remId)
        item:getChildGO("mTxtAttr"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("82898cff")

        item:addUIEvent("mBtnClick", function()
            if id == remId then
            --     -- gs.Message.Show(_TT(71467))
                return
            end
            if table.indexof01(self.clickIdList, id) > 0 then
                table.removebyvalue(self.clickIdList, id)
            else
                if #self.clickIdList +1 > self.maxAttr then
                    gs.Message.Show(_TT(71469,self.maxAttr))
                    return
                end
                table.insert(self.clickIdList, id)
            end
            -- self.clickId = id
            self:clickRemIdCall()
        end)
        self.mRemDic[id] = item
    end
    self:clickRemIdCall()

    self:updateColorInfo()
end

function clickRemIdCall(self)
    for k, v in pairs(self.mRemDic) do
        local isSelect = table.indexof01(self.clickIdList, k) > 0
        v:getChildGO("mImgSelect"):SetActive(isSelect)
        v:getChildGO("mTxtAttr"):GetComponent(ty.Text).color =
            isSelect and gs.ColorUtil.GetColor("ffffffff") or gs.ColorUtil.GetColor("82898cff")
    end

    self.mTxtRemakeSelectCount.text = _TT(25139, #self.clickIdList, self.maxAttr)
    -- self:updateColorInfo()
end

function updateColorInfo(self)
    self.clickChildIdList = {4}
    -- local remDic = equipBuild.EquipRemakeManager:getRemakeAttrData()
    -- local colorVo = {}
    -- for k, v in pairs(remDic) do
    --     if k == self.clickId then
    --         colorVo = v
    --     end
    -- end
    self:clearColorItemList()
    --local showPercent = fight.AttrManager:isPercentAttr(self.clickId)
    for i = 1, 4  do
        local item = SimpleInsItem:create(self.mColorItem, self.mColorContent, "equipColorItem")
        local isSelect = table.indexof01(self.clickChildIdList, i) > 0
        item:getChildGO("mImgSelect"):SetActive(isSelect)

        --local showValue = showPercent and AttConst.getValueStr(self.clickId, colorVo.attr[i]) or colorVo.attr[i]
        item:getChildGO("mTxtColor"):GetComponent(ty.Text).color = isSelect and
                                                                       gs.ColorUtil.GetColor(self:getColorHtmlString(i)) or
                                                                       gs.ColorUtil.GetColor("82898cff")
        item:getChildGO("mTxtColor"):GetComponent(ty.Text).text = self:getColorString(i) --.. "(" .. showValue .. ")"
        item:addUIEvent("mBtnClick", function()
            local has = table.indexof01(self.clickChildIdList, i) > 0
            if has then
                table.removebyvalue(self.clickChildIdList, i)
            else
                if #self.clickChildIdList +1 > self.maxColor then
                    gs.Message.Show(_TT(71472,self.maxColor))
                    return
                end
                table.insert(self.clickChildIdList, i)
            end
            --self.clickChildId = i
            self:clickColorCall()
        end)

        table.insert(self.mColorList, item)
    end
end

function getColorString(self, id)
    if id == 1 then
        return "B"
    elseif id == 2 then
        return "A"
    elseif id == 3 then
        return "S"
    elseif id == 4 then
        return "S+"
    end
end

function getColorHtmlString(self, color)
    local c = "ffffffff"
    if color == 1 then
        c = "45cea2ff"
    elseif color == 2 then
        c = "2e95ffff"
    elseif color == 3 then
        c = "ff72f1ff"
    elseif color == 4 then
        c = "ffb645ff"
    end
    return c
end

function clickColorCall(self)
    for i = 1, #self.mColorList do
        local isSelect = table.indexof01(self.clickChildIdList, i) > 0
        self.mColorList[i]:getChildGO("mImgSelect"):SetActive(isSelect)
        self.mColorList[i]:getChildGO("mTxtColor"):GetComponent(ty.Text).color = isSelect and
                                                                                     gs.ColorUtil
                                                                                         .GetColor(
                self:getColorHtmlString(i)) or gs.ColorUtil.GetColor("82898cff")
    end

    self.mTxtRemakeSelectColorCount.text = _TT(25139, #self.clickChildIdList, self.maxColor)
end

function clearItemList(self)
    if self.mRemDic then
        for i = 1, #self.mRemDic, 1 do
            self.mRemDic[i]:poolRecover()
        end
    end

    self.mRemDic = {}
end

function clearColorItemList(self)
    if self.mColorList then
        for i = 1, #self.mColorList do
            self.mColorList[i]:poolRecover()
        end
    end
    self.mColorList = {}
end

return _M
