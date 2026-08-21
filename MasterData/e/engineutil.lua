Instantiate = UnityEngine.Object.Instantiate
---@type UnityEngine.GameObject
GameObject = UnityEngine.GameObject
Transform = UnityEngine.Transform
Input = UnityEngine.Input
Application = UnityEngine.Application
PointerEventData = UnityEngine.EventSystems.PointerEventData
EventSystem = UnityEngine.EventSystems.EventSystem
LuaMgr = LuaMgr.Instance
RectTransformUtility = UnityEngine.RectTransformUtility
KeyCode = UnityEngine.KeyCode
DOVirtual = DG.Tweening.DOVirtual
---@type DG.Tweening.DOTween
DOTween = DG.Tweening.DOTween
PlayerPrefs = UnityEngine.PlayerPrefs
Physics2D = UnityEngine.Physics2D
RichText = MyRichText.RichText
RichItemText = MyRichText.RichItemText
RuntimePlatform = UnityEngine.RuntimePlatform
Random = UnityEngine.Random

--Time = UnityEngine.Time
EngineUtil = {}

function EngineUtil.IsWebGL()
    return EngineGlobal.GetPlatformName() == "WebGL"
end

function EngineUtil.GetWebGLPlatform()
    if EngineUtil.IsWebGL() then
        if EngineGlobal.GetWebPlatform then
            return EngineGlobal.GetWebPlatform()
        else
            return GE.WebGLMiniPlatform.WxWebMini
        end
    end
    return "unkown"
end

if EngineUtil.IsWebGL() then
    if EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.WxWebMini then
        PlayerPrefs = WX.PlayerPrefs
    elseif EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.AliWebMini then
        PlayerPrefs = UnityEngine.PlayerPrefs
    elseif EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.TikTokMini then
        PlayerPrefs = TT.PlayerPrefs
    end
else
    PlayerPrefs = UnityEngine.PlayerPrefs
end
Physics2D = UnityEngine.Physics2D
RichText = MyRichText.RichText
RichItemText = MyRichText.RichItemText
function NewGameObject(name, parent)
    local go = GameObject.New(name)
    local trans = go.transform
    if parent then
        trans.parent = parent.transform
    end

    trans.localPosition = Vector3.zero
    trans.localRotation = Quaternion.identity
    trans.localScale = Vector3.one

    return go
end

function EngineUtil.FillPeer(template, inst, peerBase)
	local peer = tolua.getpeer(template)
	if not peer then
		return
	end

	local instPeer = tolua.getpeer(inst)
	if not instPeer then
		instPeer = peerBase or {}
		tolua.setpeer(inst, instPeer)
	else
		return
	end

	for k,v in pairs(peer) do
		if k ~= "base" then
			if type(v) == "table" then
				if iskindof(v, "LuaMonoBehavior") == true then
					local comp = inst:GetComponentLua(v.__cname)
					if not comp then
						LuaLogger.e("Instance %s doesn't have component %s as %s in template %s", inst.name, type:ToString(), v.name, template.name)
					else
						-- print("find comp ", inst.name, tostring(comp:GetType()), k)
						instPeer[k] = comp
					end
				end
			else
				local type = v:GetType()
				if type == TypeInfo.GameObject then
					local child = inst.transform:FindInChild(k)
	                if not child then
	                    local toLow = string.upper(string.sub(k,1,1)) .. string.sub(k,2,#k)
	                    child = inst.transform:FindInChild(toLow)
	                end

					if not child then
						LuaLogger.e("Instance %s doesn't have node %s as %s in template %s", inst.name, k, v.name, template.name)
					else
						instPeer[k] = child.gameObject 
						EngineUtil.FillPeer(v, child.gameObject)
					end
				else
					-- IsSubclassOf Component
					local comp = inst:GetComponent(type)
					if not comp then
						LuaLogger.e("Instance %s doesn't have component %s as %s in template %s", inst.name, type:ToString(), v.name, template.name)
					else
						-- print("find comp ", inst.name, tostring(comp:GetType()), k)
						instPeer[k] = comp
					end
				end
			end
			
		end
	end
end
---@param child UnityEngine.GameObject
local function ReleaseFillTemplateChild(child)
	if IsNull(child) then
		return
	end

	if child.activeSelf then
		child:SetActive(false)
	end

	PoolMgr.Free(child)
	if not IsNull(child) then
		GameObject.Destroy(child)
	end
end

---@generic obj:UnityEngine.GameObject
---@param mono LuaMonoBehavior luaMono对象
---@param template obj 模板对象
---@param root UnityEngine.GameObject 父节点
---@param num number 创建数量
---@param func fun(index:integer, Obj:obj) 回调函数  unit 创建的对象 index索引
---@param completeFun fun()? 完成回调函数
function EngineUtil.FillTemplateContent(mono, template, root, num, func, completeFun)
	template:SetActive(false)
	-- 每次填充都递增批次，取消前一次未完成的异步创建（含缩容、重复刷新场景）
	mono:IncrementalContentAsynBatchesId(root)
	local batchesId = mono:GetContentAsynBatchesId(root)
	local existList = {}
	local childCount = root.transform.childCount
	for i = 0, childCount - 1 do
		local child = root.transform:GetChild(i).gameObject
		if child ~= template then
			existList[#existList + 1] = child
		end
	end

	local actived = 0
	for idx = 1, #existList do
		local child = existList[idx]
		if IsNull(child) then
			-- 可能被上一轮延迟 Destroy，跳过
		elseif actived < num then
			child:SetActive(true)
			actived = actived + 1
			EngineUtil.FillPeer(template, child)
			func(actived, child)
		else
			ReleaseFillTemplateChild(child)
		end
	end

	if num > actived then
        -- 异步创建
        local createNum = num - actived
        local loadCount = 0
        PoolMgr.InstantiateAsync(mono.gameObject, template, function(newObj, index)
            if not UICommonUtils.Checkobj(template) or not UICommonUtils.Checkobj(newObj) then
                return
            end

            local currBatchesId = mono:GetContentAsynBatchesId(root)
            if currBatchesId ~= batchesId then
                ReleaseFillTemplateChild(newObj)
                return
            end
            EngineUtil.FillPeer(template, newObj)
            newObj.transform:SetParent(root.transform, false)
            newObj:SetActive(true)
            func(actived + index + 1, newObj)

            loadCount = loadCount + 1
            if loadCount >= createNum then
                if completeFun ~= nil then
                    completeFun()
                end
            end
        end, createNum)

        -- 同步
        -- for i = 1, num - actived do
        --     local temp = mono:SpawnTemplate(template, false)
        --     EngineUtil.FillPeer(template, temp)
        --     temp.transform:SetParent(root.transform, false)
        --     func(actived + i, temp)
        -- end
    else
        if completeFun ~= nil then
            completeFun()
        end
	end
end

---@param template UnityEngine.GameObject 模板对象
---@param root UTableView 父节点
---@param num number 创建数量
---@param func function func(unit, index): 回调函数  unit 创建的对象 index索引
---@param frameFlushNum number 每贞延迟创建的数量
---@param frameDelayTime number 延迟创建间隔时间
function EngineUtil.FillTableTemplateContent(template, root, num, func, frameFlushNum, frameDelayTime, wnd, needOpenDeal)
    if wnd then
        if wnd.uiConfig ~= nil and wnd.uiConfig.AnimationOpen then
            wnd.isInAnimation = true
        end
    end

    template:SetActive(false)

    local cnt = root.transform.childCount
    local i = 0
    local actived = 0
    if tolua.getpeer(root) == nil then
        tolua.setpeer(root, {})
    end

    local function clearTimer()
--[[        if root.timers ~= nil then
            for ti,__ in pairs(root.timers) do
                DTimer.Instance:RemoveTimer(ti)
                ti.OnComp = nil
            end
        end
        if tolua.getpeer(root) ~= nil then
            root.timers = nil
        end]]
    end

    clearTimer()

    --root.tableT = {}
    --root.tableTcreating = {}
    root.frames = {}
    --root.timers = {}

    local frameFlushCount = frameFlushNum
    if not frameFlushCount then
        frameFlushCount = 1
    end

    if not frameDelayTime then
        frameDelayTime = 0.01
    end

    root.luaFree = function()
        -- body
        root.onUpdateItem  = function()
            -- body
        end
        --root.tableT = {}
        --root.tableTcreating = {}
        clearTimer()
        root:clear()
    end

    root.onUpdateItem = function(item, realIndex, cellSize)
        realIndex = realIndex + 1
        if item then
            --if root.tableTcreating[item:GetInstanceID()] then
            --    root.tableTcreating[item:GetInstanceID()] = realIndex
            --    return item
            --end
            local obj = item.transform:GetChild(0).gameObject

            EngineUtil.FillPeer(template, obj)
            local unit = obj

            unit.gameObject.name = tostring(realIndex)
            func(realIndex, unit)

            if wnd then
                if wnd.uiConfig ~= nil and wnd.uiConfig.AnimationOpen and not wnd.isInAnimation then
                    local graphics = unit.transform:GetComponentsInChildren(TypeInfo.Graphic, true)
                    for i = 1, graphics.Length do
                        graphics[i - 1]:SetAlpha(1)
                    end
                end
            end

            -----触发新手引导
            --ClientData.guideInfo:CheckGuideTrigger()
            return item
        else
            local frame = os.time()
            if root.frames.frame ~= frame then
                root.frames.frame = frame
                root.frames.count = 0
            end
            root.frames.count = root.frames.count + 1
            local temp = GameObject.New("unit")
            temp:AddComponent(TypeInfo.RectTransform)
            temp.transform:SetParent(root.transform, false)
            --root.tableTcreating[temp:GetInstanceID()] = realIndex
            --local time = frameDelayTime*math.ceil(root.frames.count/frameFlushCount)
            --local ti = DTimer.TimerInfo.New()
            --ti.Left = time
            --ti.Interval = 1
            --ti.MaxRepeatNum = 1
            --ti.CombMode = true
            --root.timers[ti] = 1
            --ti.OnComp = function()
                if tolua.getpeer(root) ~= nil then
                    local obj = Instantiate(template)
                    obj.transform:SetParent(temp.transform, false)
                    obj.transform.anchorMax = Vector2.up
                    obj.transform.anchorMin = Vector2.up
                    obj.transform.pivot = Vector2.up
                    obj.transform.anchoredPosition = Vector2.zero
                    obj:SetActive(true)
                    EngineUtil.FillPeer(template, obj)
                    --root.tableT[temp:GetInstanceID()] = obj
                    obj.name = tostring(realIndex)
                    func(realIndex, obj)
                    --root.tableTcreating[temp:GetInstanceID()] = nil
                    --root.timers[ti] = nil

                    if needOpenDeal then
                        if wnd then
                            if wnd.uiConfig ~= nil and wnd.uiConfig.AnimationOpen then
                                local graphics = obj.transform:GetComponentsInChildren(TypeInfo.Graphic, true)
                                for i = 1, graphics.Length do
                                    graphics[i - 1]:SetAlpha(0)
                                end
                            end
                        end
                    else
                        if wnd then
                            if wnd.uiConfig ~= nil and wnd.uiConfig.AnimationOpen and wnd.isInAnimation then
                                local graphics = obj.transform:GetComponentsInChildren(TypeInfo.Graphic, true)
                                for i = 1, graphics.Length do
                                    graphics[i - 1]:SetAlpha(0)
                                end
                            end
                        end
                    end

                    -----触发新手引导
                    --ClientData.guideInfo:CheckGuideTrigger()
                end
            --end
            --DTimer.Instance:StartTimer(ti)
            return temp
        end
    end

    root.getNumberOfCells = function()
        return num
    end
end

function Color:ToHexStr()
	return string.format("%02x%02x%02x%02x", self.r * 255, self.g * 255, self.b * 255, self.a * 255)
end

function Color.NewInt(r, g, b, a)
	return Color.New(r/255, g/255, b/255, a and a/255 or 1)
end

function Color.NewFromStr(str)
	local r = tonumber(str:sub(1, 2), 16)
    local g = tonumber(str:sub(3, 4), 16)
    local b = tonumber(str:sub(5, 6), 16)
    local a = 255

    if str:len() == 8 then
        a = tonumber(str:sub(7, 8), 16)
    end

	return Color.NewInt(r, g, b, a)
end

function EngineUtil.SetSortingOrder( node, index )
	local obj = node.gameObject
	local canvas = obj:GetOrAddComponent(TypeInfo.Canvas)
	obj:GetOrAddComponent(TypeInfo.GraphicRaycaster)
	obj:GetOrAddComponent(TypeInfo.CanvasGroup)
	canvas.overrideSorting = true
	canvas.sortingOrder = index
	canvas.overridePixelPerfect = true
	canvas.pixelPerfect = false

    --抽卡界面临时处理，之后根据UI整体逻辑再做修改
    if string.find(node.name, "MissionMsgPanel") then
        canvas.sortingLayerName = "UI"
        canvas.sortingOrder = index / 10
    elseif string.find(node.name, "AdapterPanel") then
        canvas.sortingLayerName = "UI"
        canvas.sortingOrder = index / 10
    elseif string.find(node.name, "MsgBox") then
        canvas.sortingLayerName = "UI"
        canvas.sortingOrder = index / 10
    elseif string.find(node.name, "InterludeLoadingPanel") then
        canvas.sortingLayerName = "UI"
        canvas.sortingOrder = index / 10
    end
end

function EngineUtil.DelayCallback(time, callback, data)
	return coroutine.start(
				function()
					coroutine.wait(time)
					callback(data)
				end
				)
end

function EngineUtil.ServerTime()
	local time = EngineGlobal.ServerTime
	return tonumber(tostring(time))
end

function EngineUtil.ServerTime_Seconds()
	return EngineUtil.ServerTime() * 0.001
end

function EngineUtil.ServerTime_Client()
	local time = EngineUtil.ServerTime() * 0.001
    time = math.floor(time)
    time = time + Me:getTimeZone() * 3600
    return time
end

function EngineUtil.ServerTime_DisplayTime()
	local time = EngineUtil.ServerTime() * 0.001
    time = math.floor(time)
    time = time + Me:getTimeZone() * 3600

	time = time + DLuaUtil.GetTimeZone() * 3600
    return time
end


local SECONDS_DAY = 86400

function EngineUtil.IsCrossDay(time1, time2)

    time1 = time1 + Me:getTimeZone() * 3600  --转换成格林威治时间  
    time1 = time1 + Me:getTimeZone() * 3600  --转换成北京时间  

    time2 = time2 + Me:getTimeZone() * 3600  --转换成格林威治时间  
    time2 = time2 + Me:getTimeZone() * 3600  --转换成北京时间 


    local day1 = math.floor(time1 / SECONDS_DAY)
    local day2 = math.floor(time2 / SECONDS_DAY)
    return day1 ~= day2
end



function EngineUtil.RandomValueFromTable(tab)
	local list = {}
	for k, v in pairs(tab) do
		table.insert(list, v)
	end
	local randomIndex = Random.Range(1, #list)
	randomIndex = math.floor(randomIndex + 0.5)
	local val = list[randomIndex]
	return val
end

---复用格子生成
---@param uICircularScrollView UICircularScrollView
---@param obj UnityEngine.GameObject
---@param count number
---@param func function
function EngineUtil.CreatCircularScrollView(uICircularScrollView, obj, count, func) 
    uICircularScrollView:Init(function(cell, index)
        cell:SetActive(true)
        EngineUtil.FillPeer(obj, cell)
        cell.transform.localPosition = Vector3(cell.transform.localPosition.x, cell.transform.localPosition.y, 0);
        func(index, cell)
    end)
    uICircularScrollView:ShowList(count)
end



EngineUtil.GetChild = function (trans, index)
	if trans.childCount <= index then
		return nil
	end
	return trans:GetChild(index)
end

EngineUtil.Instantiate = function(obj, parent)
	if parent == nil then
		parent = obj.transform.parent
	end
	local go = GameObject.Instantiate(obj, parent)
	local t = go.transform
	local gObj = go.gameObject
	gObj.transform.localPosition = Vector3.zero
	t.localRotation = Quaternion.identity
    gObj.transform.localScale = Vector3.one
	return go
end

---@param trans UnityEngine.Transform
---@param childName string
---@return UnityEngine.Transform?
EngineUtil.FindDeepChild = function (trans, childName)
    if IsNull(trans) then
       return nil 
    end
    local childCount = trans.childCount
    if childCount == 0 then
        return nil
    end
    for i = 0, childCount-1 do
        local trs = trans:GetChild(i)
        if trs.name == childName then
           return trs
        end
        trs = EngineUtil.FindDeepChild(trs, childName)
        if trs ~= nil then
           return trs 
        end
    end
    return nil
end



