LuaS �

xV           (w@]@../PublishResources/config/shared/skill/skill_view/trap/1601111/cfg_skill_view_16011110.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 2327,audioType=1; Wait,waitTime=210; PlayEffectAtCasterPos,effectID=2640; DataSelectDamage,damageIndex = 1; PlayCommonBeHit; Wait,waitTime=100; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=16011110; d       �DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =42011122; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; Wait,waitTime=100;        %                                                                                                                     key   %   config    %      _ENV