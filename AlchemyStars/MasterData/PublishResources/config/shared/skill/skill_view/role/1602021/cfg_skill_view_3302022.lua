LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602021/cfg_skill_view_3302022.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �� �� C �B� +A�K��� �� � A�  �B  �� � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400161,waitTime = 2000;�        PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayCasterAnimation,animName = AtkUlt2; PlayCasterBindEffect,effectID =160202113; Play1602021LineHandToTrap, effectID=160202114,handObjectName=Bip001 L Hand, knifeHandleObjectName=Swordhilt,p1YOffset=0.8,p2YOffset=0.7,p3YOffset=0; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =45020203; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff;�      a PlayAudio,audioID = 2653,audioType=1; DataSelectResult,effectType=79,index=1; PlayDestroyTrap;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV