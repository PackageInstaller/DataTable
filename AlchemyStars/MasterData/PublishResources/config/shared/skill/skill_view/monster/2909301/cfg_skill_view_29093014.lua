LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2909301/cfg_skill_view_29093014.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�K��� �� � A�  �B �� � A +C� kA����A B A� ��  �B C K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; �       � PlayCasterAnimation,animName =Skill_02; PlayAudio,audioID = 6228,audioType=1; Wait,waitTime=50; PlayTeleportAsMoving,time=500; PlayRoleTeleport,type=9; j      � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; PlayGridRangeConvert,dataSource=4; PlayGridRangeEffect,effectID=29093012; ,      ! PlaySummonTrap,trapID=2909301;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV