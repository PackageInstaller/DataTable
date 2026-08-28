-------------------------------------------------------------------------------
-- 社团 - 职位表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-25 10:38:37
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ClubJobVo : SettingRefBase @see AutoIds.IdSetting6002
local ClubJobVo = Class('ClubJobVo', SettingRefBase)


function ClubJobVo:__init()
    ---@type integer @ 职位id
    self.jobId = nil
    ---@type string @ 职位名
    self.jobName = nil
    ---@type table<ClubUtils.JobFuncId, boolean> @ 权限id字典
    self.funcMap = nil
    ---@type ClubUtils.JobFuncId[] @ 权限id列表
    self.funcList = nil
    ---@type integer @ 职位人数
    self.jobMember = nil
end


function ClubJobVo:__delete()
    self.jobId     = nil
    self.jobName   = nil
    self.funcMap   = nil
    self.funcList  = nil
    self.jobMember = nil
end


---@param row TableML.TableFileRow
function ClubJobVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.jobId     = parse_number(row, 'id')
    self.jobName   = parse_localizeText(row, 'name')
    self.jobMember = parse_number(row, 'num')
    self.funcList  = parse_numbers(row, 'func', ';')
    self.funcMap   = {}
    for index, funcId in ipairs(self.funcList) do
        self.funcMap[checkInt(funcId)] = true
    end
end


--- 是否拥有某个权限
---@param funcId ClubUtils.JobFuncId
---@return boolean
function ClubJobVo:HaveFunc(funcId)
    return self.funcMap and self.funcMap[checkInt(funcId)] or false
end


return ClubJobVo
