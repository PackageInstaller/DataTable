--
-- Author:luqucheng
-- Date: 2019-10-18 14:47:19
--
local Role = import('Game.Battle.Entity.Role')
local Hero = Class("Hero", Role)


function Hero:ctor()
    
end
--desc:
--Author:luqucheng
--date:2019-10-18 14:47:19
function  Hero:Test()
    
end

function Hero:Show( )
    -- Hero.super.Show()
    printInfo("I am a hero")
end

return  Hero