local TextureUtility = CS.Engine.Lib.TextureUtility
local Rect = CS.UnityEngine.Rect
local KTool = CS.Engine.Lib.KTool

local SaveScreenShot = {}

function SaveScreenShot:GetPath(id)
    local language = CS.Engine.Lib.I18NManager.Instance.CurrentLanguage

    local filePath = ""
    local isEditor = CS.UnityEngine.Application.isEditor
    local dataPath = CS.UnityEngine.Application.dataPath
    local persistentDataPath = CS.UnityEngine.Application.persistentDataPath
    local fileName = string.format("%d.jpg", id)
    if isEditor then
        local ts = string.reverse(dataPath)
        local _, i = string.find(ts, "/")
        local m = string.len(ts) - i + 1
        local dirPath = string.sub(dataPath, 1, m)
        filePath = dirPath.."Product/rolePicture/"..language.."/"..fileName
    else
        filePath = persistentDataPath.."/rolePicture/"..language.."/"..fileName
    end

    return filePath
end

function SaveScreenShot:Save()
    -- local t = import("Game.SaveScreenShot")
    -- t:Shot()
end

function SaveScreenShot:TestShot()
    local path = "UIRoot/UIRootCanvas/IllustratedHandbookMainDialog/Root/Container/RightPanel/ScrollView/Viewport/Content/1"
    path = string.sub(path, 8, string.len(path))
    local uiRoot = CS.Game.Native.Game.Instance.UIRoot
    local rectTransform = uiRoot.transform:Find(path)
    
    local rect = self:CalculateRect(rectTransform)
    print(rect)
    local filePath = self:GetPath(1)
    local imgQuaily = 100
    local shotSize = self:CalculateShotSize(Vector2.New(324, 576), 5)
    TextureUtility.SaveScreenShotAsync(filePath, rect, shotSize, imgQuaily)
end

function SaveScreenShot:Shot()
    local shotted = {}

    local path = "UIRoot/UIRootCanvas/IllustratedHandbookMainDialog/Root/Container/RightPanel/ScrollView/Viewport/Content"
    local uiRoot = CS.Game.Native.Game.Instance.UIRoot
    local parentPath = string.sub(path, 8, string.len(path))
    local parent = uiRoot.transform:Find(parentPath)

    local count = parent.childCount
    for i = 0, count - 1, 1 do
        local child = parent:GetChild(i)

        
        local active = child.gameObject.activeSelf
        if active then
            local lt = GetLuaBehaviour(child.gameObject, 'Game.UI.IllustratedHandbook.IllustratedHandbookCardArchivesGridRoleCell').Env
            local index = lt:GetLuaIndex()
            local roleId = lt:GetCellData().cardVo.roleId
            if self:IsInView(index) then
                local rect = self:CalculateRect(child)
                local filePath = self:GetPath(tostring(roleId))
                local imgQuaily = 100
                local shotSize = self:CalculateShotSize(Vector2.New(197, 346), 5)
                TextureUtility.SaveScreenShotAsync(filePath, rect, shotSize, imgQuaily)
            end
        end
    end
end

function SaveScreenShot:IsInView(index)
    local oneCell = 197 + 13

    local windowL = 0
    local windowR = windowL + oneCell * 7

    local path = "UIRoot/UIRootCanvas/IllustratedHandbookMainDialog/Root/Container/RightPanel/ScrollView/Viewport/Content"
    local uiRoot = CS.Game.Native.Game.Instance.UIRoot
    local parentPath = string.sub(path, 8, string.len(path))
    local parent = uiRoot.transform:Find(parentPath)

    local offset = parent.localPosition.x

    windowL = windowL - offset
    windowR = windowR - offset

    index = index - 1               -- 从0开始算
    index = math.floor(index / 2)   -- 双排
    local cellL = index * oneCell
    local cellR = cellL + oneCell

    if windowL <= cellL and cellR <= windowR then
        return true
    end
    return false
end

function SaveScreenShot:CalculateShotSize(size, scale)
    local parent = CS.Game.Native.Game.Instance.UIRoot.transform:Find("UIRootCanvas")
    local width = parent.sizeDelta.x
    local height = parent.sizeDelta.y

    local xScale = SCREEN_WIDTH / width
    local yScale = SCREEN_HEIGHT / height

    size = Vector2.New(size.x * xScale, size.y * yScale)
    return size * scale
end

function SaveScreenShot:CalculateRect(rectTransform)
    -- // 将本地位置转换为屏幕坐标
    local parent = CS.Game.Native.Game.Instance.UIRoot.transform:Find("UIRootCanvas")
    local corners = CfUtils.GetCornersPosList(rectTransform, parent, CS.Game.Native.URP.URPCameraController.Instance.uiCamera)

    for i = 1, 4, 1 do
        print(corners[i])
    end

    -- // 计算屏幕上的矩形区域
    local min = Vector2.New(math.maxinteger, math.maxinteger)
    local max = Vector2.New(math.mininteger, math.mininteger)

    for i = 1, 4, 1 do
        min = Vector2.Min(min, corners[i])
        max = Vector2.Max(max, corners[i])
    end

    print(min, max)

    local width = parent.sizeDelta.x    -- root canvas的尺寸
    local height = parent.sizeDelta.y

    min = Vector2.New(min.x + width * 0.5, min.y + height * 0.5)
    max = Vector2.New(max.x + width * 0.5, max.y + height * 0.5)

    print(min, max)

    local xScale = SCREEN_WIDTH / width
    local yScale = SCREEN_HEIGHT / height

    print(SCREEN_WIDTH, width, xScale)

    print(SCREEN_HEIGHT, height, yScale)

    min = Vector2.New(min.x * xScale, min.y * yScale)
    max = Vector2.New(max.x * xScale, max.y * yScale)

    print(min, max)

    -- // 构建Rect
    local screenRect = Rect(min, max - min)

    return screenRect
end

return SaveScreenShot