--[[ 
-----------------------------------------------------
@filename       : RecruitLive
@Description    : 战员战员
@date           : 2022-7-13 17:59:00
@Author         : ZDH
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.view.RecruitLive', Class.impl(model.modelLive))


--构造函数

--设置配置Id
function setHeroTid(self,heroTid)
    self.heroTid = heroTid
end
--获取配置id
function getHeroTid(self)
    return self.heroTid
end

function showWeapon(self,finishCall)
    local heroVo = hero.HeroManager:getHeroConfigVo(self.heroTid)
    local model_id = heroVo.showModel
    local sRo = fight.RoleShowManager:getShowData(model_id)
    if sRo and sRo:getWeaponNode() ~= 0 then
        self:setWeaponLoadFightAni(true)
        local showWeaponSn = 1
        local wpath = UrlManager:getWeaponPath(string.format("%d_wq_%02d/model%d_wq_%02d.prefab", model_id, showWeaponSn, model_id, showWeaponSn))
        self:addWeapon(wpath, sRo:getWeaponNode(),nil,finishCall)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
