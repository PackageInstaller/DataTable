LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905001/cfg_skill_view_290501112.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  A�  �� �� C �B� +A�K��� �� � A�  ��  �� � A� +C� kA����A B A� ��  ��  K� �C kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �&       Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; Wait,waitTime=1000; PlayCasterBindEffect,effectID =290500105; PlayCasterBindEffect,effectID =290500106; PlayCasterAnimation,animName=skill01; PlayAudio,audioID = 6273,audioType=1; Wait,waitTime=2000; PlayRoleTeleport,type=3, onlySelf=1; O PlaySummonTrap,trapID=29050013,effectID=290500113,interval=100,waitFinish=1; ��       Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; PlayRoleTeleport,type=5, onlySelf=1; PlayRotateResult; PlayChangeBodyArea; PlayRoleTeleport,type=6, onlySelf=1; PlayRoleTeleport,type=9, onlySelf=1; PlayCasterAnimation,animName=skill01(1); Wait,waitTime=2000; PlayCasterBindEffect,effectID =290500108; PlayCasterAnimation,animName=skill01(2); PlayCasterBindEffect,effectID =290500107; Wait,waitTime=2000; �      � PlayAudio,audioID = 5078,audioType=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200240103,turnToTarget=1,deathClear=0; Wait,waitTime=700; �      S Wait,waitTime=1000; PlaySummonTrapBySummonEveryThing,trapID=29050012,effectID=0;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV