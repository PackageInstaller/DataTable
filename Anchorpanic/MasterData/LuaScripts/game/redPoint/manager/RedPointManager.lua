module("RedPointManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()

    if (not web.WebManager:isReleaseApp()) then
        if (not self.m_cdTimeFrameSn) then
            self.mTimeFrameSn = LoopManager:addTimer(1, 0, self,
            function()
                if (self.m_dic) then
                    for parentInstanceId, data in pairs(self.m_dic) do
                        if (gs.GoUtil.IsGoNull(data.go) or gs.GoUtil.IsCompNull(data.rect) or gs.GoUtil.IsCompNull(data.img)) then
                            -- Debug:log_warn("RedPointManager", "定时检测到" .. data.name .. "红点失去引用，请检查是否漏移除红点")
                        end
                    end
                end
            end)
        end
    end
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)

    self:clearAll()
end

function __initData(self)
    self.m_redPointPrefab = UrlManager:getUIPrefabPath("compent/RedPoint.prefab")
    self.m_dic = {}
end

function add(self, parentTrans, source, x, y, num, showType, moduleType, isMaskAlphaed)
    if (parentTrans and not gs.GoUtil.IsGoNull(parentTrans.gameObject)) then
        local go = nil
        local rect = nil
        local img = nil
        local imgMaskAlphaed = nil
        -- local name = parentTrans.name
        -- if (not web.WebManager:isReleaseApp()) then
        --     local searchParentTrans = parentTrans.parent
        --     while (searchParentTrans and not gs.GoUtil.IsTransNull(searchParentTrans)) do
        --         name = name .. "->" .. searchParentTrans.name
        --         searchParentTrans = searchParentTrans.parent
        --     end
        -- end
        local parentInstanceId = parentTrans:GetInstanceID()
        local data = self.m_dic[parentInstanceId]
        -- 此处可能某些模块忘了移除红点，界面又被销毁也一并销毁了红点，做下安全处理
        if (data and (gs.GoUtil.IsGoNull(data.go) or gs.GoUtil.IsCompNull(data.rect) or gs.GoUtil.IsCompNull(data.img))) then
            data = nil
        end
        if (data) then
            go = data.go
            rect = data.rect
            img = data.img
            imgMaskAlphaed = data.imgMaskAlphaed

            go.transform:SetParent(parentTrans, false)
            gs.TransQuick:UIPos(rect, x, y)
            img.gameObject:SetActive(not isMaskAlphaed)
            imgMaskAlphaed.gameObject:SetActive(isMaskAlphaed)
            if (isMaskAlphaed) then
                imgMaskAlphaed:SetImg(source or UrlManager:getCommon5Path("common_0013.png"), true)
            else
                img:SetImg(source or UrlManager:getCommon5Path("common_0013.png"), true)
            end
        else
            local redGo = gs.GOPoolMgr:Get(self.m_redPointPrefab)
            if (parentTrans and not gs.GoUtil.IsTransNull(parentTrans)) then
                go = redGo
                rect = go:GetComponent(ty.RectTransform)
                img = go.transform:Find("mImg"):GetComponent(ty.AutoRefImage)
                imgMaskAlphaed = go.transform:Find("mImgMaskAlphaed"):GetComponent(ty.AutoRefImage)

                go.transform:SetParent(parentTrans, false)
                gs.TransQuick:UIPos(rect, x, y)
                img.gameObject:SetActive(not isMaskAlphaed)
                imgMaskAlphaed.gameObject:SetActive(isMaskAlphaed)
                if (isMaskAlphaed) then
                    imgMaskAlphaed:SetImg(source or UrlManager:getCommon5Path("common_0013.png"), true)
                else
                    img:SetImg(source or UrlManager:getCommon5Path("common_0013.png"), true)
                end

                self.m_dic[parentInstanceId] = { go = go, rect = rect, img = img, imgMaskAlphaed = imgMaskAlphaed, name = name }
            else
                gs.GOPoolMgr:Recover(redGo, self.m_redPointPrefab)
            end
        end
    end
end

function remove(self, parentTrans)
    local parentInstanceId = parentTrans:GetInstanceID()
    local data = self.m_dic[parentInstanceId]
    if (data) then
        if (data.go and not gs.GoUtil.IsGoNull(data.go)) then
            gs.GOPoolMgr:Recover(data.go, self.m_redPointPrefab)
        end
        self.m_dic[parentInstanceId] = nil
    end
end

function clearAll(self)
    if self.m_dic then
        for k, v in pairs(self.m_dic) do
            if (v.go and not gs.GoUtil.IsGoNull(v.go)) then
                gs.GameObject.Destroy(v.go)
            end
        end
    end
    self.m_dic = {}
end

-- 特效暂时不用
-- function add(self, parentTrans, effectName, localPosX, localPosY, callFun)
--     if parentTrans then
--         self:remove(parentTrans)
--     end
--     local effectData = { effectSn = nil, effectName = nil, effectGo = nil }
--     local parentHashCode = parentTrans:GetHashCode()
--     local function _loadAysnCall(effectGo)
--         if (effectGo) then
--             local effectTrans = effectGo.transform
--             effectData.effectGo = effectGo
--             effectData.effectGo:SetActive(true)
--             gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
--             if (localPosX and localPosY) then
--                 gs.TransQuick:LPosXY(effectTrans, localPosX, localPosY)
--             end

-- 这里不用了
-- -- local rootCanvas = effectGo:GetComponentInParent(ty.Canvas)
-- -- local order = rootCanvas.sortingOrder + 1

-- -- local renderArray = gs.GoUtil.GetRendererComsInChildren(effectGo)
-- -- local len = renderArray.Length - 1
-- -- for i = 0, len do
-- --     local render = renderArray[i]
-- --     render.sortingOrder = render.sortingOrder + order
-- -- end

--             if (callFun) then
--                 callFun(true, effectData.effectGo)
--             end
--         else
--             if (parentTrans) then
--                 self:remove(parentTrans)
--             end
--             if (callFun) then
--                 callFun(false, nil)
--             end
--         end
--     end
--     effectData.effectName = effectName or "fx_ui_common_hongidian"
--     effectData.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)), _loadAysnCall)
--     self.m_dic[parentHashCode] = effectData
-- end

-- function remove(self, parentTrans)
--     local parentHashCode = parentTrans:GetHashCode()
--     local effectData = self.m_dic[parentHashCode]

--     if effectData then
--         gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
--         if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
--             effectData.effectGo:SetActive(false)
--             gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)))
--         end
--         self.m_dic[parentHashCode] = nil
--     end
-- end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]