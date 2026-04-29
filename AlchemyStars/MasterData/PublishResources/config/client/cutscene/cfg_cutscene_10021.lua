local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local config = {
  {
    1,
    1,
    0,
    1,
    0,
    0,
    {
      " CutsceneTrapFadeOut,duration=1000; CutsceneWait,waitTime=2000; CutsceneChangeFogColor,duration=1000,colorR=96,colorG=46,colorB=64,colorA=255; CutsceneCreateMonster,monsterID=2020723,name=M1,posX=5,posY=6; CutsceneCreateMonster,monsterID=2000431,name=M1,posX=5,posY=6; CutsceneCreateMonster,monsterID=2000432,name=M1,posX=5,posY=6; CutsceneMonsterBindEffect,effectID=214,name=M1; CutsceneWait,waitTime=1000; CutsceneMonsterMoveToPlayer,monsterName=M1,moveSpeed=2,moveGridCount=3; CutsceneMonsterTurnToPlayer,name=M1; CutsceneWait,waitTime=2000; CutsceneCreateMonster,monsterID=9000201,name=M2,posX=5,posY=6; CutsceneCreateMonster,monsterID=9000202,name=M2,posX=5,posY=6; CutsceneCreateMonster,monsterID=9000153,name=M2,posX=5,posY=6; CutsceneCreateMonster,monsterID=9000152,name=M2,posX=5,posY=6; CutsceneCreateMonster,monsterID=9000351,name=M2,posX=5,posY=6; CutsceneCreateMonster,monsterID=9000352,name=M2,posX=5,posY=6; CutsceneCreateMonster,monsterID=9000353,name=M2,posX=5,posY=6; CutsceneMonsterBindEffect,effectID=214,name=M2; CutsceneWait,waitTime=500; CutsceneWait,waitTime=500; CutsceneMonsterMoveToPlayer,monsterName=M2,moveSpeed=2,moveGridCount=3; CutsceneMonsterTurnToPlayer,name=M2; CutsceneWait,waitTime=1000; CutsceneGridEffect,effectID=2904,posX=5,posY=4; CutsceneChangeSkyBoxColor,duration=1000,colorR=128,colorG=43,colorB=64,colorA=128; CutsceneFindObjPlayAnimation,gameObjectName=eff_2900407_yanchu_scene01, anim=eff_2900407_yanchu_scene_01; CutsceneCameraEffect,effectID=2901; CutsceneWait,waitTime=800; CutscenePlayAudio,audioID=6040; CutsceneWait,waitTime=1200; CutsceneGridEffect,effectID=2903,posX=5,posY=4; CutsceneWait,waitTime=830; CutsceneMonsterBindEffect,effectID=2902,name=M1; CutsceneMonsterBindEffect,effectID=2902,name=M2; CutscenePlayerBindEffect,effectID=2902; CutsceneMonsterDeadAnimation,name=M1,monsterDeadType=1; CutsceneMonsterDeadAnimation,name=M2,monsterDeadType=1; CutscenePlayerAnimation,anim=Stun; CutsceneHitbackPlayer,dirX=0,dirY=-1,dis=9; CutsceneWait,waitTime=370; CutsceneGridEffect,effectID=2905,posX=5,posY=7; CutsceneWait,waitTime=300; CutsceneCreateMonster,monsterID=2900671,name=M3,posX=5,posY=7; CutsceneMonsterAnimation,name=M3,anim=Yanchu; CutsceneWait,waitTime=7000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " CutsceneWait,waitTime=1000; "
    }
  }
}
return config, "ID", key
