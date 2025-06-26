--[[
-----------------------------------------------------
@filename       : DormitorySettledHeroView
@Description    : 宿舍战员入住选择界面
@date           : 2022-03-08 16:09:43
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.view.DormitoryEditorSaveSuitView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dormitory/DormitoryEditorSaveSuitView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1117, 518)
    self:setTxtTitle(_TT(49716))
end
--析构
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mBtnSure = self:getChildGO("mBtnSure")
    self.mBtnGm = self:getChildGO("mBtnGm")

    self.mInput_Id = self:getChildGO("mInput_Id"):GetComponent(ty.InputField)
    self.mInput_land = self:getChildGO("mInput_land"):GetComponent(ty.InputField)
    self.mInput_icon = self:getChildGO("mInput_icon"):GetComponent(ty.InputField)

end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSure, self.onClickSure)
    self:addUIEvent(self.mBtnGm, self.onClickGm)

end

function onClickGm(self)
    local suit_id = tonumber(self.mInput_Id.text)
    local baseData = RefMgr:getData("dormitory_suit_data", true)
    for suitId, info in pairs(baseData) do
        if suit_id == suitId then
            -- for i=1,#info.furniture_list do
            for index, furnitureVo in pairs(info.furniture_list) do
                GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, {command = string.format("add_item %s 1", furnitureVo.tid)})
            end
        end
    end
end

function onClickSure(self)
    local fileName = "dormitory_suit_data"
    local baseData = RefMgr:getData(fileName, true)

    local suit_id = tonumber(self.mInput_Id.text)
    local land_id = 0
    if string.NullOrEmpty(self.mInput_land.text) then
        if baseData[suit_id] then
            land_id = baseData[suit_id].land_id
        end
    else
        land_id = tonumber(self.mInput_land.text)
    end

    local icon_path = ""
    if string.NullOrEmpty(self.mInput_icon.text) then
        if baseData[suit_id] then
            icon_path = baseData[suit_id].icon_path
        end
    else
        icon_path = self.mInput_icon.text
    end

    ---处理目前宿舍装修保存的数据
    local list = dormitory.DormitoryManager:getFurnitureListByDormitory()
    local furnitur_str = ""
    for i, furnitureVo in pairs(list) do
        furnitur_str = furnitur_str ..string.format("\n            [%s] = {tid = %s, row = %s, col = %s, location = %s, direction = %s},", i, furnitureVo.tid, furnitureVo.row, furnitureVo.col, furnitureVo.location, furnitureVo.dir)
    end

    local write_str = string.format('\n    [%s] = {\n        land_id = %s,\n        icon_path = "%s",\n        furniture_list =\n         {%s\n        },\n    },', suit_id, land_id, icon_path, furnitur_str)

    ---开始写入文件
    local filePath = gs.PathUtil.GetExistFullPath("LuaScripts/ref/zh/" .. fileName.. '.lua')
    if gs.Application.isEditor then
        filePath = string.gsub(gs.Application.dataPath, "Assets", "LuaScripts/ref/zh/") .. fileName .. ".lua"
    end

    local file = io.open(filePath, "r") --读写方式打开文件
    if file then
        file:close()

        local str = ""

        for suitId, info in pairs(baseData) do
            if suitId ~= suit_id then
                local old_str = ""
                for i, furnitureVo in ipairs(info.furniture_list) do
                    old_str = old_str ..string.format("\n            [%s] = {tid = %s, row = %s, col = %s, location = %s, direction = %s},", i, furnitureVo.tid, furnitureVo.row, furnitureVo.col, furnitureVo.location, furnitureVo.direction)
                end

                str = str .. string.format('\n    [%s] = {\n        land_id = %s,\n        icon_path = "%s",\n        furniture_list =\n         {%s\n        },\n    },', suitId, info.land_id, info.icon_path, old_str)
            end
        end

        str = str ..write_str

        self:writeFile(filePath, str)
    else
        logAll("文件不存在，创建文件")

        self:writeFile(filePath, write_str)
    end

    UIFactory:alertOK0("提示", "当前宿舍装修的家具已保存成套装了，lua配置表路径：" .. filePath, function()
        self:close()
    end)
end

function writeFile(self, filePath, write_str)
    local file = io.open(filePath, "w") --创建文件
    file:write("--Q版宿舍套装表 无需xlsx导出。\nlocal dormitory_suit_data = \n{")
    file:write(write_str)
    file:write("\n}")
    file:write("\n\nreturn dormitory_suit_data")
    file:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(49716):"<size=24>选</size>择战员"
]]
