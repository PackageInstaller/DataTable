GameUtil = {}

local function CheckInTime(fromTime, endTime)
    if endTime == 0 then
        return true
    end
    return TimeUtil.CheckNowInTime(fromTime, endTime)
end

local function DestroyGo(go)
    if not IsNull(go) then
        CS.UnityEngine.GameObject.Destroy(go)
    end
end

local function DestroyImmediate(go)
    if not IsNull(go) then
        CS.UnityEngine.GameObject.DestroyImmediate(go)
    end
end

local function Instantiate(go,parent)
    if not IsNull(go) then
        if parent == nil then 
            parent = go.parent
        end
        local g = CS.UnityEngine.GameObject.Instantiate(go)
        g.transform:SetParent(parent)
        g.transform.localScale = go.transform.localScale
        g.transform.localPosition = go.transform.localPosition
        g:SetActive(true)
        return g
    end
end

local function InstantiateComponent(com,parent)
    if IsNull(com) then 
        return 
    end
    if parent == nil then 
        parent = com.gameObject.parent
    end
    local g = CS.UnityEngine.Object.Instantiate(com)
    g.transform:SetParent(parent)
    g.transform.localScale = com.transform.localScale
    g.transform.localPosition = com.transform.localPosition
    g.gameObject:SetActive(true)
    return g    
end

local function GetCurTimeTick()
    return TimeUtil.GetNowTimeStamp()
end

local function TryParseHtmlString(htmlString)
    local color
    CS.UnityEngine.ColorUtility:TryParseHtmlString(htmlString, color)
    return color
end

GameUtil.GetCurTimeTick = GetCurTimeTick
GameUtil.CheckInTime = CheckInTime
GameUtil.Instantiate = Instantiate
GameUtil.DestroyGo = DestroyGo
GameUtil.DestroyImmediate = DestroyImmediate
GameUtil.TryParseHtmlString = TryParseHtmlString
GameUtil.InstantiateComponent = InstantiateComponent
