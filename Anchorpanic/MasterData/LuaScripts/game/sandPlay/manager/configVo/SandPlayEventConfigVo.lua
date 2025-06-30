-- @FileName:   SandPlayEventConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayEventConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.event_id = key
    self.event_type = cusData.type -- 1.对话 2.打开界面 3.特殊玩法类型 4.宝箱 5.战斗事件
    self.event_param = cusData.param
    self.label = _TT(cusData.btn_name)
    self.btn_icon = cusData.btn_icon
    self.trigger_type = cusData.trigger_type --触发类型
    self.is_repeat = cusData.is_repeat == 1 -- 是否可以重复触发
    self.isLook = cusData.is_look == 1 --执行事件的时候是否需要转向NPC
    self.trigger_state = cusData.trigger_state --触发事件时需要限制什么

    self.talke_type = cusData.talke_type --剧情模式
    self.camera_pos = cusData.camera_pos --剧情位置
end

function getIconPath(self)
    if string.NullOrEmpty(self.btn_icon) then
        return nil
    end

    return "arts/ui/icon/sandPlay/" .. self.btn_icon
end

return _M
