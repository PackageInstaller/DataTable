--[[ 
-----------------------------------------------------
@filename       : NoteConfigVo
@Description    : 便签数据配置vo
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("note.NoteConfigVo", Class.impl())

function parseConfigData(self, index, cusData)
    self.index = index
    -- 便签分类
    self.type = cusData.type_id
    -- 对应功能开启id
    self.funcId = cusData.func_id ~= 0 and cusData.func_id or nil
    -- 对应界面uicode
    self.uiCode = cusData.ui_code ~= 0 and cusData.ui_code or nil
    -- 标题
    self.title = cusData.title
    -- 描述
    self.des = cusData.des
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
