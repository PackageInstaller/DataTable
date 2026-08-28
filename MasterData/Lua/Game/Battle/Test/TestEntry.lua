--
-- Author:luqucheng
-- Date: 2019-10-18 10:20:09
--
local Hero = import('Game.Battle.Entity.Hero')
local Role = import('Game.Battle.Entity.Role')
local cs_coroutine = import('XLua.cs_coroutine')

local TestEntry = {}
--desc:
--Author:luqucheng
--date:2019-10-18 10:20:09
function  TestEntry.Test()
    printInfo("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~1")
    -- local p = Role.New()
    -- local p = Role.New()
    -- -- printInfo(p.aaa)
    -- printInfo(p:GetAttr(Constants.AttrTypeId.Hp))
    -- local json = '{"randomSeed":"12322345","playerTeam":[{"id":1,"cardId":101001,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crt=0.1&crd=2.0&hit=1&dge=0.1","skillLevel":"1=1&2=1&3=1"},{"id":2,"cardId":101002,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crt=0.1&crd=2.0&hit=1&dge=0.1","skillLevel":"1=1&2=1&3=1"}],"enemyTeam":[{"id":3,"enemyId":1001,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crt=0.1&crd=2.0&hit=1&dge=0.1","skillLevel":"1=1&2=1&3=1"},{"id":4,"enemyId":1002,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crt=0.1&crd=2.0&hit=1&dge=0.1","skillLevel":"1=1&2=1&3=1"}]}'
    -- local json = '{"randomSeed":"5de9cdd7978db","playerTeam":[{"id":1,"cardId":102008,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crt=0.1&crd=2.0&hit=1&dge=0.1","skill1":"41101001=1","skill2":"42101001=1","skill3":"43101001=1","passiveLevel":"100004=1&100005=1"},{"id":2,"cardId":102008,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crt=0.1&crd=2.0&hit=1&dge=0.1","skill1":"41101001=1","skill2":"42101001=1","skill3":"43101001=1","passiveLevel":"100004=1&100005=1"}],"enemyTeam":[{"id":3,"enemyId":80011,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crt=0.1&crd=2.0&hit=1&dge=0.1","skill1":"41101001=1","skill2":"42101001=1","skill3":"43101001=1","passiveLevel":"100004=1&100005=1"},{"id":4,"enemyId":80011,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crt=0.1&crd=2.0&hit=1&dge=0.1","skill1":"41101001=1","skill2":"42101001=1","skill3":"43101001=1","passiveLevel":"100004=1&100005=1"}]}'
    -- local d = table.deserialize(json)
    -- print( table.toString(d, "data") )
    -- BattleMgr:Init(d)
    -- BattleMgr:InitBattle()

    -- local operation = CS.UnityEngine.SceneManagement.SceneManager.LoadSceneAsync('BattleLoading', CS.UnityEngine.SceneManagement.LoadSceneMode.Single)
    -- operation.allowSceneActivation = true

    -- BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
    -- BattleViewMgr:Init()
    -- cs_coroutine.start(BattleViewMgr.PreLoad, BattleViewMgr, d)

    printInfo("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~2")
    -- p.x = 10
    -- printInfo(p.x)
    -- printInfo(p.x)
    -- printInfo(p.x)
    -- printInfo(p.x)
    -- printInfo(p.x)
end

return TestEntry