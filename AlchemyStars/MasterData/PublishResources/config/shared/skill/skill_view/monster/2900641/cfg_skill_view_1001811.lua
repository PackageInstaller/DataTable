LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2900641/cfg_skill_view_1001811.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A �� �B �B� �@��AA �A �� �  AB  � �� � �B� +A�K��� �� � A�  ��  �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName=skill01; PlayAudio,audioID =6099,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=800; PlayCasterBindEffect,effectID=PARAM.effectID1;       �I       Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=7,gridPosY=7,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=6,gridPosY=6,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=4,gridPosY=4,gridDirX=0,gridDirY=-1; Wait,waitTime=100; PlayEffectAGridPos,effectID=PARAM.effectID3,gridPosX=3,gridPosY=3,gridDirX=0,gridDirY=-1; Wait,waitTime=100; Wait,waitTime=100; ��       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; Wait,waitTime=100; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; d        PlaySummonTrap,trapID=61;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV