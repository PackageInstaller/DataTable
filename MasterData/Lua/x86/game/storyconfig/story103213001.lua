return {
	Play321301001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321301001
		arg_1_1.duration_ = 9.73

		local var_1_0 = {
			zh = 9.00000000298023,
			ja = 9.73300000298023
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321301002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L09g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09g")
				var_4_0.name = "L09g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L09g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L09g

				arg_1_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L09g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1111ui_story"

			if arg_1_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1111ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1111ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.87, -5.7)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1111ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1111ui_story == nil then
				arg_1_1.var_.characterEffect1111ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1111ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1111ui_story then
				arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2.00000000298023
			local var_4_25 = 0.4

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(321301001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 16 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 16)

				if (16 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 16)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301001", "story_v_out_321301.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_321301", "321301001", "story_v_out_321301.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_321301", "321301001", "story_v_out_321301.awb")

						arg_1_1:RecordAudio("321301001", var_4_32)
						arg_1_1:RecordAudio("321301001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321301", "321301001", "story_v_out_321301.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321301", "321301001", "story_v_out_321301.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play321301002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321301002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321301003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1111ui_story = arg_9_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).z)
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles = arg_9_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1111ui_story"].transform.position).z)
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1111ui_story"].transform.localEulerAngles = arg_9_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1111ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1111ui_story == nil then
				arg_9_1.var_.characterEffect1111ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1111ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1111ui_story then
				arg_9_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_9_1.time_ and arg_9_1.time_ <= 0.05 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_slide", "")
			end

			local var_12_4 = 0
			local var_12_5 = 1.025

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_6 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321301002).content)

				arg_9_1.text_.text = var_12_6

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_8 = 41 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 41)

				if (41 <= 0 and var_12_5 or var_12_5 * (utf8.len(var_12_6) / 41)) > 0 and var_12_5 < var_12_8 then
					arg_9_1.talkMaxDuration = var_12_8

					if var_12_8 + var_12_4 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_4
					end
				end

				arg_9_1.text_.text = var_12_6
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_9 = math.max(var_12_5, arg_9_1.talkMaxDuration)

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_4) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_4 + var_12_9 and arg_9_1.time_ < var_12_4 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play321301003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321301003
		arg_13_1.duration_ = 6

		local var_13_0 = {
			zh = 4.4,
			ja = 6
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321301004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1111ui_story = arg_13_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1111ui_story"].transform.position).z)
				arg_13_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1111ui_story"].transform.localEulerAngles = arg_13_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_13_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1111ui_story"].transform.position).z)
				arg_13_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1111ui_story"].transform.localEulerAngles = arg_13_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1111ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1111ui_story == nil then
				arg_13_1.var_.characterEffect1111ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1111ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1111ui_story then
				arg_13_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_4 = 0
			local var_16_5 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(321301003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 18 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 18)

				if (18 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 18)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301003", "story_v_out_321301.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301003", "story_v_out_321301.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_321301", "321301003", "story_v_out_321301.awb")

						arg_13_1:RecordAudio("321301003", var_16_11)
						arg_13_1:RecordAudio("321301003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321301", "321301003", "story_v_out_321301.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321301", "321301003", "story_v_out_321301.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play321301004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321301004
		arg_17_1.duration_ = 3.87

		local var_17_0 = {
			zh = 3.866,
			ja = 2.966
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321301005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1111ui_story"]) and arg_17_1.var_.characterEffect1111ui_story == nil then
				arg_17_1.var_.characterEffect1111ui_story = arg_17_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1111ui_story"]) then
				if arg_17_1.var_.characterEffect1111ui_story and not isNil(arg_17_1.actors_["1111ui_story"]) then
					arg_17_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1111ui_story"]) and arg_17_1.var_.characterEffect1111ui_story then
				arg_17_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(321301004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 10 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 10)

				if (10 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 10)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301004", "story_v_out_321301.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301004", "story_v_out_321301.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_321301", "321301004", "story_v_out_321301.awb")

						arg_17_1:RecordAudio("321301004", var_20_8)
						arg_17_1:RecordAudio("321301004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321301", "321301004", "story_v_out_321301.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321301", "321301004", "story_v_out_321301.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321301005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321301005
		arg_21_1.duration_ = 6.13

		local var_21_0 = {
			zh = 4.233,
			ja = 6.133
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321301006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1111ui_story"]) and arg_21_1.var_.characterEffect1111ui_story == nil then
				arg_21_1.var_.characterEffect1111ui_story = arg_21_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1111ui_story"]) then
				if arg_21_1.var_.characterEffect1111ui_story and not isNil(arg_21_1.actors_["1111ui_story"]) then
					arg_21_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1111ui_story"]) and arg_21_1.var_.characterEffect1111ui_story then
				arg_21_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_24_2 = 0
			local var_24_3 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(321301005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 18 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 18)

				if (18 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 18)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301005", "story_v_out_321301.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_321301", "321301005", "story_v_out_321301.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_321301", "321301005", "story_v_out_321301.awb")

						arg_21_1:RecordAudio("321301005", var_24_9)
						arg_21_1:RecordAudio("321301005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321301", "321301005", "story_v_out_321301.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321301", "321301005", "story_v_out_321301.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321301006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321301006
		arg_25_1.duration_ = 10.47

		local var_25_0 = {
			zh = 5.666,
			ja = 10.466
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321301007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1111ui_story = arg_25_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_1 = 0
			local var_28_2 = 0.525

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(321301006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 21 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 21)

				if (21 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 21)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301006", "story_v_out_321301.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301006", "story_v_out_321301.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_321301", "321301006", "story_v_out_321301.awb")

						arg_25_1:RecordAudio("321301006", var_28_8)
						arg_25_1:RecordAudio("321301006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321301", "321301006", "story_v_out_321301.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321301", "321301006", "story_v_out_321301.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play321301007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321301007
		arg_29_1.duration_ = 9.43

		local var_29_0 = {
			zh = 8.5,
			ja = 9.433
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play321301008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1111ui_story"]) and arg_29_1.var_.characterEffect1111ui_story == nil then
				arg_29_1.var_.characterEffect1111ui_story = arg_29_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1111ui_story"]) then
				if arg_29_1.var_.characterEffect1111ui_story and not isNil(arg_29_1.actors_["1111ui_story"]) then
					arg_29_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1111ui_story"]) and arg_29_1.var_.characterEffect1111ui_story then
				arg_29_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.975

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(321301007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 39 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 39)

				if (39 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 39)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301007", "story_v_out_321301.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301007", "story_v_out_321301.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_321301", "321301007", "story_v_out_321301.awb")

						arg_29_1:RecordAudio("321301007", var_32_8)
						arg_29_1:RecordAudio("321301007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321301", "321301007", "story_v_out_321301.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321301", "321301007", "story_v_out_321301.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321301008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321301008
		arg_33_1.duration_ = 3.5

		local var_33_0 = {
			zh = 2.533,
			ja = 3.5
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play321301009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1111ui_story = arg_33_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_36_1 = "1043ui_story"

			if arg_33_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_33_1.stage_.transform)

				var_36_2.name = var_36_1
				var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_[var_36_1] = var_36_2

				local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

				var_36_3.enabled = true

				local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

				if var_36_4 then
					var_36_4:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_3.transform, false)

				arg_33_1.var_[var_36_1 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_[var_36_1 .. "Animator"].applyRootMotion = true
				arg_33_1.var_[var_36_1 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_5 = arg_33_1.actors_["1043ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1043ui_story = var_36_5.localPosition
			end

			local var_36_6 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 then
				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_33_1.time_ - 0) / var_36_6)
				var_36_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_5.position).x, (manager.ui.mainCamera.transform.position - var_36_5.position).y, (manager.ui.mainCamera.transform.position - var_36_5.position).z)
				var_36_5.localEulerAngles.z = 0
				var_36_5.localEulerAngles.x = 0
				var_36_5.localEulerAngles = var_36_5.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_36_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_5.position).x, (manager.ui.mainCamera.transform.position - var_36_5.position).y, (manager.ui.mainCamera.transform.position - var_36_5.position).z)
				var_36_5.localEulerAngles.z = 0
				var_36_5.localEulerAngles.x = 0
				var_36_5.localEulerAngles = var_36_5.localEulerAngles
			end

			local var_36_7 = arg_33_1.actors_["1043ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.characterEffect1043ui_story == nil then
				arg_33_1.var_.characterEffect1043ui_story = var_36_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_8 and not isNil(var_36_7) then
				if arg_33_1.var_.characterEffect1043ui_story and not isNil(var_36_7) then
					arg_33_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_8 and arg_33_1.time_ < 0 + var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.characterEffect1043ui_story then
				arg_33_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_10 = 0
			local var_36_11 = 0.3

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:GetWordFromCfg(321301008)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 12 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_13) / 12)

				if (12 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_13) / 12)) > 0 and var_36_11 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301008", "story_v_out_321301.awb") ~= 0 then
					local var_36_16 = manager.audio:GetVoiceLength("story_v_out_321301", "321301008", "story_v_out_321301.awb") / 1000

					if var_36_16 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_10
					end

					if var_36_12.prefab_name ~= "" and arg_33_1.actors_[var_36_12.prefab_name] ~= nil then
						local var_36_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_12.prefab_name].transform, "story_v_out_321301", "321301008", "story_v_out_321301.awb")

						arg_33_1:RecordAudio("321301008", var_36_17)
						arg_33_1:RecordAudio("321301008", var_36_17)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321301", "321301008", "story_v_out_321301.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321301", "321301008", "story_v_out_321301.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_18 and arg_33_1.time_ < var_36_10 + var_36_18 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play321301009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321301009
		arg_37_1.duration_ = 8.37

		local var_37_0 = {
			zh = 7.333,
			ja = 8.366
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321301010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_40_0 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_37_1.stage_.transform)

				var_40_0.name = "10131ui_story"
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10131ui_story"] = var_40_0

				local var_40_1 = var_40_0:GetComponentInChildren(typeof(CharacterEffect))

				var_40_1.enabled = true

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_1.transform, false)

				arg_37_1.var_["10131ui_story" .. "Animator"] = var_40_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_["10131ui_story" .. "Animator"].applyRootMotion = true
				arg_37_1.var_["10131ui_story" .. "LipSync"] = var_40_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_3 = arg_37_1.actors_["10131ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10131ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["1111ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1111ui_story = var_40_5.localPosition
			end

			local var_40_6 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_6)
				var_40_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_5.position).x, (manager.ui.mainCamera.transform.position - var_40_5.position).y, (manager.ui.mainCamera.transform.position - var_40_5.position).z)
				var_40_5.localEulerAngles.z = 0
				var_40_5.localEulerAngles.x = 0
				var_40_5.localEulerAngles = var_40_5.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, 100, 0)
				var_40_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_5.position).x, (manager.ui.mainCamera.transform.position - var_40_5.position).y, (manager.ui.mainCamera.transform.position - var_40_5.position).z)
				var_40_5.localEulerAngles.z = 0
				var_40_5.localEulerAngles.x = 0
				var_40_5.localEulerAngles = var_40_5.localEulerAngles
			end

			local var_40_7 = arg_37_1.actors_["1043ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1043ui_story = var_40_7.localPosition
			end

			local var_40_8 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_8 then
				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_37_1.time_ - 0) / var_40_8)
				var_40_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_7.position).x, (manager.ui.mainCamera.transform.position - var_40_7.position).y, (manager.ui.mainCamera.transform.position - var_40_7.position).z)
				var_40_7.localEulerAngles.z = 0
				var_40_7.localEulerAngles.x = 0
				var_40_7.localEulerAngles = var_40_7.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_8 and arg_37_1.time_ < 0 + var_40_8 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_40_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_7.position).x, (manager.ui.mainCamera.transform.position - var_40_7.position).y, (manager.ui.mainCamera.transform.position - var_40_7.position).z)
				var_40_7.localEulerAngles.z = 0
				var_40_7.localEulerAngles.x = 0
				var_40_7.localEulerAngles = var_40_7.localEulerAngles
			end

			local var_40_9 = arg_37_1.actors_["10131ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10131ui_story == nil then
				arg_37_1.var_.characterEffect10131ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_10 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_10 and not isNil(var_40_9) then
				if arg_37_1.var_.characterEffect10131ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_10 and arg_37_1.time_ < 0 + var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10131ui_story then
				arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_40_12 = arg_37_1.actors_["1043ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_12) and arg_37_1.var_.characterEffect1043ui_story == nil then
				arg_37_1.var_.characterEffect1043ui_story = var_40_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_13 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_13 and not isNil(var_40_12) then
				if arg_37_1.var_.characterEffect1043ui_story and not isNil(var_40_12) then
					arg_37_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_13)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_13 and arg_37_1.time_ < 0 + var_40_13 + arg_40_0 and not isNil(var_40_12) and arg_37_1.var_.characterEffect1043ui_story then
				arg_37_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_40_14 = 0
			local var_40_15 = 0.75

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_16 = arg_37_1:GetWordFromCfg(321301009)
				local var_40_17 = arg_37_1:FormatText(var_40_16.content)

				arg_37_1.text_.text = var_40_17

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_19 = 30 <= 0 and var_40_15 or var_40_15 * (utf8.len(var_40_17) / 30)

				if (30 <= 0 and var_40_15 or var_40_15 * (utf8.len(var_40_17) / 30)) > 0 and var_40_15 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_14
					end
				end

				arg_37_1.text_.text = var_40_17
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301009", "story_v_out_321301.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_321301", "321301009", "story_v_out_321301.awb") / 1000

					if var_40_20 + var_40_14 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_14
					end

					if var_40_16.prefab_name ~= "" and arg_37_1.actors_[var_40_16.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_16.prefab_name].transform, "story_v_out_321301", "321301009", "story_v_out_321301.awb")

						arg_37_1:RecordAudio("321301009", var_40_21)
						arg_37_1:RecordAudio("321301009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321301", "321301009", "story_v_out_321301.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321301", "321301009", "story_v_out_321301.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_15, arg_37_1.talkMaxDuration)

			if var_40_14 <= arg_37_1.time_ and arg_37_1.time_ < var_40_14 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_14) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_14 + var_40_22 and arg_37_1.time_ < var_40_14 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play321301010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321301010
		arg_41_1.duration_ = 2

		local var_41_0 = {
			zh = 1.833,
			ja = 2
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321301011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1043ui_story"]) and arg_41_1.var_.characterEffect1043ui_story == nil then
				arg_41_1.var_.characterEffect1043ui_story = arg_41_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1043ui_story"]) then
				if arg_41_1.var_.characterEffect1043ui_story and not isNil(arg_41_1.actors_["1043ui_story"]) then
					arg_41_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1043ui_story"]) and arg_41_1.var_.characterEffect1043ui_story then
				arg_41_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["10131ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect10131ui_story == nil then
				arg_41_1.var_.characterEffect10131ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect10131ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect10131ui_story then
				arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_44_4 = 0
			local var_44_5 = 0.275

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(321301010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 11 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 11)

				if (11 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 11)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301010", "story_v_out_321301.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301010", "story_v_out_321301.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_321301", "321301010", "story_v_out_321301.awb")

						arg_41_1:RecordAudio("321301010", var_44_11)
						arg_41_1:RecordAudio("321301010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321301", "321301010", "story_v_out_321301.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321301", "321301010", "story_v_out_321301.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play321301011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321301011
		arg_45_1.duration_ = 4.23

		local var_45_0 = {
			zh = 3.5,
			ja = 4.233
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play321301012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_48_0 = 0
			local var_48_1 = 0.4

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(321301011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 16 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 16)

				if (16 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 16)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301011", "story_v_out_321301.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_321301", "321301011", "story_v_out_321301.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_321301", "321301011", "story_v_out_321301.awb")

						arg_45_1:RecordAudio("321301011", var_48_7)
						arg_45_1:RecordAudio("321301011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321301", "321301011", "story_v_out_321301.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321301", "321301011", "story_v_out_321301.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play321301012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321301012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play321301013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10131ui_story = arg_49_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10131ui_story"].transform.position).z)
				arg_49_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10131ui_story"].transform.localEulerAngles = arg_49_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10131ui_story"].transform.position).z)
				arg_49_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10131ui_story"].transform.localEulerAngles = arg_49_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1043ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1043ui_story = var_52_1.localPosition
			end

			local var_52_2 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 then
				var_52_1.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_2)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 then
				var_52_1.localPosition = Vector3.New(0, 100, 0)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			local var_52_3 = arg_49_1.actors_["1043ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect1043ui_story == nil then
				arg_49_1.var_.characterEffect1043ui_story = var_52_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 and not isNil(var_52_3) then
				if arg_49_1.var_.characterEffect1043ui_story and not isNil(var_52_3) then
					arg_49_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_4)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect1043ui_story then
				arg_49_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_52_5 = 0
			local var_52_6 = 1.425

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(321301012).content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 57 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 57)

				if (57 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 57)) > 0 and var_52_6 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_10 and arg_49_1.time_ < var_52_5 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play321301013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321301013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play321301014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.7

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(321301013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 68 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 68)

				if (68 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 68)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play321301014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321301014
		arg_57_1.duration_ = 1.3

		local var_57_0 = {
			zh = 1.1,
			ja = 1.3
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play321301015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10131ui_story = arg_57_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10131ui_story"].transform.position).z)
				arg_57_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10131ui_story"].transform.localEulerAngles = arg_57_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_57_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10131ui_story"].transform.position).z)
				arg_57_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10131ui_story"].transform.localEulerAngles = arg_57_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1043ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1043ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = arg_57_1.actors_["10131ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect10131ui_story == nil then
				arg_57_1.var_.characterEffect10131ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect10131ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect10131ui_story then
				arg_57_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_60_6 = 0
			local var_60_7 = 0.15

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(321301014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 6 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 6)

				if (6 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 6)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301014", "story_v_out_321301.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_321301", "321301014", "story_v_out_321301.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_321301", "321301014", "story_v_out_321301.awb")

						arg_57_1:RecordAudio("321301014", var_60_13)
						arg_57_1:RecordAudio("321301014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321301", "321301014", "story_v_out_321301.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321301", "321301014", "story_v_out_321301.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play321301015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321301015
		arg_61_1.duration_ = 3.17

		local var_61_0 = {
			zh = 1.9,
			ja = 3.166
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play321301016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1043ui_story"]) and arg_61_1.var_.characterEffect1043ui_story == nil then
				arg_61_1.var_.characterEffect1043ui_story = arg_61_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1043ui_story"]) then
				if arg_61_1.var_.characterEffect1043ui_story and not isNil(arg_61_1.actors_["1043ui_story"]) then
					arg_61_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1043ui_story"]) and arg_61_1.var_.characterEffect1043ui_story then
				arg_61_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["10131ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect10131ui_story == nil then
				arg_61_1.var_.characterEffect10131ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect10131ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect10131ui_story then
				arg_61_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.25

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(321301015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 10 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 10)

				if (10 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 10)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301015", "story_v_out_321301.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301015", "story_v_out_321301.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_321301", "321301015", "story_v_out_321301.awb")

						arg_61_1:RecordAudio("321301015", var_64_11)
						arg_61_1:RecordAudio("321301015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321301", "321301015", "story_v_out_321301.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321301", "321301015", "story_v_out_321301.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play321301016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321301016
		arg_65_1.duration_ = 5.57

		local var_65_0 = {
			zh = 4.2,
			ja = 5.566
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play321301017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10131ui_story"]) and arg_65_1.var_.characterEffect10131ui_story == nil then
				arg_65_1.var_.characterEffect10131ui_story = arg_65_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10131ui_story"]) then
				if arg_65_1.var_.characterEffect10131ui_story and not isNil(arg_65_1.actors_["10131ui_story"]) then
					arg_65_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10131ui_story"]) and arg_65_1.var_.characterEffect10131ui_story then
				arg_65_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1043ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1043ui_story == nil then
				arg_65_1.var_.characterEffect1043ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1043ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1043ui_story then
				arg_65_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_68_4 = 0
			local var_68_5 = 0.4

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(321301016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 16 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 16)

				if (16 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 16)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301016", "story_v_out_321301.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301016", "story_v_out_321301.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_321301", "321301016", "story_v_out_321301.awb")

						arg_65_1:RecordAudio("321301016", var_68_11)
						arg_65_1:RecordAudio("321301016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321301", "321301016", "story_v_out_321301.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321301", "321301016", "story_v_out_321301.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play321301017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321301017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play321301018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10131ui_story = arg_69_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).z)
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles = arg_69_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_69_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).z)
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles = arg_69_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1043ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1043ui_story = var_72_1.localPosition
			end

			local var_72_2 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 then
				var_72_1.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_69_1.time_ - 0) / var_72_2)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 then
				var_72_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			local var_72_3 = arg_69_1.actors_["1043ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect1043ui_story == nil then
				arg_69_1.var_.characterEffect1043ui_story = var_72_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 and not isNil(var_72_3) then
				if arg_69_1.var_.characterEffect1043ui_story and not isNil(var_72_3) then
					arg_69_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect1043ui_story then
				arg_69_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_72_6 = arg_69_1.actors_["10131ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10131ui_story == nil then
				arg_69_1.var_.characterEffect10131ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_7 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 and not isNil(var_72_6) then
				if arg_69_1.var_.characterEffect10131ui_story and not isNil(var_72_6) then
					arg_69_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_7)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect10131ui_story then
				arg_69_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_72_8 = 0
			local var_72_9 = 0.1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(321301017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 4 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 4)

				if (4 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 4)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301017", "story_v_out_321301.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301017", "story_v_out_321301.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_321301", "321301017", "story_v_out_321301.awb")

						arg_69_1:RecordAudio("321301017", var_72_15)
						arg_69_1:RecordAudio("321301017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321301", "321301017", "story_v_out_321301.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321301", "321301017", "story_v_out_321301.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play321301018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321301018
		arg_73_1.duration_ = 7.53

		local var_73_0 = {
			zh = 5.4,
			ja = 7.533
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play321301019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10131ui_story"]) and arg_73_1.var_.characterEffect10131ui_story == nil then
				arg_73_1.var_.characterEffect10131ui_story = arg_73_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10131ui_story"]) then
				if arg_73_1.var_.characterEffect10131ui_story and not isNil(arg_73_1.actors_["10131ui_story"]) then
					arg_73_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10131ui_story"]) and arg_73_1.var_.characterEffect10131ui_story then
				arg_73_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_76_2 = arg_73_1.actors_["1043ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1043ui_story == nil then
				arg_73_1.var_.characterEffect1043ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect1043ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1043ui_story then
				arg_73_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_76_4 = 0
			local var_76_5 = 0.65

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(321301018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 26 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 26)

				if (26 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 26)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301018", "story_v_out_321301.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301018", "story_v_out_321301.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_321301", "321301018", "story_v_out_321301.awb")

						arg_73_1:RecordAudio("321301018", var_76_11)
						arg_73_1:RecordAudio("321301018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321301", "321301018", "story_v_out_321301.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321301", "321301018", "story_v_out_321301.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play321301019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321301019
		arg_77_1.duration_ = 1.17

		local var_77_0 = {
			zh = 1.066,
			ja = 1.166
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play321301020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1043ui_story"]) and arg_77_1.var_.characterEffect1043ui_story == nil then
				arg_77_1.var_.characterEffect1043ui_story = arg_77_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1043ui_story"]) then
				if arg_77_1.var_.characterEffect1043ui_story and not isNil(arg_77_1.actors_["1043ui_story"]) then
					arg_77_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1043ui_story"]) and arg_77_1.var_.characterEffect1043ui_story then
				arg_77_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_80_2 = arg_77_1.actors_["10131ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect10131ui_story == nil then
				arg_77_1.var_.characterEffect10131ui_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect10131ui_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_3)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect10131ui_story then
				arg_77_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_80_4 = 0
			local var_80_5 = 0.075

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(321301019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 3 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 3)

				if (3 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 3)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301019", "story_v_out_321301.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301019", "story_v_out_321301.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_321301", "321301019", "story_v_out_321301.awb")

						arg_77_1:RecordAudio("321301019", var_80_11)
						arg_77_1:RecordAudio("321301019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321301", "321301019", "story_v_out_321301.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321301", "321301019", "story_v_out_321301.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321301020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321301020
		arg_81_1.duration_ = 3.6

		local var_81_0 = {
			zh = 3.6,
			ja = 3.566
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play321301021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10131ui_story = arg_81_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).z)
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles = arg_81_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_81_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).z)
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles = arg_81_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1043ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1043ui_story = var_84_1.localPosition
			end

			local var_84_2 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 then
				var_84_1.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_81_1.time_ - 0) / var_84_2)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 then
				var_84_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			local var_84_3 = arg_81_1.actors_["10131ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect10131ui_story == nil then
				arg_81_1.var_.characterEffect10131ui_story = var_84_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_4 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 and not isNil(var_84_3) then
				if arg_81_1.var_.characterEffect10131ui_story and not isNil(var_84_3) then
					arg_81_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect10131ui_story then
				arg_81_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_84_6 = arg_81_1.actors_["1043ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1043ui_story == nil then
				arg_81_1.var_.characterEffect1043ui_story = var_84_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_7 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 and not isNil(var_84_6) then
				if arg_81_1.var_.characterEffect1043ui_story and not isNil(var_84_6) then
					arg_81_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_7)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1043ui_story then
				arg_81_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_8 = 0
			local var_84_9 = 0.4

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(321301020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 16 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 16)

				if (16 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 16)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301020", "story_v_out_321301.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301020", "story_v_out_321301.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_321301", "321301020", "story_v_out_321301.awb")

						arg_81_1:RecordAudio("321301020", var_84_15)
						arg_81_1:RecordAudio("321301020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321301", "321301020", "story_v_out_321301.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321301", "321301020", "story_v_out_321301.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play321301021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321301021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play321301022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10131ui_story = arg_85_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).z)
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles = arg_85_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).z)
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles = arg_85_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1043ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1043ui_story = var_88_1.localPosition
			end

			local var_88_2 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 then
				var_88_1.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_2)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 then
				var_88_1.localPosition = Vector3.New(0, 100, 0)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			local var_88_3 = arg_85_1.actors_["10131ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect10131ui_story == nil then
				arg_85_1.var_.characterEffect10131ui_story = var_88_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_4 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 and not isNil(var_88_3) then
				if arg_85_1.var_.characterEffect10131ui_story and not isNil(var_88_3) then
					arg_85_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_4)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect10131ui_story then
				arg_85_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_88_5 = 0
			local var_88_6 = 0.825

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(321301021).content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 33 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_7) / 33)

				if (33 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_7) / 33)) > 0 and var_88_6 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_10 and arg_85_1.time_ < var_88_5 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play321301022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321301022
		arg_89_1.duration_ = 3.53

		local var_89_0 = {
			zh = 2.233,
			ja = 3.533
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play321301023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10131ui_story = arg_89_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10131ui_story"].transform.position).z)
				arg_89_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10131ui_story"].transform.localEulerAngles = arg_89_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				arg_89_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10131ui_story"].transform.position).z)
				arg_89_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10131ui_story"].transform.localEulerAngles = arg_89_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1043ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1043ui_story = var_92_1.localPosition
			end

			local var_92_2 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_89_1.time_ - 0) / var_92_2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			local var_92_3 = arg_89_1.actors_["1043ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect1043ui_story == nil then
				arg_89_1.var_.characterEffect1043ui_story = var_92_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_4 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 and not isNil(var_92_3) then
				if arg_89_1.var_.characterEffect1043ui_story and not isNil(var_92_3) then
					arg_89_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect1043ui_story then
				arg_89_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_92_6 = 0
			local var_92_7 = 0.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(321301022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 8 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 8)

				if (8 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 8)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301022", "story_v_out_321301.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_321301", "321301022", "story_v_out_321301.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_321301", "321301022", "story_v_out_321301.awb")

						arg_89_1:RecordAudio("321301022", var_92_13)
						arg_89_1:RecordAudio("321301022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321301", "321301022", "story_v_out_321301.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321301", "321301022", "story_v_out_321301.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play321301023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321301023
		arg_93_1.duration_ = 9.8

		local var_93_0 = {
			zh = 8.9,
			ja = 9.8
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play321301024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10131ui_story"]) and arg_93_1.var_.characterEffect10131ui_story == nil then
				arg_93_1.var_.characterEffect10131ui_story = arg_93_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10131ui_story"]) then
				if arg_93_1.var_.characterEffect10131ui_story and not isNil(arg_93_1.actors_["10131ui_story"]) then
					arg_93_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10131ui_story"]) and arg_93_1.var_.characterEffect10131ui_story then
				arg_93_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_96_2 = arg_93_1.actors_["1043ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1043ui_story == nil then
				arg_93_1.var_.characterEffect1043ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect1043ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect1043ui_story then
				arg_93_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_96_4 = 0
			local var_96_5 = 0.925

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(321301023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 37 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 37)

				if (37 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 37)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301023", "story_v_out_321301.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301023", "story_v_out_321301.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_321301", "321301023", "story_v_out_321301.awb")

						arg_93_1:RecordAudio("321301023", var_96_11)
						arg_93_1:RecordAudio("321301023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321301", "321301023", "story_v_out_321301.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321301", "321301023", "story_v_out_321301.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play321301024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321301024
		arg_97_1.duration_ = 6.3

		local var_97_0 = {
			zh = 6.3,
			ja = 5.433
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play321301025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.675

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(321301024)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 27 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 27)

				if (27 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 27)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301024", "story_v_out_321301.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301024", "story_v_out_321301.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_321301", "321301024", "story_v_out_321301.awb")

						arg_97_1:RecordAudio("321301024", var_100_6)
						arg_97_1:RecordAudio("321301024", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_321301", "321301024", "story_v_out_321301.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_321301", "321301024", "story_v_out_321301.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play321301025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321301025
		arg_101_1.duration_ = 11.13

		local var_101_0 = {
			zh = 6.866,
			ja = 11.133
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play321301026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131actionlink/10131action465")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_104_0 = 0
			local var_104_1 = 0.85

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(321301025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 34 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 34)

				if (34 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 34)) > 0 and var_104_1 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301025", "story_v_out_321301.awb") ~= 0 then
					local var_104_6 = manager.audio:GetVoiceLength("story_v_out_321301", "321301025", "story_v_out_321301.awb") / 1000

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end

					if var_104_2.prefab_name ~= "" and arg_101_1.actors_[var_104_2.prefab_name] ~= nil then
						local var_104_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_2.prefab_name].transform, "story_v_out_321301", "321301025", "story_v_out_321301.awb")

						arg_101_1:RecordAudio("321301025", var_104_7)
						arg_101_1:RecordAudio("321301025", var_104_7)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321301", "321301025", "story_v_out_321301.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321301", "321301025", "story_v_out_321301.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play321301026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321301026
		arg_105_1.duration_ = 1.3

		local var_105_0 = {
			zh = 0.999999999999,
			ja = 1.3
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play321301027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1043ui_story"]) and arg_105_1.var_.characterEffect1043ui_story == nil then
				arg_105_1.var_.characterEffect1043ui_story = arg_105_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1043ui_story"]) then
				if arg_105_1.var_.characterEffect1043ui_story and not isNil(arg_105_1.actors_["1043ui_story"]) then
					arg_105_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1043ui_story"]) and arg_105_1.var_.characterEffect1043ui_story then
				arg_105_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_108_2 = arg_105_1.actors_["10131ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect10131ui_story == nil then
				arg_105_1.var_.characterEffect10131ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect10131ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_3)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect10131ui_story then
				arg_105_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_108_4 = 0
			local var_108_5 = 0.075

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(321301026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 3 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 3)

				if (3 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 3)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301026", "story_v_out_321301.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301026", "story_v_out_321301.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_321301", "321301026", "story_v_out_321301.awb")

						arg_105_1:RecordAudio("321301026", var_108_11)
						arg_105_1:RecordAudio("321301026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_321301", "321301026", "story_v_out_321301.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_321301", "321301026", "story_v_out_321301.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play321301027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321301027
		arg_109_1.duration_ = 5

		local var_109_0 = {
			zh = 3.9,
			ja = 5
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321301028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10131ui_story"]) and arg_109_1.var_.characterEffect10131ui_story == nil then
				arg_109_1.var_.characterEffect10131ui_story = arg_109_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10131ui_story"]) then
				if arg_109_1.var_.characterEffect10131ui_story and not isNil(arg_109_1.actors_["10131ui_story"]) then
					arg_109_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10131ui_story"]) and arg_109_1.var_.characterEffect10131ui_story then
				arg_109_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_112_2 = arg_109_1.actors_["1043ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect1043ui_story == nil then
				arg_109_1.var_.characterEffect1043ui_story = var_112_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.characterEffect1043ui_story and not isNil(var_112_2) then
					arg_109_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_3)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect1043ui_story then
				arg_109_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_4 = 0
			local var_112_5 = 0.45

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(321301027)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 18 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 18)

				if (18 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 18)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301027", "story_v_out_321301.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301027", "story_v_out_321301.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_321301", "321301027", "story_v_out_321301.awb")

						arg_109_1:RecordAudio("321301027", var_112_11)
						arg_109_1:RecordAudio("321301027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_321301", "321301027", "story_v_out_321301.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_321301", "321301027", "story_v_out_321301.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play321301028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321301028
		arg_113_1.duration_ = 7.07

		local var_113_0 = {
			zh = 7.066,
			ja = 5.833
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321301029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.75

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(321301028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 30 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 30)

				if (30 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 30)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301028", "story_v_out_321301.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301028", "story_v_out_321301.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_321301", "321301028", "story_v_out_321301.awb")

						arg_113_1:RecordAudio("321301028", var_116_6)
						arg_113_1:RecordAudio("321301028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321301", "321301028", "story_v_out_321301.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321301", "321301028", "story_v_out_321301.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play321301029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321301029
		arg_117_1.duration_ = 2.73

		local var_117_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321301030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1043ui_story"]) and arg_117_1.var_.characterEffect1043ui_story == nil then
				arg_117_1.var_.characterEffect1043ui_story = arg_117_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1043ui_story"]) then
				if arg_117_1.var_.characterEffect1043ui_story and not isNil(arg_117_1.actors_["1043ui_story"]) then
					arg_117_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1043ui_story"]) and arg_117_1.var_.characterEffect1043ui_story then
				arg_117_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["10131ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect10131ui_story == nil then
				arg_117_1.var_.characterEffect10131ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect10131ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect10131ui_story then
				arg_117_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_120_4 = 0
			local var_120_5 = 0.2

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(321301029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 8 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 8)

				if (8 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 8)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301029", "story_v_out_321301.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301029", "story_v_out_321301.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_321301", "321301029", "story_v_out_321301.awb")

						arg_117_1:RecordAudio("321301029", var_120_11)
						arg_117_1:RecordAudio("321301029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321301", "321301029", "story_v_out_321301.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321301", "321301029", "story_v_out_321301.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play321301030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321301030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play321301031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10131ui_story = arg_121_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).z)
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles = arg_121_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10131ui_story"].transform.position).z)
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10131ui_story"].transform.localEulerAngles = arg_121_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1043ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1043ui_story = var_124_1.localPosition
			end

			local var_124_2 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 then
				var_124_1.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_2)
				var_124_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_1.position).x, (manager.ui.mainCamera.transform.position - var_124_1.position).y, (manager.ui.mainCamera.transform.position - var_124_1.position).z)
				var_124_1.localEulerAngles.z = 0
				var_124_1.localEulerAngles.x = 0
				var_124_1.localEulerAngles = var_124_1.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 then
				var_124_1.localPosition = Vector3.New(0, 100, 0)
				var_124_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_1.position).x, (manager.ui.mainCamera.transform.position - var_124_1.position).y, (manager.ui.mainCamera.transform.position - var_124_1.position).z)
				var_124_1.localEulerAngles.z = 0
				var_124_1.localEulerAngles.x = 0
				var_124_1.localEulerAngles = var_124_1.localEulerAngles
			end

			local var_124_3 = arg_121_1.actors_["1043ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect1043ui_story == nil then
				arg_121_1.var_.characterEffect1043ui_story = var_124_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_4 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 and not isNil(var_124_3) then
				if arg_121_1.var_.characterEffect1043ui_story and not isNil(var_124_3) then
					arg_121_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_4)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect1043ui_story then
				arg_121_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_124_5 = 0
			local var_124_6 = 0.975

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(321301030).content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 39 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_7) / 39)

				if (39 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_7) / 39)) > 0 and var_124_6 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_10 and arg_121_1.time_ < var_124_5 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play321301031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321301031
		arg_125_1.duration_ = 6.4

		local var_125_0 = {
			zh = 6.4,
			ja = 5.566
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play321301032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1043ui_story"]) and arg_125_1.var_.characterEffect1043ui_story == nil then
				arg_125_1.var_.characterEffect1043ui_story = arg_125_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1043ui_story"]) then
				if arg_125_1.var_.characterEffect1043ui_story and not isNil(arg_125_1.actors_["1043ui_story"]) then
					arg_125_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1043ui_story"]) and arg_125_1.var_.characterEffect1043ui_story then
				arg_125_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["1043ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1043ui_story = var_128_2.localPosition
			end

			local var_128_3 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 then
				var_128_2.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_125_1.time_ - 0) / var_128_3)
				var_128_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_2.position).x, (manager.ui.mainCamera.transform.position - var_128_2.position).y, (manager.ui.mainCamera.transform.position - var_128_2.position).z)
				var_128_2.localEulerAngles.z = 0
				var_128_2.localEulerAngles.x = 0
				var_128_2.localEulerAngles = var_128_2.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 then
				var_128_2.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_128_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_2.position).x, (manager.ui.mainCamera.transform.position - var_128_2.position).y, (manager.ui.mainCamera.transform.position - var_128_2.position).z)
				var_128_2.localEulerAngles.z = 0
				var_128_2.localEulerAngles.x = 0
				var_128_2.localEulerAngles = var_128_2.localEulerAngles
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_128_4 = 0
			local var_128_5 = 0.725

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(321301031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 29 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 29)

				if (29 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 29)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301031", "story_v_out_321301.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301031", "story_v_out_321301.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_321301", "321301031", "story_v_out_321301.awb")

						arg_125_1:RecordAudio("321301031", var_128_11)
						arg_125_1:RecordAudio("321301031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321301", "321301031", "story_v_out_321301.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321301", "321301031", "story_v_out_321301.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play321301032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321301032
		arg_129_1.duration_ = 11.63

		local var_129_0 = {
			zh = 10.1,
			ja = 11.633
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play321301033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.9

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(321301032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 36 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 36)

				if (36 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 36)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301032", "story_v_out_321301.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301032", "story_v_out_321301.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_321301", "321301032", "story_v_out_321301.awb")

						arg_129_1:RecordAudio("321301032", var_132_6)
						arg_129_1:RecordAudio("321301032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_321301", "321301032", "story_v_out_321301.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_321301", "321301032", "story_v_out_321301.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321301033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321301033
		arg_133_1.duration_ = 10.2

		local var_133_0 = {
			zh = 8.666,
			ja = 10.2
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play321301034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_136_0 = 0
			local var_136_1 = 0.95

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(321301033)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 38 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 38)

				if (38 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 38)) > 0 and var_136_1 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301033", "story_v_out_321301.awb") ~= 0 then
					local var_136_6 = manager.audio:GetVoiceLength("story_v_out_321301", "321301033", "story_v_out_321301.awb") / 1000

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end

					if var_136_2.prefab_name ~= "" and arg_133_1.actors_[var_136_2.prefab_name] ~= nil then
						local var_136_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_2.prefab_name].transform, "story_v_out_321301", "321301033", "story_v_out_321301.awb")

						arg_133_1:RecordAudio("321301033", var_136_7)
						arg_133_1:RecordAudio("321301033", var_136_7)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321301", "321301033", "story_v_out_321301.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321301", "321301033", "story_v_out_321301.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321301034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321301034
		arg_137_1.duration_ = 14.6

		local var_137_0 = {
			zh = 8.1,
			ja = 14.6
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play321301035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.85

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(321301034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 34 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 34)

				if (34 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 34)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301034", "story_v_out_321301.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301034", "story_v_out_321301.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_321301", "321301034", "story_v_out_321301.awb")

						arg_137_1:RecordAudio("321301034", var_140_6)
						arg_137_1:RecordAudio("321301034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_321301", "321301034", "story_v_out_321301.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_321301", "321301034", "story_v_out_321301.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play321301035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321301035
		arg_141_1.duration_ = 20.67

		local var_141_0 = {
			zh = 16.066,
			ja = 20.666
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play321301036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_0 = 0
			local var_144_1 = 1.7

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(321301035)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 68 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 68)

				if (68 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 68)) > 0 and var_144_1 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301035", "story_v_out_321301.awb") ~= 0 then
					local var_144_6 = manager.audio:GetVoiceLength("story_v_out_321301", "321301035", "story_v_out_321301.awb") / 1000

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end

					if var_144_2.prefab_name ~= "" and arg_141_1.actors_[var_144_2.prefab_name] ~= nil then
						local var_144_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_2.prefab_name].transform, "story_v_out_321301", "321301035", "story_v_out_321301.awb")

						arg_141_1:RecordAudio("321301035", var_144_7)
						arg_141_1:RecordAudio("321301035", var_144_7)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_321301", "321301035", "story_v_out_321301.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_321301", "321301035", "story_v_out_321301.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play321301036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321301036
		arg_145_1.duration_ = 8.43

		local var_145_0 = {
			zh = 5.6,
			ja = 8.433
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play321301037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10131ui_story"]) and arg_145_1.var_.characterEffect10131ui_story == nil then
				arg_145_1.var_.characterEffect10131ui_story = arg_145_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10131ui_story"]) then
				if arg_145_1.var_.characterEffect10131ui_story and not isNil(arg_145_1.actors_["10131ui_story"]) then
					arg_145_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10131ui_story"]) and arg_145_1.var_.characterEffect10131ui_story then
				arg_145_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_148_2 = arg_145_1.actors_["1043ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1043ui_story == nil then
				arg_145_1.var_.characterEffect1043ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_3 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.characterEffect1043ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_3)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1043ui_story then
				arg_145_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_148_4 = arg_145_1.actors_["10131ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10131ui_story = var_148_4.localPosition
			end

			local var_148_5 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 then
				var_148_4.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10131ui_story, Vector3.New(-0.78, -0.96, -5.8), (arg_145_1.time_ - 0) / var_148_5)
				var_148_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_4.position).x, (manager.ui.mainCamera.transform.position - var_148_4.position).y, (manager.ui.mainCamera.transform.position - var_148_4.position).z)
				var_148_4.localEulerAngles.z = 0
				var_148_4.localEulerAngles.x = 0
				var_148_4.localEulerAngles = var_148_4.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 then
				var_148_4.localPosition = Vector3.New(-0.78, -0.96, -5.8)
				var_148_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_4.position).x, (manager.ui.mainCamera.transform.position - var_148_4.position).y, (manager.ui.mainCamera.transform.position - var_148_4.position).z)
				var_148_4.localEulerAngles.z = 0
				var_148_4.localEulerAngles.x = 0
				var_148_4.localEulerAngles = var_148_4.localEulerAngles
			end

			local var_148_6 = arg_145_1.actors_["1043ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1043ui_story = var_148_6.localPosition
			end

			local var_148_7 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				var_148_6.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_145_1.time_ - 0) / var_148_7)
				var_148_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_6.position).x, (manager.ui.mainCamera.transform.position - var_148_6.position).y, (manager.ui.mainCamera.transform.position - var_148_6.position).z)
				var_148_6.localEulerAngles.z = 0
				var_148_6.localEulerAngles.x = 0
				var_148_6.localEulerAngles = var_148_6.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				var_148_6.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_148_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_6.position).x, (manager.ui.mainCamera.transform.position - var_148_6.position).y, (manager.ui.mainCamera.transform.position - var_148_6.position).z)
				var_148_6.localEulerAngles.z = 0
				var_148_6.localEulerAngles.x = 0
				var_148_6.localEulerAngles = var_148_6.localEulerAngles
			end

			local var_148_8 = 0
			local var_148_9 = 0.675

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(321301036)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 27 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 27)

				if (27 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 27)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301036", "story_v_out_321301.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301036", "story_v_out_321301.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_321301", "321301036", "story_v_out_321301.awb")

						arg_145_1:RecordAudio("321301036", var_148_15)
						arg_145_1:RecordAudio("321301036", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_321301", "321301036", "story_v_out_321301.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_321301", "321301036", "story_v_out_321301.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play321301037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321301037
		arg_149_1.duration_ = 3.83

		local var_149_0 = {
			zh = 2.1,
			ja = 3.833
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play321301038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1043ui_story"]) and arg_149_1.var_.characterEffect1043ui_story == nil then
				arg_149_1.var_.characterEffect1043ui_story = arg_149_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1043ui_story"]) then
				if arg_149_1.var_.characterEffect1043ui_story and not isNil(arg_149_1.actors_["1043ui_story"]) then
					arg_149_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1043ui_story"]) and arg_149_1.var_.characterEffect1043ui_story then
				arg_149_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["10131ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10131ui_story == nil then
				arg_149_1.var_.characterEffect10131ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect10131ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10131ui_story then
				arg_149_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.275

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(321301037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 11 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 11)

				if (11 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 11)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301037", "story_v_out_321301.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301037", "story_v_out_321301.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_321301", "321301037", "story_v_out_321301.awb")

						arg_149_1:RecordAudio("321301037", var_152_11)
						arg_149_1:RecordAudio("321301037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_321301", "321301037", "story_v_out_321301.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_321301", "321301037", "story_v_out_321301.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play321301038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321301038
		arg_153_1.duration_ = 7.57

		local var_153_0 = {
			zh = 5.866,
			ja = 7.566
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play321301039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10131ui_story"]) and arg_153_1.var_.characterEffect10131ui_story == nil then
				arg_153_1.var_.characterEffect10131ui_story = arg_153_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10131ui_story"]) then
				if arg_153_1.var_.characterEffect10131ui_story and not isNil(arg_153_1.actors_["10131ui_story"]) then
					arg_153_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10131ui_story"]) and arg_153_1.var_.characterEffect10131ui_story then
				arg_153_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["1043ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1043ui_story == nil then
				arg_153_1.var_.characterEffect1043ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1043ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1043ui_story then
				arg_153_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_156_4 = 0
			local var_156_5 = 0.75

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(321301038)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 30 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 30)

				if (30 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 30)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301038", "story_v_out_321301.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301038", "story_v_out_321301.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_321301", "321301038", "story_v_out_321301.awb")

						arg_153_1:RecordAudio("321301038", var_156_11)
						arg_153_1:RecordAudio("321301038", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_321301", "321301038", "story_v_out_321301.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_321301", "321301038", "story_v_out_321301.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play321301039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321301039
		arg_157_1.duration_ = 10

		local var_157_0 = {
			zh = 8.4,
			ja = 10
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play321301040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1043ui_story"]) and arg_157_1.var_.characterEffect1043ui_story == nil then
				arg_157_1.var_.characterEffect1043ui_story = arg_157_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1043ui_story"]) then
				if arg_157_1.var_.characterEffect1043ui_story and not isNil(arg_157_1.actors_["1043ui_story"]) then
					arg_157_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1043ui_story"]) and arg_157_1.var_.characterEffect1043ui_story then
				arg_157_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_160_2 = arg_157_1.actors_["10131ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect10131ui_story == nil then
				arg_157_1.var_.characterEffect10131ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.characterEffect10131ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_3)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect10131ui_story then
				arg_157_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_160_4 = 0
			local var_160_5 = 1.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(321301039)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 44 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 44)

				if (44 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 44)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301039", "story_v_out_321301.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301039", "story_v_out_321301.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_321301", "321301039", "story_v_out_321301.awb")

						arg_157_1:RecordAudio("321301039", var_160_11)
						arg_157_1:RecordAudio("321301039", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321301", "321301039", "story_v_out_321301.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321301", "321301039", "story_v_out_321301.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play321301040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321301040
		arg_161_1.duration_ = 3.67

		local var_161_0 = {
			zh = 3.666,
			ja = 3.433
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play321301041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10131ui_story"]) and arg_161_1.var_.characterEffect10131ui_story == nil then
				arg_161_1.var_.characterEffect10131ui_story = arg_161_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10131ui_story"]) then
				if arg_161_1.var_.characterEffect10131ui_story and not isNil(arg_161_1.actors_["10131ui_story"]) then
					arg_161_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10131ui_story"]) and arg_161_1.var_.characterEffect10131ui_story then
				arg_161_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_164_2 = arg_161_1.actors_["1043ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1043ui_story == nil then
				arg_161_1.var_.characterEffect1043ui_story = var_164_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.characterEffect1043ui_story and not isNil(var_164_2) then
					arg_161_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_3)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1043ui_story then
				arg_161_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_164_4 = 0
			local var_164_5 = 0.375

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(321301040)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 15 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 15)

				if (15 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 15)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301040", "story_v_out_321301.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301040", "story_v_out_321301.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_out_321301", "321301040", "story_v_out_321301.awb")

						arg_161_1:RecordAudio("321301040", var_164_11)
						arg_161_1:RecordAudio("321301040", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321301", "321301040", "story_v_out_321301.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321301", "321301040", "story_v_out_321301.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play321301041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321301041
		arg_165_1.duration_ = 3.83

		local var_165_0 = {
			zh = 3.833,
			ja = 3.8
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play321301042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1043ui_story"]) and arg_165_1.var_.characterEffect1043ui_story == nil then
				arg_165_1.var_.characterEffect1043ui_story = arg_165_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1043ui_story"]) then
				if arg_165_1.var_.characterEffect1043ui_story and not isNil(arg_165_1.actors_["1043ui_story"]) then
					arg_165_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1043ui_story"]) and arg_165_1.var_.characterEffect1043ui_story then
				arg_165_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_168_2 = arg_165_1.actors_["10131ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect10131ui_story == nil then
				arg_165_1.var_.characterEffect10131ui_story = var_168_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_3 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.characterEffect10131ui_story and not isNil(var_168_2) then
					arg_165_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_3)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect10131ui_story then
				arg_165_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_168_4 = 0
			local var_168_5 = 0.45

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(321301041)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 18 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 18)

				if (18 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 18)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301041", "story_v_out_321301.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301041", "story_v_out_321301.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_321301", "321301041", "story_v_out_321301.awb")

						arg_165_1:RecordAudio("321301041", var_168_11)
						arg_165_1:RecordAudio("321301041", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_321301", "321301041", "story_v_out_321301.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_321301", "321301041", "story_v_out_321301.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play321301042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321301042
		arg_169_1.duration_ = 6.3

		local var_169_0 = {
			zh = 6.3,
			ja = 6.133
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play321301043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["10131ui_story"]) and arg_169_1.var_.characterEffect10131ui_story == nil then
				arg_169_1.var_.characterEffect10131ui_story = arg_169_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["10131ui_story"]) then
				if arg_169_1.var_.characterEffect10131ui_story and not isNil(arg_169_1.actors_["10131ui_story"]) then
					arg_169_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["10131ui_story"]) and arg_169_1.var_.characterEffect10131ui_story then
				arg_169_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_172_2 = arg_169_1.actors_["1043ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1043ui_story == nil then
				arg_169_1.var_.characterEffect1043ui_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.characterEffect1043ui_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_3)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1043ui_story then
				arg_169_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_172_4 = 0
			local var_172_5 = 0.575

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(321301042)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 23 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 23)

				if (23 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 23)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301042", "story_v_out_321301.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301042", "story_v_out_321301.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_321301", "321301042", "story_v_out_321301.awb")

						arg_169_1:RecordAudio("321301042", var_172_11)
						arg_169_1:RecordAudio("321301042", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321301", "321301042", "story_v_out_321301.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321301", "321301042", "story_v_out_321301.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play321301043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321301043
		arg_173_1.duration_ = 5.17

		local var_173_0 = {
			zh = 3.8,
			ja = 5.166
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play321301044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.475

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(321301043)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 19 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 19)

				if (19 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 19)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301043", "story_v_out_321301.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301043", "story_v_out_321301.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_out_321301", "321301043", "story_v_out_321301.awb")

						arg_173_1:RecordAudio("321301043", var_176_6)
						arg_173_1:RecordAudio("321301043", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321301", "321301043", "story_v_out_321301.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321301", "321301043", "story_v_out_321301.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play321301044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321301044
		arg_177_1.duration_ = 3.33

		local var_177_0 = {
			zh = 1.6,
			ja = 3.333
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play321301045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1043ui_story"]) and arg_177_1.var_.characterEffect1043ui_story == nil then
				arg_177_1.var_.characterEffect1043ui_story = arg_177_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1043ui_story"]) then
				if arg_177_1.var_.characterEffect1043ui_story and not isNil(arg_177_1.actors_["1043ui_story"]) then
					arg_177_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1043ui_story"]) and arg_177_1.var_.characterEffect1043ui_story then
				arg_177_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["10131ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect10131ui_story == nil then
				arg_177_1.var_.characterEffect10131ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect10131ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect10131ui_story then
				arg_177_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_180_4 = 0
			local var_180_5 = 0.225

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(321301044)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 9 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 9)

				if (9 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 9)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301044", "story_v_out_321301.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301044", "story_v_out_321301.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_321301", "321301044", "story_v_out_321301.awb")

						arg_177_1:RecordAudio("321301044", var_180_11)
						arg_177_1:RecordAudio("321301044", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_321301", "321301044", "story_v_out_321301.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_321301", "321301044", "story_v_out_321301.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play321301045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321301045
		arg_181_1.duration_ = 3.5

		local var_181_0 = {
			zh = 3.5,
			ja = 3.433
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play321301046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10131ui_story"]) and arg_181_1.var_.characterEffect10131ui_story == nil then
				arg_181_1.var_.characterEffect10131ui_story = arg_181_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10131ui_story"]) then
				if arg_181_1.var_.characterEffect10131ui_story and not isNil(arg_181_1.actors_["10131ui_story"]) then
					arg_181_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10131ui_story"]) and arg_181_1.var_.characterEffect10131ui_story then
				arg_181_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_184_2 = arg_181_1.actors_["1043ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1043ui_story == nil then
				arg_181_1.var_.characterEffect1043ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect1043ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect1043ui_story then
				arg_181_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_184_4 = 0
			local var_184_5 = 0.325

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(321301045)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 13 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 13)

				if (13 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 13)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301045", "story_v_out_321301.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301045", "story_v_out_321301.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_321301", "321301045", "story_v_out_321301.awb")

						arg_181_1:RecordAudio("321301045", var_184_11)
						arg_181_1:RecordAudio("321301045", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321301", "321301045", "story_v_out_321301.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321301", "321301045", "story_v_out_321301.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play321301046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321301046
		arg_185_1.duration_ = 9

		local var_185_0 = {
			zh = 8.333,
			ja = 9
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321301047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.85

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(321301046)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 34 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 34)

				if (34 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 34)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301046", "story_v_out_321301.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301046", "story_v_out_321301.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_321301", "321301046", "story_v_out_321301.awb")

						arg_185_1:RecordAudio("321301046", var_188_6)
						arg_185_1:RecordAudio("321301046", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_321301", "321301046", "story_v_out_321301.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_321301", "321301046", "story_v_out_321301.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play321301047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321301047
		arg_189_1.duration_ = 2

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play321301048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1043ui_story"]) and arg_189_1.var_.characterEffect1043ui_story == nil then
				arg_189_1.var_.characterEffect1043ui_story = arg_189_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1043ui_story"]) then
				if arg_189_1.var_.characterEffect1043ui_story and not isNil(arg_189_1.actors_["1043ui_story"]) then
					arg_189_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1043ui_story"]) and arg_189_1.var_.characterEffect1043ui_story then
				arg_189_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["10131ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect10131ui_story == nil then
				arg_189_1.var_.characterEffect10131ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect10131ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect10131ui_story then
				arg_189_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_192_4 = 0
			local var_192_5 = 0.15

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(321301047)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 6 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 6)

				if (6 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 6)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301047", "story_v_out_321301.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301047", "story_v_out_321301.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_321301", "321301047", "story_v_out_321301.awb")

						arg_189_1:RecordAudio("321301047", var_192_11)
						arg_189_1:RecordAudio("321301047", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321301", "321301047", "story_v_out_321301.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321301", "321301047", "story_v_out_321301.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play321301048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321301048
		arg_193_1.duration_ = 4

		local var_193_0 = {
			zh = 4,
			ja = 3.633
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play321301049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10131ui_story"]) and arg_193_1.var_.characterEffect10131ui_story == nil then
				arg_193_1.var_.characterEffect10131ui_story = arg_193_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10131ui_story"]) then
				if arg_193_1.var_.characterEffect10131ui_story and not isNil(arg_193_1.actors_["10131ui_story"]) then
					arg_193_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10131ui_story"]) and arg_193_1.var_.characterEffect10131ui_story then
				arg_193_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_196_2 = arg_193_1.actors_["1043ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1043ui_story == nil then
				arg_193_1.var_.characterEffect1043ui_story = var_196_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_3 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.characterEffect1043ui_story and not isNil(var_196_2) then
					arg_193_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_3)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1043ui_story then
				arg_193_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_196_4 = 0
			local var_196_5 = 0.375

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(321301048)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 15 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 15)

				if (15 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 15)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301048", "story_v_out_321301.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301048", "story_v_out_321301.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_321301", "321301048", "story_v_out_321301.awb")

						arg_193_1:RecordAudio("321301048", var_196_11)
						arg_193_1:RecordAudio("321301048", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321301", "321301048", "story_v_out_321301.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321301", "321301048", "story_v_out_321301.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play321301049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321301049
		arg_197_1.duration_ = 9.73

		local var_197_0 = {
			zh = 7.533,
			ja = 9.733
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play321301050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1043ui_story"]) and arg_197_1.var_.characterEffect1043ui_story == nil then
				arg_197_1.var_.characterEffect1043ui_story = arg_197_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1043ui_story"]) then
				if arg_197_1.var_.characterEffect1043ui_story and not isNil(arg_197_1.actors_["1043ui_story"]) then
					arg_197_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1043ui_story"]) and arg_197_1.var_.characterEffect1043ui_story then
				arg_197_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_200_2 = arg_197_1.actors_["10131ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect10131ui_story == nil then
				arg_197_1.var_.characterEffect10131ui_story = var_200_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.characterEffect10131ui_story and not isNil(var_200_2) then
					arg_197_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_3)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect10131ui_story then
				arg_197_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_200_4 = 0
			local var_200_5 = 0.7

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(321301049)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 28 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 28)

				if (28 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 28)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301049", "story_v_out_321301.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301049", "story_v_out_321301.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_out_321301", "321301049", "story_v_out_321301.awb")

						arg_197_1:RecordAudio("321301049", var_200_11)
						arg_197_1:RecordAudio("321301049", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321301", "321301049", "story_v_out_321301.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321301", "321301049", "story_v_out_321301.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_12 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_12 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_12

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_12 and arg_197_1.time_ < var_200_4 + var_200_12 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play321301050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321301050
		arg_201_1.duration_ = 8.9

		local var_201_0 = {
			zh = 6.466,
			ja = 8.9
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play321301051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10131ui_story"]) and arg_201_1.var_.characterEffect10131ui_story == nil then
				arg_201_1.var_.characterEffect10131ui_story = arg_201_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10131ui_story"]) then
				if arg_201_1.var_.characterEffect10131ui_story and not isNil(arg_201_1.actors_["10131ui_story"]) then
					arg_201_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10131ui_story"]) and arg_201_1.var_.characterEffect10131ui_story then
				arg_201_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_204_2 = arg_201_1.actors_["1043ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1043ui_story == nil then
				arg_201_1.var_.characterEffect1043ui_story = var_204_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_3 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.characterEffect1043ui_story and not isNil(var_204_2) then
					arg_201_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_3)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1043ui_story then
				arg_201_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_204_4 = 0
			local var_204_5 = 0.7

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(321301050)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 28 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 28)

				if (28 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 28)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301050", "story_v_out_321301.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301050", "story_v_out_321301.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_out_321301", "321301050", "story_v_out_321301.awb")

						arg_201_1:RecordAudio("321301050", var_204_11)
						arg_201_1:RecordAudio("321301050", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321301", "321301050", "story_v_out_321301.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321301", "321301050", "story_v_out_321301.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play321301051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321301051
		arg_205_1.duration_ = 2

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play321301052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1043ui_story"]) and arg_205_1.var_.characterEffect1043ui_story == nil then
				arg_205_1.var_.characterEffect1043ui_story = arg_205_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1043ui_story"]) then
				if arg_205_1.var_.characterEffect1043ui_story and not isNil(arg_205_1.actors_["1043ui_story"]) then
					arg_205_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1043ui_story"]) and arg_205_1.var_.characterEffect1043ui_story then
				arg_205_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_208_2 = arg_205_1.actors_["10131ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10131ui_story == nil then
				arg_205_1.var_.characterEffect10131ui_story = var_208_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_3 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.characterEffect10131ui_story and not isNil(var_208_2) then
					arg_205_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_3)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10131ui_story then
				arg_205_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action5_2")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_208_4 = 0
			local var_208_5 = 0.05

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(321301051)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 2 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 2)

				if (2 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 2)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301051", "story_v_out_321301.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301051", "story_v_out_321301.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_out_321301", "321301051", "story_v_out_321301.awb")

						arg_205_1:RecordAudio("321301051", var_208_11)
						arg_205_1:RecordAudio("321301051", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_321301", "321301051", "story_v_out_321301.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_321301", "321301051", "story_v_out_321301.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play321301052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321301052
		arg_209_1.duration_ = 2.2

		local var_209_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321301053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10131ui_story"]) and arg_209_1.var_.characterEffect10131ui_story == nil then
				arg_209_1.var_.characterEffect10131ui_story = arg_209_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10131ui_story"]) then
				if arg_209_1.var_.characterEffect10131ui_story and not isNil(arg_209_1.actors_["10131ui_story"]) then
					arg_209_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10131ui_story"]) and arg_209_1.var_.characterEffect10131ui_story then
				arg_209_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_212_2 = arg_209_1.actors_["1043ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect1043ui_story == nil then
				arg_209_1.var_.characterEffect1043ui_story = var_212_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_3 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.characterEffect1043ui_story and not isNil(var_212_2) then
					arg_209_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_3)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect1043ui_story then
				arg_209_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131actionlink/10131action486")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_212_4 = 0
			local var_212_5 = 0.15

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(321301052)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 6 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 6)

				if (6 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 6)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301052", "story_v_out_321301.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301052", "story_v_out_321301.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_321301", "321301052", "story_v_out_321301.awb")

						arg_209_1:RecordAudio("321301052", var_212_11)
						arg_209_1:RecordAudio("321301052", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321301", "321301052", "story_v_out_321301.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321301", "321301052", "story_v_out_321301.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321301053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321301053
		arg_213_1.duration_ = 15.13

		local var_213_0 = {
			zh = 8.933,
			ja = 15.133
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play321301054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1043ui_story"]) and arg_213_1.var_.characterEffect1043ui_story == nil then
				arg_213_1.var_.characterEffect1043ui_story = arg_213_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1043ui_story"]) then
				if arg_213_1.var_.characterEffect1043ui_story and not isNil(arg_213_1.actors_["1043ui_story"]) then
					arg_213_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1043ui_story"]) and arg_213_1.var_.characterEffect1043ui_story then
				arg_213_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_216_2 = arg_213_1.actors_["10131ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect10131ui_story == nil then
				arg_213_1.var_.characterEffect10131ui_story = var_216_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_3 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.characterEffect10131ui_story and not isNil(var_216_2) then
					arg_213_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_3)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.characterEffect10131ui_story then
				arg_213_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_216_4 = 0
			local var_216_5 = 1.05

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(321301053)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 42 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 42)

				if (42 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 42)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301053", "story_v_out_321301.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301053", "story_v_out_321301.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_321301", "321301053", "story_v_out_321301.awb")

						arg_213_1:RecordAudio("321301053", var_216_11)
						arg_213_1:RecordAudio("321301053", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321301", "321301053", "story_v_out_321301.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321301", "321301053", "story_v_out_321301.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play321301054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321301054
		arg_217_1.duration_ = 4.87

		local var_217_0 = {
			zh = 4.3,
			ja = 4.866
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play321301055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.525

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(321301054)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)

				if (21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301054", "story_v_out_321301.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301054", "story_v_out_321301.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_321301", "321301054", "story_v_out_321301.awb")

						arg_217_1:RecordAudio("321301054", var_220_6)
						arg_217_1:RecordAudio("321301054", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321301", "321301054", "story_v_out_321301.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321301", "321301054", "story_v_out_321301.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play321301055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321301055
		arg_221_1.duration_ = 5.7

		local var_221_0 = {
			zh = 5,
			ja = 5.7
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play321301056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_224_0 = 0
			local var_224_1 = 0.525

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_2 = arg_221_1:GetWordFromCfg(321301055)
				local var_224_3 = arg_221_1:FormatText(var_224_2.content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 21 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_3) / 21)

				if (21 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_3) / 21)) > 0 and var_224_1 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301055", "story_v_out_321301.awb") ~= 0 then
					local var_224_6 = manager.audio:GetVoiceLength("story_v_out_321301", "321301055", "story_v_out_321301.awb") / 1000

					if var_224_6 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_0
					end

					if var_224_2.prefab_name ~= "" and arg_221_1.actors_[var_224_2.prefab_name] ~= nil then
						local var_224_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_2.prefab_name].transform, "story_v_out_321301", "321301055", "story_v_out_321301.awb")

						arg_221_1:RecordAudio("321301055", var_224_7)
						arg_221_1:RecordAudio("321301055", var_224_7)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321301", "321301055", "story_v_out_321301.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321301", "321301055", "story_v_out_321301.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play321301056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321301056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play321301057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10131ui_story = arg_225_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).z)
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles = arg_225_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10131ui_story"].transform.position).z)
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10131ui_story"].transform.localEulerAngles = arg_225_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1043ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1043ui_story = var_228_1.localPosition
			end

			local var_228_2 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 then
				var_228_1.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_2)
				var_228_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_1.position).x, (manager.ui.mainCamera.transform.position - var_228_1.position).y, (manager.ui.mainCamera.transform.position - var_228_1.position).z)
				var_228_1.localEulerAngles.z = 0
				var_228_1.localEulerAngles.x = 0
				var_228_1.localEulerAngles = var_228_1.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 then
				var_228_1.localPosition = Vector3.New(0, 100, 0)
				var_228_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_1.position).x, (manager.ui.mainCamera.transform.position - var_228_1.position).y, (manager.ui.mainCamera.transform.position - var_228_1.position).z)
				var_228_1.localEulerAngles.z = 0
				var_228_1.localEulerAngles.x = 0
				var_228_1.localEulerAngles = var_228_1.localEulerAngles
			end

			local var_228_3 = arg_225_1.actors_["1043ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_3) and arg_225_1.var_.characterEffect1043ui_story == nil then
				arg_225_1.var_.characterEffect1043ui_story = var_228_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_4 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 and not isNil(var_228_3) then
				if arg_225_1.var_.characterEffect1043ui_story and not isNil(var_228_3) then
					arg_225_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_4)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 and not isNil(var_228_3) and arg_225_1.var_.characterEffect1043ui_story then
				arg_225_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0.366666666666667 < arg_225_1.time_ and arg_225_1.time_ <= 0.366666666666667 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_walk03", "")
			end

			local var_228_6 = 0
			local var_228_7 = 0.85

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(321301056).content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 34 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_8) / 34)

				if (34 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_8) / 34)) > 0 and var_228_7 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_11 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_11 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_11

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_11 and arg_225_1.time_ < var_228_6 + var_228_11 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play321301057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 321301057
		arg_229_1.duration_ = 2.07

		local var_229_0 = {
			zh = 2.066,
			ja = 1.999999999999
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play321301058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1111ui_story = arg_229_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1111ui_story"].transform.position).z)
				arg_229_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1111ui_story"].transform.localEulerAngles = arg_229_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_229_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1111ui_story"].transform.position).z)
				arg_229_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1111ui_story"].transform.localEulerAngles = arg_229_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1111ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1111ui_story == nil then
				arg_229_1.var_.characterEffect1111ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1111ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1111ui_story then
				arg_229_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_232_4 = 0
			local var_232_5 = 0.2

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(321301057)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 8 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 8)

				if (8 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 8)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301057", "story_v_out_321301.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301057", "story_v_out_321301.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_321301", "321301057", "story_v_out_321301.awb")

						arg_229_1:RecordAudio("321301057", var_232_11)
						arg_229_1:RecordAudio("321301057", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_321301", "321301057", "story_v_out_321301.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_321301", "321301057", "story_v_out_321301.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play321301058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 321301058
		arg_233_1.duration_ = 6.93

		local var_233_0 = {
			zh = 3.566,
			ja = 6.933
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play321301059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1111ui_story"]) and arg_233_1.var_.characterEffect1111ui_story == nil then
				arg_233_1.var_.characterEffect1111ui_story = arg_233_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1111ui_story"]) then
				if arg_233_1.var_.characterEffect1111ui_story and not isNil(arg_233_1.actors_["1111ui_story"]) then
					arg_233_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1111ui_story"]) and arg_233_1.var_.characterEffect1111ui_story then
				arg_233_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.35

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(321301058)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_6 = 14 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_4) / 14)

				if (14 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_4) / 14)) > 0 and var_236_2 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301058", "story_v_out_321301.awb") ~= 0 then
					local var_236_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301058", "story_v_out_321301.awb") / 1000

					if var_236_7 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_1
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_321301", "321301058", "story_v_out_321301.awb")

						arg_233_1:RecordAudio("321301058", var_236_8)
						arg_233_1:RecordAudio("321301058", var_236_8)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_321301", "321301058", "story_v_out_321301.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_321301", "321301058", "story_v_out_321301.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_9 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_9 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_9

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_9 and arg_233_1.time_ < var_236_1 + var_236_9 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play321301059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 321301059
		arg_237_1.duration_ = 4.4

		local var_237_0 = {
			zh = 4.4,
			ja = 3.7
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play321301060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.425

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_1 = arg_237_1:GetWordFromCfg(321301059)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 17 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 17)

				if (17 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 17)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301059", "story_v_out_321301.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301059", "story_v_out_321301.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_321301", "321301059", "story_v_out_321301.awb")

						arg_237_1:RecordAudio("321301059", var_240_6)
						arg_237_1:RecordAudio("321301059", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_321301", "321301059", "story_v_out_321301.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_321301", "321301059", "story_v_out_321301.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play321301060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 321301060
		arg_241_1.duration_ = 8.83

		local var_241_0 = {
			zh = 8.833,
			ja = 7.633
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play321301061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1111ui_story"]) and arg_241_1.var_.characterEffect1111ui_story == nil then
				arg_241_1.var_.characterEffect1111ui_story = arg_241_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1111ui_story"]) then
				if arg_241_1.var_.characterEffect1111ui_story and not isNil(arg_241_1.actors_["1111ui_story"]) then
					arg_241_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1111ui_story"]) and arg_241_1.var_.characterEffect1111ui_story then
				arg_241_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_244_2 = arg_241_1.actors_["1043ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1043ui_story == nil then
				arg_241_1.var_.characterEffect1043ui_story = var_244_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_3 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.characterEffect1043ui_story and not isNil(var_244_2) then
					arg_241_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_3)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1043ui_story then
				arg_241_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_244_4 = 0
			local var_244_5 = 0.85

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(321301060)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 34 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 34)

				if (34 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 34)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301060", "story_v_out_321301.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301060", "story_v_out_321301.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_321301", "321301060", "story_v_out_321301.awb")

						arg_241_1:RecordAudio("321301060", var_244_11)
						arg_241_1:RecordAudio("321301060", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_321301", "321301060", "story_v_out_321301.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_321301", "321301060", "story_v_out_321301.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play321301061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 321301061
		arg_245_1.duration_ = 1.77

		local var_245_0 = {
			zh = 1.1,
			ja = 1.766
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play321301062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1043ui_story"]) and arg_245_1.var_.characterEffect1043ui_story == nil then
				arg_245_1.var_.characterEffect1043ui_story = arg_245_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1043ui_story"]) then
				if arg_245_1.var_.characterEffect1043ui_story and not isNil(arg_245_1.actors_["1043ui_story"]) then
					arg_245_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1043ui_story"]) and arg_245_1.var_.characterEffect1043ui_story then
				arg_245_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_248_2 = arg_245_1.actors_["1111ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect1111ui_story == nil then
				arg_245_1.var_.characterEffect1111ui_story = var_248_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_3 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_3 and not isNil(var_248_2) then
				if arg_245_1.var_.characterEffect1111ui_story and not isNil(var_248_2) then
					arg_245_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_3)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_3 and arg_245_1.time_ < 0 + var_248_3 + arg_248_0 and not isNil(var_248_2) and arg_245_1.var_.characterEffect1111ui_story then
				arg_245_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_248_4 = 0
			local var_248_5 = 0.15

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1043")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_6 = arg_245_1:GetWordFromCfg(321301061)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 6 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 6)

				if (6 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 6)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301061", "story_v_out_321301.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301061", "story_v_out_321301.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_321301", "321301061", "story_v_out_321301.awb")

						arg_245_1:RecordAudio("321301061", var_248_11)
						arg_245_1:RecordAudio("321301061", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_321301", "321301061", "story_v_out_321301.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_321301", "321301061", "story_v_out_321301.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play321301062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 321301062
		arg_249_1.duration_ = 1.47

		local var_249_0 = {
			zh = 1.3,
			ja = 1.466
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play321301063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1111ui_story"]) and arg_249_1.var_.characterEffect1111ui_story == nil then
				arg_249_1.var_.characterEffect1111ui_story = arg_249_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1111ui_story"]) then
				if arg_249_1.var_.characterEffect1111ui_story and not isNil(arg_249_1.actors_["1111ui_story"]) then
					arg_249_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1111ui_story"]) and arg_249_1.var_.characterEffect1111ui_story then
				arg_249_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_252_2 = arg_249_1.actors_["1043ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1043ui_story == nil then
				arg_249_1.var_.characterEffect1043ui_story = var_252_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_3 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.characterEffect1043ui_story and not isNil(var_252_2) then
					arg_249_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_3)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1043ui_story then
				arg_249_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_252_4 = 0
			local var_252_5 = 0.075

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(321301062)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 3 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 3)

				if (3 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 3)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301062", "story_v_out_321301.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301062", "story_v_out_321301.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_321301", "321301062", "story_v_out_321301.awb")

						arg_249_1:RecordAudio("321301062", var_252_11)
						arg_249_1:RecordAudio("321301062", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_321301", "321301062", "story_v_out_321301.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_321301", "321301062", "story_v_out_321301.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play321301063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 321301063
		arg_253_1.duration_ = 2

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play321301064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1043ui_story"]) and arg_253_1.var_.characterEffect1043ui_story == nil then
				arg_253_1.var_.characterEffect1043ui_story = arg_253_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1043ui_story"]) then
				if arg_253_1.var_.characterEffect1043ui_story and not isNil(arg_253_1.actors_["1043ui_story"]) then
					arg_253_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1043ui_story"]) and arg_253_1.var_.characterEffect1043ui_story then
				arg_253_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_256_2 = arg_253_1.actors_["1111ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1111ui_story == nil then
				arg_253_1.var_.characterEffect1111ui_story = var_256_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_3 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.characterEffect1111ui_story and not isNil(var_256_2) then
					arg_253_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_3)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1111ui_story then
				arg_253_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_256_4 = arg_253_1.actors_["1043ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1043ui_story = var_256_4.localPosition
			end

			local var_256_5 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 then
				var_256_4.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_253_1.time_ - 0) / var_256_5)
				var_256_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_4.position).x, (manager.ui.mainCamera.transform.position - var_256_4.position).y, (manager.ui.mainCamera.transform.position - var_256_4.position).z)
				var_256_4.localEulerAngles.z = 0
				var_256_4.localEulerAngles.x = 0
				var_256_4.localEulerAngles = var_256_4.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 then
				var_256_4.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_256_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_4.position).x, (manager.ui.mainCamera.transform.position - var_256_4.position).y, (manager.ui.mainCamera.transform.position - var_256_4.position).z)
				var_256_4.localEulerAngles.z = 0
				var_256_4.localEulerAngles.x = 0
				var_256_4.localEulerAngles = var_256_4.localEulerAngles
			end

			local var_256_6 = arg_253_1.actors_["1111ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1111ui_story = var_256_6.localPosition
			end

			local var_256_7 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				var_256_6.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_253_1.time_ - 0) / var_256_7)
				var_256_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_6.position).x, (manager.ui.mainCamera.transform.position - var_256_6.position).y, (manager.ui.mainCamera.transform.position - var_256_6.position).z)
				var_256_6.localEulerAngles.z = 0
				var_256_6.localEulerAngles.x = 0
				var_256_6.localEulerAngles = var_256_6.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				var_256_6.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_256_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_6.position).x, (manager.ui.mainCamera.transform.position - var_256_6.position).y, (manager.ui.mainCamera.transform.position - var_256_6.position).z)
				var_256_6.localEulerAngles.z = 0
				var_256_6.localEulerAngles.x = 0
				var_256_6.localEulerAngles = var_256_6.localEulerAngles
			end

			local var_256_8 = 0
			local var_256_9 = 0.075

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(321301063)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 3 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 3)

				if (3 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 3)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301063", "story_v_out_321301.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301063", "story_v_out_321301.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_321301", "321301063", "story_v_out_321301.awb")

						arg_253_1:RecordAudio("321301063", var_256_15)
						arg_253_1:RecordAudio("321301063", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_321301", "321301063", "story_v_out_321301.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_321301", "321301063", "story_v_out_321301.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play321301064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 321301064
		arg_257_1.duration_ = 3.63

		local var_257_0 = {
			zh = 2.8,
			ja = 3.633
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play321301065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1111ui_story"]) and arg_257_1.var_.characterEffect1111ui_story == nil then
				arg_257_1.var_.characterEffect1111ui_story = arg_257_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1111ui_story"]) then
				if arg_257_1.var_.characterEffect1111ui_story and not isNil(arg_257_1.actors_["1111ui_story"]) then
					arg_257_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1111ui_story"]) and arg_257_1.var_.characterEffect1111ui_story then
				arg_257_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_260_2 = arg_257_1.actors_["1043ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1043ui_story == nil then
				arg_257_1.var_.characterEffect1043ui_story = var_260_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_3 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.characterEffect1043ui_story and not isNil(var_260_2) then
					arg_257_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_3)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1043ui_story then
				arg_257_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_260_4 = 0
			local var_260_5 = 0.3

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(321301064)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 12 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 12)

				if (12 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 12)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301064", "story_v_out_321301.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301064", "story_v_out_321301.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_321301", "321301064", "story_v_out_321301.awb")

						arg_257_1:RecordAudio("321301064", var_260_11)
						arg_257_1:RecordAudio("321301064", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_321301", "321301064", "story_v_out_321301.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_321301", "321301064", "story_v_out_321301.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play321301065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 321301065
		arg_261_1.duration_ = 2.2

		local var_261_0 = {
			zh = 1.1,
			ja = 2.2
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play321301066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1043ui_story"]) and arg_261_1.var_.characterEffect1043ui_story == nil then
				arg_261_1.var_.characterEffect1043ui_story = arg_261_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1043ui_story"]) then
				if arg_261_1.var_.characterEffect1043ui_story and not isNil(arg_261_1.actors_["1043ui_story"]) then
					arg_261_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1043ui_story"]) and arg_261_1.var_.characterEffect1043ui_story then
				arg_261_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_264_2 = arg_261_1.actors_["1111ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.characterEffect1111ui_story == nil then
				arg_261_1.var_.characterEffect1111ui_story = var_264_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_3 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.characterEffect1111ui_story and not isNil(var_264_2) then
					arg_261_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_3)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.characterEffect1111ui_story then
				arg_261_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_264_4 = 0
			local var_264_5 = 0.125

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(321301065)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 5 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 5)

				if (5 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 5)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301065", "story_v_out_321301.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301065", "story_v_out_321301.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_321301", "321301065", "story_v_out_321301.awb")

						arg_261_1:RecordAudio("321301065", var_264_11)
						arg_261_1:RecordAudio("321301065", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_321301", "321301065", "story_v_out_321301.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_321301", "321301065", "story_v_out_321301.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play321301066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 321301066
		arg_265_1.duration_ = 6.43

		local var_265_0 = {
			zh = 6.433,
			ja = 5.366
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play321301067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1111ui_story"]) and arg_265_1.var_.characterEffect1111ui_story == nil then
				arg_265_1.var_.characterEffect1111ui_story = arg_265_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1111ui_story"]) then
				if arg_265_1.var_.characterEffect1111ui_story and not isNil(arg_265_1.actors_["1111ui_story"]) then
					arg_265_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1111ui_story"]) and arg_265_1.var_.characterEffect1111ui_story then
				arg_265_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_268_2 = arg_265_1.actors_["1043ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1043ui_story == nil then
				arg_265_1.var_.characterEffect1043ui_story = var_268_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_3 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.characterEffect1043ui_story and not isNil(var_268_2) then
					arg_265_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_3)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1043ui_story then
				arg_265_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_268_4 = 0
			local var_268_5 = 0.825

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(321301066)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 33 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 33)

				if (33 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 33)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301066", "story_v_out_321301.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301066", "story_v_out_321301.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_321301", "321301066", "story_v_out_321301.awb")

						arg_265_1:RecordAudio("321301066", var_268_11)
						arg_265_1:RecordAudio("321301066", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_321301", "321301066", "story_v_out_321301.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_321301", "321301066", "story_v_out_321301.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play321301067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 321301067
		arg_269_1.duration_ = 4.23

		local var_269_0 = {
			zh = 1,
			ja = 4.233
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play321301068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1043ui_story"]) and arg_269_1.var_.characterEffect1043ui_story == nil then
				arg_269_1.var_.characterEffect1043ui_story = arg_269_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1043ui_story"]) then
				if arg_269_1.var_.characterEffect1043ui_story and not isNil(arg_269_1.actors_["1043ui_story"]) then
					arg_269_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1043ui_story"]) and arg_269_1.var_.characterEffect1043ui_story then
				arg_269_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_272_2 = arg_269_1.actors_["1111ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1111ui_story == nil then
				arg_269_1.var_.characterEffect1111ui_story = var_272_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.characterEffect1111ui_story and not isNil(var_272_2) then
					arg_269_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_3)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1111ui_story then
				arg_269_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_272_4 = 0
			local var_272_5 = 0.075

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(321301067)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 3 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 3)

				if (3 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 3)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301067", "story_v_out_321301.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301067", "story_v_out_321301.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_321301", "321301067", "story_v_out_321301.awb")

						arg_269_1:RecordAudio("321301067", var_272_11)
						arg_269_1:RecordAudio("321301067", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_321301", "321301067", "story_v_out_321301.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_321301", "321301067", "story_v_out_321301.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play321301068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 321301068
		arg_273_1.duration_ = 7.03

		local var_273_0 = {
			zh = 6.3,
			ja = 7.033
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play321301069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1111ui_story = arg_273_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1111ui_story"].transform.position).z)
				arg_273_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1111ui_story"].transform.localEulerAngles = arg_273_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_273_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1111ui_story"].transform.position).z)
				arg_273_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1111ui_story"].transform.localEulerAngles = arg_273_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1043ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1043ui_story = var_276_1.localPosition
			end

			local var_276_2 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 then
				var_276_1.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_2)
				var_276_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_1.position).x, (manager.ui.mainCamera.transform.position - var_276_1.position).y, (manager.ui.mainCamera.transform.position - var_276_1.position).z)
				var_276_1.localEulerAngles.z = 0
				var_276_1.localEulerAngles.x = 0
				var_276_1.localEulerAngles = var_276_1.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 then
				var_276_1.localPosition = Vector3.New(0, 100, 0)
				var_276_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_1.position).x, (manager.ui.mainCamera.transform.position - var_276_1.position).y, (manager.ui.mainCamera.transform.position - var_276_1.position).z)
				var_276_1.localEulerAngles.z = 0
				var_276_1.localEulerAngles.x = 0
				var_276_1.localEulerAngles = var_276_1.localEulerAngles
			end

			local var_276_3 = arg_273_1.actors_["10131ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10131ui_story = var_276_3.localPosition
			end

			local var_276_4 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				var_276_3.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_273_1.time_ - 0) / var_276_4)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				var_276_3.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			local var_276_5 = arg_273_1.actors_["10131ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.characterEffect10131ui_story == nil then
				arg_273_1.var_.characterEffect10131ui_story = var_276_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_6 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_6 and not isNil(var_276_5) then
				if arg_273_1.var_.characterEffect10131ui_story and not isNil(var_276_5) then
					arg_273_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_6 and arg_273_1.time_ < 0 + var_276_6 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.characterEffect10131ui_story then
				arg_273_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_276_8 = arg_273_1.actors_["1043ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_8) and arg_273_1.var_.characterEffect1043ui_story == nil then
				arg_273_1.var_.characterEffect1043ui_story = var_276_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_9 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_9 and not isNil(var_276_8) then
				if arg_273_1.var_.characterEffect1043ui_story and not isNil(var_276_8) then
					arg_273_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_9)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_9 and arg_273_1.time_ < 0 + var_276_9 + arg_276_0 and not isNil(var_276_8) and arg_273_1.var_.characterEffect1043ui_story then
				arg_273_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_10 = 0
			local var_276_11 = 0.65

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_12 = arg_273_1:GetWordFromCfg(321301068)
				local var_276_13 = arg_273_1:FormatText(var_276_12.content)

				arg_273_1.text_.text = var_276_13

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_15 = 26 <= 0 and var_276_11 or var_276_11 * (utf8.len(var_276_13) / 26)

				if (26 <= 0 and var_276_11 or var_276_11 * (utf8.len(var_276_13) / 26)) > 0 and var_276_11 < var_276_15 then
					arg_273_1.talkMaxDuration = var_276_15

					if var_276_15 + var_276_10 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_15 + var_276_10
					end
				end

				arg_273_1.text_.text = var_276_13
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301068", "story_v_out_321301.awb") ~= 0 then
					local var_276_16 = manager.audio:GetVoiceLength("story_v_out_321301", "321301068", "story_v_out_321301.awb") / 1000

					if var_276_16 + var_276_10 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_16 + var_276_10
					end

					if var_276_12.prefab_name ~= "" and arg_273_1.actors_[var_276_12.prefab_name] ~= nil then
						local var_276_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_12.prefab_name].transform, "story_v_out_321301", "321301068", "story_v_out_321301.awb")

						arg_273_1:RecordAudio("321301068", var_276_17)
						arg_273_1:RecordAudio("321301068", var_276_17)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_321301", "321301068", "story_v_out_321301.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_321301", "321301068", "story_v_out_321301.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_18 = math.max(var_276_11, arg_273_1.talkMaxDuration)

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_18 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_10) / var_276_18

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_10 + var_276_18 and arg_273_1.time_ < var_276_10 + var_276_18 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play321301069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 321301069
		arg_277_1.duration_ = 2.37

		local var_277_0 = {
			zh = 2.366,
			ja = 2.266
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play321301070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1111ui_story"]) and arg_277_1.var_.characterEffect1111ui_story == nil then
				arg_277_1.var_.characterEffect1111ui_story = arg_277_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1111ui_story"]) then
				if arg_277_1.var_.characterEffect1111ui_story and not isNil(arg_277_1.actors_["1111ui_story"]) then
					arg_277_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1111ui_story"]) and arg_277_1.var_.characterEffect1111ui_story then
				arg_277_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_280_2 = arg_277_1.actors_["10131ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect10131ui_story == nil then
				arg_277_1.var_.characterEffect10131ui_story = var_280_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_3 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.characterEffect10131ui_story and not isNil(var_280_2) then
					arg_277_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_3)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect10131ui_story then
				arg_277_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action442")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_280_4 = 0
			local var_280_5 = 0.2

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(321301069)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 8 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 8)

				if (8 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 8)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301069", "story_v_out_321301.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301069", "story_v_out_321301.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_321301", "321301069", "story_v_out_321301.awb")

						arg_277_1:RecordAudio("321301069", var_280_11)
						arg_277_1:RecordAudio("321301069", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_321301", "321301069", "story_v_out_321301.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_321301", "321301069", "story_v_out_321301.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play321301070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 321301070
		arg_281_1.duration_ = 2.8

		local var_281_0 = {
			zh = 2.366,
			ja = 2.8
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play321301071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1111ui_story = arg_281_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1111ui_story"].transform.position).z)
				arg_281_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1111ui_story"].transform.localEulerAngles = arg_281_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_281_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1111ui_story"].transform.position).z)
				arg_281_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1111ui_story"].transform.localEulerAngles = arg_281_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["10131ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10131ui_story = var_284_1.localPosition
			end

			local var_284_2 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 then
				var_284_1.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_2)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 then
				var_284_1.localPosition = Vector3.New(0, 100, 0)
				var_284_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_1.position).x, (manager.ui.mainCamera.transform.position - var_284_1.position).y, (manager.ui.mainCamera.transform.position - var_284_1.position).z)
				var_284_1.localEulerAngles.z = 0
				var_284_1.localEulerAngles.x = 0
				var_284_1.localEulerAngles = var_284_1.localEulerAngles
			end

			local var_284_3 = arg_281_1.actors_["1043ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1043ui_story = var_284_3.localPosition
			end

			local var_284_4 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				var_284_3.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_281_1.time_ - 0) / var_284_4)
				var_284_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_3.position).x, (manager.ui.mainCamera.transform.position - var_284_3.position).y, (manager.ui.mainCamera.transform.position - var_284_3.position).z)
				var_284_3.localEulerAngles.z = 0
				var_284_3.localEulerAngles.x = 0
				var_284_3.localEulerAngles = var_284_3.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				var_284_3.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_284_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_3.position).x, (manager.ui.mainCamera.transform.position - var_284_3.position).y, (manager.ui.mainCamera.transform.position - var_284_3.position).z)
				var_284_3.localEulerAngles.z = 0
				var_284_3.localEulerAngles.x = 0
				var_284_3.localEulerAngles = var_284_3.localEulerAngles
			end

			local var_284_5 = arg_281_1.actors_["1043ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.characterEffect1043ui_story == nil then
				arg_281_1.var_.characterEffect1043ui_story = var_284_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_6 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_6 and not isNil(var_284_5) then
				if arg_281_1.var_.characterEffect1043ui_story and not isNil(var_284_5) then
					arg_281_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_6 and arg_281_1.time_ < 0 + var_284_6 + arg_284_0 and not isNil(var_284_5) and arg_281_1.var_.characterEffect1043ui_story then
				arg_281_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_284_8 = arg_281_1.actors_["1111ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.characterEffect1111ui_story == nil then
				arg_281_1.var_.characterEffect1111ui_story = var_284_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_9 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_9 and not isNil(var_284_8) then
				if arg_281_1.var_.characterEffect1111ui_story and not isNil(var_284_8) then
					arg_281_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_9)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_9 and arg_281_1.time_ < 0 + var_284_9 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.characterEffect1111ui_story then
				arg_281_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_284_10 = 0
			local var_284_11 = 0.275

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_12 = arg_281_1:GetWordFromCfg(321301070)
				local var_284_13 = arg_281_1:FormatText(var_284_12.content)

				arg_281_1.text_.text = var_284_13

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_15 = 11 <= 0 and var_284_11 or var_284_11 * (utf8.len(var_284_13) / 11)

				if (11 <= 0 and var_284_11 or var_284_11 * (utf8.len(var_284_13) / 11)) > 0 and var_284_11 < var_284_15 then
					arg_281_1.talkMaxDuration = var_284_15

					if var_284_15 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_15 + var_284_10
					end
				end

				arg_281_1.text_.text = var_284_13
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301070", "story_v_out_321301.awb") ~= 0 then
					local var_284_16 = manager.audio:GetVoiceLength("story_v_out_321301", "321301070", "story_v_out_321301.awb") / 1000

					if var_284_16 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_16 + var_284_10
					end

					if var_284_12.prefab_name ~= "" and arg_281_1.actors_[var_284_12.prefab_name] ~= nil then
						local var_284_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_12.prefab_name].transform, "story_v_out_321301", "321301070", "story_v_out_321301.awb")

						arg_281_1:RecordAudio("321301070", var_284_17)
						arg_281_1:RecordAudio("321301070", var_284_17)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_321301", "321301070", "story_v_out_321301.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_321301", "321301070", "story_v_out_321301.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_18 = math.max(var_284_11, arg_281_1.talkMaxDuration)

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_18 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_10) / var_284_18

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_10 + var_284_18 and arg_281_1.time_ < var_284_10 + var_284_18 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play321301071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 321301071
		arg_285_1.duration_ = 9.17

		local var_285_0 = {
			zh = 9.166,
			ja = 9.033
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play321301072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1111ui_story"]) and arg_285_1.var_.characterEffect1111ui_story == nil then
				arg_285_1.var_.characterEffect1111ui_story = arg_285_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1111ui_story"]) then
				if arg_285_1.var_.characterEffect1111ui_story and not isNil(arg_285_1.actors_["1111ui_story"]) then
					arg_285_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1111ui_story"]) and arg_285_1.var_.characterEffect1111ui_story then
				arg_285_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["1043ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1043ui_story == nil then
				arg_285_1.var_.characterEffect1043ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect1043ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1043ui_story then
				arg_285_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_288_4 = 0
			local var_288_5 = 0.925

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(321301071)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 37 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 37)

				if (37 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 37)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301071", "story_v_out_321301.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301071", "story_v_out_321301.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_321301", "321301071", "story_v_out_321301.awb")

						arg_285_1:RecordAudio("321301071", var_288_11)
						arg_285_1:RecordAudio("321301071", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_321301", "321301071", "story_v_out_321301.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_321301", "321301071", "story_v_out_321301.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play321301072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 321301072
		arg_289_1.duration_ = 10.87

		local var_289_0 = {
			zh = 8.733,
			ja = 10.866
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play321301073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1111ui_story = arg_289_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1111ui_story"].transform.position).z)
				arg_289_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1111ui_story"].transform.localEulerAngles = arg_289_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_289_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1111ui_story"].transform.position).z)
				arg_289_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1111ui_story"].transform.localEulerAngles = arg_289_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1043ui_story"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1043ui_story = var_292_1.localPosition
			end

			local var_292_2 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 then
				var_292_1.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_289_1.time_ - 0) / var_292_2)
				var_292_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_1.position).x, (manager.ui.mainCamera.transform.position - var_292_1.position).y, (manager.ui.mainCamera.transform.position - var_292_1.position).z)
				var_292_1.localEulerAngles.z = 0
				var_292_1.localEulerAngles.x = 0
				var_292_1.localEulerAngles = var_292_1.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 then
				var_292_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_292_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_1.position).x, (manager.ui.mainCamera.transform.position - var_292_1.position).y, (manager.ui.mainCamera.transform.position - var_292_1.position).z)
				var_292_1.localEulerAngles.z = 0
				var_292_1.localEulerAngles.x = 0
				var_292_1.localEulerAngles = var_292_1.localEulerAngles
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_3 = 0
			local var_292_4 = 1.125

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_3 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_5 = arg_289_1:GetWordFromCfg(321301072)
				local var_292_6 = arg_289_1:FormatText(var_292_5.content)

				arg_289_1.text_.text = var_292_6

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_8 = 45 <= 0 and var_292_4 or var_292_4 * (utf8.len(var_292_6) / 45)

				if (45 <= 0 and var_292_4 or var_292_4 * (utf8.len(var_292_6) / 45)) > 0 and var_292_4 < var_292_8 then
					arg_289_1.talkMaxDuration = var_292_8

					if var_292_8 + var_292_3 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_3
					end
				end

				arg_289_1.text_.text = var_292_6
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301072", "story_v_out_321301.awb") ~= 0 then
					local var_292_9 = manager.audio:GetVoiceLength("story_v_out_321301", "321301072", "story_v_out_321301.awb") / 1000

					if var_292_9 + var_292_3 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_3
					end

					if var_292_5.prefab_name ~= "" and arg_289_1.actors_[var_292_5.prefab_name] ~= nil then
						local var_292_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_5.prefab_name].transform, "story_v_out_321301", "321301072", "story_v_out_321301.awb")

						arg_289_1:RecordAudio("321301072", var_292_10)
						arg_289_1:RecordAudio("321301072", var_292_10)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_321301", "321301072", "story_v_out_321301.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_321301", "321301072", "story_v_out_321301.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_11 = math.max(var_292_4, arg_289_1.talkMaxDuration)

			if var_292_3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_3 + var_292_11 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_3) / var_292_11

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_3 + var_292_11 and arg_289_1.time_ < var_292_3 + var_292_11 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play321301073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 321301073
		arg_293_1.duration_ = 2.2

		local var_293_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play321301074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1043ui_story"]) and arg_293_1.var_.characterEffect1043ui_story == nil then
				arg_293_1.var_.characterEffect1043ui_story = arg_293_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1043ui_story"]) then
				if arg_293_1.var_.characterEffect1043ui_story and not isNil(arg_293_1.actors_["1043ui_story"]) then
					arg_293_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1043ui_story"]) and arg_293_1.var_.characterEffect1043ui_story then
				arg_293_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_296_2 = arg_293_1.actors_["1111ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect1111ui_story == nil then
				arg_293_1.var_.characterEffect1111ui_story = var_296_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_3 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.characterEffect1111ui_story and not isNil(var_296_2) then
					arg_293_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_3)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect1111ui_story then
				arg_293_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_296_4 = 0
			local var_296_5 = 0.15

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:GetWordFromCfg(321301073)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 6 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 6)

				if (6 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 6)) > 0 and var_296_5 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301073", "story_v_out_321301.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301073", "story_v_out_321301.awb") / 1000

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end

					if var_296_6.prefab_name ~= "" and arg_293_1.actors_[var_296_6.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_6.prefab_name].transform, "story_v_out_321301", "321301073", "story_v_out_321301.awb")

						arg_293_1:RecordAudio("321301073", var_296_11)
						arg_293_1:RecordAudio("321301073", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_321301", "321301073", "story_v_out_321301.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_321301", "321301073", "story_v_out_321301.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_12 and arg_293_1.time_ < var_296_4 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play321301074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 321301074
		arg_297_1.duration_ = 11.67

		local var_297_0 = {
			zh = 9.7,
			ja = 11.666
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play321301075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1111ui_story"]) and arg_297_1.var_.characterEffect1111ui_story == nil then
				arg_297_1.var_.characterEffect1111ui_story = arg_297_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1111ui_story"]) then
				if arg_297_1.var_.characterEffect1111ui_story and not isNil(arg_297_1.actors_["1111ui_story"]) then
					arg_297_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1111ui_story"]) and arg_297_1.var_.characterEffect1111ui_story then
				arg_297_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_300_2 = arg_297_1.actors_["1043ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect1043ui_story == nil then
				arg_297_1.var_.characterEffect1043ui_story = var_300_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.characterEffect1043ui_story and not isNil(var_300_2) then
					arg_297_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_3)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect1043ui_story then
				arg_297_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_300_4 = 0
			local var_300_5 = 1.225

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(321301074)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 49 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 49)

				if (49 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 49)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301074", "story_v_out_321301.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301074", "story_v_out_321301.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_out_321301", "321301074", "story_v_out_321301.awb")

						arg_297_1:RecordAudio("321301074", var_300_11)
						arg_297_1:RecordAudio("321301074", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_321301", "321301074", "story_v_out_321301.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_321301", "321301074", "story_v_out_321301.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play321301075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 321301075
		arg_301_1.duration_ = 9.6

		local var_301_0 = {
			zh = 7.566,
			ja = 9.6
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play321301076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_304_0 = 0
			local var_304_1 = 0.975

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(321301075)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 39 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 39)

				if (39 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 39)) > 0 and var_304_1 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301075", "story_v_out_321301.awb") ~= 0 then
					local var_304_6 = manager.audio:GetVoiceLength("story_v_out_321301", "321301075", "story_v_out_321301.awb") / 1000

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end

					if var_304_2.prefab_name ~= "" and arg_301_1.actors_[var_304_2.prefab_name] ~= nil then
						local var_304_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_2.prefab_name].transform, "story_v_out_321301", "321301075", "story_v_out_321301.awb")

						arg_301_1:RecordAudio("321301075", var_304_7)
						arg_301_1:RecordAudio("321301075", var_304_7)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_321301", "321301075", "story_v_out_321301.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_321301", "321301075", "story_v_out_321301.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play321301076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 321301076
		arg_305_1.duration_ = 6.8

		local var_305_0 = {
			zh = 4.266,
			ja = 6.8
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play321301077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.525

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:GetWordFromCfg(321301076)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 21 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 21)

				if (21 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 21)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301076", "story_v_out_321301.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301076", "story_v_out_321301.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_321301", "321301076", "story_v_out_321301.awb")

						arg_305_1:RecordAudio("321301076", var_308_6)
						arg_305_1:RecordAudio("321301076", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_321301", "321301076", "story_v_out_321301.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_321301", "321301076", "story_v_out_321301.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play321301077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 321301077
		arg_309_1.duration_ = 2

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play321301078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1043ui_story"]) and arg_309_1.var_.characterEffect1043ui_story == nil then
				arg_309_1.var_.characterEffect1043ui_story = arg_309_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1043ui_story"]) then
				if arg_309_1.var_.characterEffect1043ui_story and not isNil(arg_309_1.actors_["1043ui_story"]) then
					arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1043ui_story"]) and arg_309_1.var_.characterEffect1043ui_story then
				arg_309_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_312_2 = arg_309_1.actors_["1111ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1111ui_story == nil then
				arg_309_1.var_.characterEffect1111ui_story = var_312_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_3 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.characterEffect1111ui_story and not isNil(var_312_2) then
					arg_309_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_3)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1111ui_story then
				arg_309_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_2")
			end

			local var_312_4 = 0
			local var_312_5 = 0.05

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(321301077)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 2 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 2)

				if (2 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 2)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301077", "story_v_out_321301.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301077", "story_v_out_321301.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_321301", "321301077", "story_v_out_321301.awb")

						arg_309_1:RecordAudio("321301077", var_312_11)
						arg_309_1:RecordAudio("321301077", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_321301", "321301077", "story_v_out_321301.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_321301", "321301077", "story_v_out_321301.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play321301078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 321301078
		arg_313_1.duration_ = 3.33

		local var_313_0 = {
			zh = 1.999999999999,
			ja = 3.333
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play321301079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1111ui_story"]) and arg_313_1.var_.characterEffect1111ui_story == nil then
				arg_313_1.var_.characterEffect1111ui_story = arg_313_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1111ui_story"]) then
				if arg_313_1.var_.characterEffect1111ui_story and not isNil(arg_313_1.actors_["1111ui_story"]) then
					arg_313_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1111ui_story"]) and arg_313_1.var_.characterEffect1111ui_story then
				arg_313_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_316_2 = arg_313_1.actors_["1043ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.characterEffect1043ui_story == nil then
				arg_313_1.var_.characterEffect1043ui_story = var_316_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_3 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 and not isNil(var_316_2) then
				if arg_313_1.var_.characterEffect1043ui_story and not isNil(var_316_2) then
					arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_3)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.characterEffect1043ui_story then
				arg_313_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action454")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_316_4 = 0
			local var_316_5 = 0.175

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(321301078)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 7 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 7)

				if (7 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 7)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301078", "story_v_out_321301.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301078", "story_v_out_321301.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_out_321301", "321301078", "story_v_out_321301.awb")

						arg_313_1:RecordAudio("321301078", var_316_11)
						arg_313_1:RecordAudio("321301078", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_321301", "321301078", "story_v_out_321301.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_321301", "321301078", "story_v_out_321301.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play321301079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 321301079
		arg_317_1.duration_ = 3.5

		local var_317_0 = {
			zh = 2.5,
			ja = 3.5
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play321301080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1043ui_story"]) and arg_317_1.var_.characterEffect1043ui_story == nil then
				arg_317_1.var_.characterEffect1043ui_story = arg_317_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1043ui_story"]) then
				if arg_317_1.var_.characterEffect1043ui_story and not isNil(arg_317_1.actors_["1043ui_story"]) then
					arg_317_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1043ui_story"]) and arg_317_1.var_.characterEffect1043ui_story then
				arg_317_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_320_2 = arg_317_1.actors_["1111ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect1111ui_story == nil then
				arg_317_1.var_.characterEffect1111ui_story = var_320_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_3 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.characterEffect1111ui_story and not isNil(var_320_2) then
					arg_317_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_3)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect1111ui_story then
				arg_317_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_320_4 = 0
			local var_320_5 = 0.225

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(321301079)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 9 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 9)

				if (9 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 9)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301079", "story_v_out_321301.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301079", "story_v_out_321301.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_out_321301", "321301079", "story_v_out_321301.awb")

						arg_317_1:RecordAudio("321301079", var_320_11)
						arg_317_1:RecordAudio("321301079", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_321301", "321301079", "story_v_out_321301.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_321301", "321301079", "story_v_out_321301.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play321301080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 321301080
		arg_321_1.duration_ = 2

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play321301081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1111ui_story = arg_321_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).z)
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles = arg_321_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_321_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1111ui_story"].transform.position).z)
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1111ui_story"].transform.localEulerAngles = arg_321_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1043ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1043ui_story = var_324_1.localPosition
			end

			local var_324_2 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 then
				var_324_1.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_321_1.time_ - 0) / var_324_2)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 then
				var_324_1.localPosition = Vector3.New(0, 100, 0)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			local var_324_3 = arg_321_1.actors_["10131ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10131ui_story = var_324_3.localPosition
			end

			local var_324_4 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				var_324_3.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_321_1.time_ - 0) / var_324_4)
				var_324_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_3.position).x, (manager.ui.mainCamera.transform.position - var_324_3.position).y, (manager.ui.mainCamera.transform.position - var_324_3.position).z)
				var_324_3.localEulerAngles.z = 0
				var_324_3.localEulerAngles.x = 0
				var_324_3.localEulerAngles = var_324_3.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				var_324_3.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_324_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_3.position).x, (manager.ui.mainCamera.transform.position - var_324_3.position).y, (manager.ui.mainCamera.transform.position - var_324_3.position).z)
				var_324_3.localEulerAngles.z = 0
				var_324_3.localEulerAngles.x = 0
				var_324_3.localEulerAngles = var_324_3.localEulerAngles
			end

			local var_324_5 = arg_321_1.actors_["10131ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_5) and arg_321_1.var_.characterEffect10131ui_story == nil then
				arg_321_1.var_.characterEffect10131ui_story = var_324_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_6 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_6 and not isNil(var_324_5) then
				if arg_321_1.var_.characterEffect10131ui_story and not isNil(var_324_5) then
					arg_321_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_6 and arg_321_1.time_ < 0 + var_324_6 + arg_324_0 and not isNil(var_324_5) and arg_321_1.var_.characterEffect10131ui_story then
				arg_321_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_324_8 = arg_321_1.actors_["1043ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_8) and arg_321_1.var_.characterEffect1043ui_story == nil then
				arg_321_1.var_.characterEffect1043ui_story = var_324_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_9 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_9 and not isNil(var_324_8) then
				if arg_321_1.var_.characterEffect1043ui_story and not isNil(var_324_8) then
					arg_321_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_9)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_9 and arg_321_1.time_ < 0 + var_324_9 + arg_324_0 and not isNil(var_324_8) and arg_321_1.var_.characterEffect1043ui_story then
				arg_321_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_324_10 = 0
			local var_324_11 = 0.075

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_12 = arg_321_1:GetWordFromCfg(321301080)
				local var_324_13 = arg_321_1:FormatText(var_324_12.content)

				arg_321_1.text_.text = var_324_13

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_15 = 3 <= 0 and var_324_11 or var_324_11 * (utf8.len(var_324_13) / 3)

				if (3 <= 0 and var_324_11 or var_324_11 * (utf8.len(var_324_13) / 3)) > 0 and var_324_11 < var_324_15 then
					arg_321_1.talkMaxDuration = var_324_15

					if var_324_15 + var_324_10 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_15 + var_324_10
					end
				end

				arg_321_1.text_.text = var_324_13
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301080", "story_v_out_321301.awb") ~= 0 then
					local var_324_16 = manager.audio:GetVoiceLength("story_v_out_321301", "321301080", "story_v_out_321301.awb") / 1000

					if var_324_16 + var_324_10 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_16 + var_324_10
					end

					if var_324_12.prefab_name ~= "" and arg_321_1.actors_[var_324_12.prefab_name] ~= nil then
						local var_324_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_12.prefab_name].transform, "story_v_out_321301", "321301080", "story_v_out_321301.awb")

						arg_321_1:RecordAudio("321301080", var_324_17)
						arg_321_1:RecordAudio("321301080", var_324_17)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_321301", "321301080", "story_v_out_321301.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_321301", "321301080", "story_v_out_321301.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_18 = math.max(var_324_11, arg_321_1.talkMaxDuration)

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_18 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_10) / var_324_18

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_10 + var_324_18 and arg_321_1.time_ < var_324_10 + var_324_18 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play321301081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 321301081
		arg_325_1.duration_ = 9

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play321301082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 2 < arg_325_1.time_ and arg_325_1.time_ <= 2 + arg_328_0 then
				local var_328_0 = arg_325_1.bgs_.L09g

				arg_325_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_1 = var_328_0:GetComponent("SpriteRenderer")

				if var_328_1 and var_328_1.sprite then
					local var_328_2 = 2 * (var_328_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_0.transform.localScale = Vector3.New(var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "L09g" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_3 = 3.999999999999

			if 3.999999999999 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= var_328_3 + 0.3 and arg_325_1.time_ < var_328_3 + 0.3 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			local var_328_4 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_5 = 2

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_5 then
				local var_328_6 = Color.New(0, 0, 0)

				var_328_6.a = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_4) / var_328_5)
				arg_325_1.mask_.color = var_328_6
			end

			if arg_325_1.time_ >= var_328_4 + var_328_5 and arg_325_1.time_ < var_328_4 + var_328_5 + arg_328_0 then
				local var_328_7 = Color.New(0, 0, 0)

				var_328_7.a = 1
				arg_325_1.mask_.color = var_328_7
			end

			local var_328_8 = 2

			if 2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_9 = 2

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_9 then
				local var_328_10 = Color.New(0, 0, 0)

				var_328_10.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_8) / var_328_9)
				arg_325_1.mask_.color = var_328_10
			end

			if arg_325_1.time_ >= var_328_8 + var_328_9 and arg_325_1.time_ < var_328_8 + var_328_9 + arg_328_0 then
				local var_328_11 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_11.a = 0
				arg_325_1.mask_.color = var_328_11
			end

			local var_328_12 = arg_325_1.actors_["1111ui_story"].transform

			if 1.96599999815226 < arg_325_1.time_ and arg_325_1.time_ <= 1.96599999815226 + arg_328_0 then
				arg_325_1.var_.moveOldPos1111ui_story = var_328_12.localPosition
			end

			local var_328_13 = 0.001

			if 1.96599999815226 <= arg_325_1.time_ and arg_325_1.time_ < 1.96599999815226 + var_328_13 then
				var_328_12.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 1.96599999815226) / var_328_13)
				var_328_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_12.position).x, (manager.ui.mainCamera.transform.position - var_328_12.position).y, (manager.ui.mainCamera.transform.position - var_328_12.position).z)
				var_328_12.localEulerAngles.z = 0
				var_328_12.localEulerAngles.x = 0
				var_328_12.localEulerAngles = var_328_12.localEulerAngles
			end

			if arg_325_1.time_ >= 1.96599999815226 + var_328_13 and arg_325_1.time_ < 1.96599999815226 + var_328_13 + arg_328_0 then
				var_328_12.localPosition = Vector3.New(0, 100, 0)
				var_328_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_12.position).x, (manager.ui.mainCamera.transform.position - var_328_12.position).y, (manager.ui.mainCamera.transform.position - var_328_12.position).z)
				var_328_12.localEulerAngles.z = 0
				var_328_12.localEulerAngles.x = 0
				var_328_12.localEulerAngles = var_328_12.localEulerAngles
			end

			local var_328_14 = arg_325_1.actors_["10131ui_story"].transform

			if 1.96599999815226 < arg_325_1.time_ and arg_325_1.time_ <= 1.96599999815226 + arg_328_0 then
				arg_325_1.var_.moveOldPos10131ui_story = var_328_14.localPosition
			end

			local var_328_15 = 0.001

			if 1.96599999815226 <= arg_325_1.time_ and arg_325_1.time_ < 1.96599999815226 + var_328_15 then
				var_328_14.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 1.96599999815226) / var_328_15)
				var_328_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_14.position).x, (manager.ui.mainCamera.transform.position - var_328_14.position).y, (manager.ui.mainCamera.transform.position - var_328_14.position).z)
				var_328_14.localEulerAngles.z = 0
				var_328_14.localEulerAngles.x = 0
				var_328_14.localEulerAngles = var_328_14.localEulerAngles
			end

			if arg_325_1.time_ >= 1.96599999815226 + var_328_15 and arg_325_1.time_ < 1.96599999815226 + var_328_15 + arg_328_0 then
				var_328_14.localPosition = Vector3.New(0, 100, 0)
				var_328_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_14.position).x, (manager.ui.mainCamera.transform.position - var_328_14.position).y, (manager.ui.mainCamera.transform.position - var_328_14.position).z)
				var_328_14.localEulerAngles.z = 0
				var_328_14.localEulerAngles.x = 0
				var_328_14.localEulerAngles = var_328_14.localEulerAngles
			end

			local var_328_16 = arg_325_1.actors_["10131ui_story"]

			if 1.96599999815226 < arg_325_1.time_ and arg_325_1.time_ <= 1.96599999815226 + arg_328_0 and not isNil(var_328_16) and arg_325_1.var_.characterEffect10131ui_story == nil then
				arg_325_1.var_.characterEffect10131ui_story = var_328_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_17 = 0.034000001847744

			if 1.96599999815226 <= arg_325_1.time_ and arg_325_1.time_ < 1.96599999815226 + var_328_17 and not isNil(var_328_16) then
				if arg_325_1.var_.characterEffect10131ui_story and not isNil(var_328_16) then
					arg_325_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 1.96599999815226) / var_328_17)
				end
			end

			if arg_325_1.time_ >= 1.96599999815226 + var_328_17 and arg_325_1.time_ < 1.96599999815226 + var_328_17 + arg_328_0 and not isNil(var_328_16) and arg_325_1.var_.characterEffect10131ui_story then
				arg_325_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 4.299999999999 < arg_325_1.time_ and arg_325_1.time_ <= 4.299999999999 + arg_328_0 then
				arg_325_1:AudioAction("play", "effect", "se_story_141", "se_story_141_clap", "")
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_19 = 3.999999999999
			local var_328_20 = 0.7

			if 3.999999999999 < arg_325_1.time_ and arg_325_1.time_ <= var_328_19 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_21 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_21:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_22 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(321301081).content)

				arg_325_1.text_.text = var_328_22

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_24 = 28 <= 0 and var_328_20 or var_328_20 * (utf8.len(var_328_22) / 28)

				if (28 <= 0 and var_328_20 or var_328_20 * (utf8.len(var_328_22) / 28)) > 0 and var_328_20 < var_328_24 then
					arg_325_1.talkMaxDuration = var_328_24
					var_328_19 = var_328_19 + 0.3

					if var_328_24 + var_328_19 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_24 + var_328_19
					end
				end

				arg_325_1.text_.text = var_328_22
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_25 = var_328_19 + 0.3
			local var_328_26 = math.max(var_328_20, arg_325_1.talkMaxDuration)

			if var_328_19 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_25 + var_328_26 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_25) / var_328_26

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_25 + var_328_26 and arg_325_1.time_ < var_328_25 + var_328_26 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play321301082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 321301082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play321301083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.175

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(321301082).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 47 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 47)

				if (47 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 47)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play321301083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 321301083
		arg_335_1.duration_ = 9.43

		local var_335_0 = {
			zh = 9.133,
			ja = 9.433
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play321301084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1111ui_story = arg_335_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1111ui_story"].transform.position).z)
				arg_335_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1111ui_story"].transform.localEulerAngles = arg_335_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_335_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1111ui_story"].transform.position).z)
				arg_335_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1111ui_story"].transform.localEulerAngles = arg_335_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1111ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1111ui_story == nil then
				arg_335_1.var_.characterEffect1111ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect1111ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1111ui_story then
				arg_335_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_338_4 = 0
			local var_338_5 = 0.975

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_6 = arg_335_1:GetWordFromCfg(321301083)
				local var_338_7 = arg_335_1:FormatText(var_338_6.content)

				arg_335_1.text_.text = var_338_7

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 38 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 38)

				if (38 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 38)) > 0 and var_338_5 < var_338_9 then
					arg_335_1.talkMaxDuration = var_338_9

					if var_338_9 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_9 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_7
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301083", "story_v_out_321301.awb") ~= 0 then
					local var_338_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301083", "story_v_out_321301.awb") / 1000

					if var_338_10 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_4
					end

					if var_338_6.prefab_name ~= "" and arg_335_1.actors_[var_338_6.prefab_name] ~= nil then
						local var_338_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_6.prefab_name].transform, "story_v_out_321301", "321301083", "story_v_out_321301.awb")

						arg_335_1:RecordAudio("321301083", var_338_11)
						arg_335_1:RecordAudio("321301083", var_338_11)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_321301", "321301083", "story_v_out_321301.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_321301", "321301083", "story_v_out_321301.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_12 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_12 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_12

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_12 and arg_335_1.time_ < var_338_4 + var_338_12 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play321301084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 321301084
		arg_339_1.duration_ = 7.7

		local var_339_0 = {
			zh = 7.4,
			ja = 7.7
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play321301085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1111ui_story"]) and arg_339_1.var_.characterEffect1111ui_story == nil then
				arg_339_1.var_.characterEffect1111ui_story = arg_339_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1111ui_story"]) then
				if arg_339_1.var_.characterEffect1111ui_story and not isNil(arg_339_1.actors_["1111ui_story"]) then
					arg_339_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1111ui_story"]) and arg_339_1.var_.characterEffect1111ui_story then
				arg_339_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 0.85

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10131")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:GetWordFromCfg(321301084)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_6 = 34 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_4) / 34)

				if (34 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_4) / 34)) > 0 and var_342_2 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301084", "story_v_out_321301.awb") ~= 0 then
					local var_342_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301084", "story_v_out_321301.awb") / 1000

					if var_342_7 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_1
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_321301", "321301084", "story_v_out_321301.awb")

						arg_339_1:RecordAudio("321301084", var_342_8)
						arg_339_1:RecordAudio("321301084", var_342_8)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_321301", "321301084", "story_v_out_321301.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_321301", "321301084", "story_v_out_321301.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_9 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_9 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_9

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_9 and arg_339_1.time_ < var_342_1 + var_342_9 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play321301085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 321301085
		arg_343_1.duration_ = 5.5

		local var_343_0 = {
			zh = 4.666,
			ja = 5.5
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play321301086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1111ui_story"]) and arg_343_1.var_.characterEffect1111ui_story == nil then
				arg_343_1.var_.characterEffect1111ui_story = arg_343_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1111ui_story"]) then
				if arg_343_1.var_.characterEffect1111ui_story and not isNil(arg_343_1.actors_["1111ui_story"]) then
					arg_343_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1111ui_story"]) and arg_343_1.var_.characterEffect1111ui_story then
				arg_343_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_346_2 = arg_343_1.actors_["10131ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.characterEffect10131ui_story == nil then
				arg_343_1.var_.characterEffect10131ui_story = var_346_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_3 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_3 and not isNil(var_346_2) then
				if arg_343_1.var_.characterEffect10131ui_story and not isNil(var_346_2) then
					arg_343_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_343_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_3)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_3 and arg_343_1.time_ < 0 + var_346_3 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.characterEffect10131ui_story then
				arg_343_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_343_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_346_4 = 0
			local var_346_5 = 0.475

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_6 = arg_343_1:GetWordFromCfg(321301085)
				local var_346_7 = arg_343_1:FormatText(var_346_6.content)

				arg_343_1.text_.text = var_346_7

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 19 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 19)

				if (19 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 19)) > 0 and var_346_5 < var_346_9 then
					arg_343_1.talkMaxDuration = var_346_9

					if var_346_9 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_7
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301085", "story_v_out_321301.awb") ~= 0 then
					local var_346_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301085", "story_v_out_321301.awb") / 1000

					if var_346_10 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_4
					end

					if var_346_6.prefab_name ~= "" and arg_343_1.actors_[var_346_6.prefab_name] ~= nil then
						local var_346_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_6.prefab_name].transform, "story_v_out_321301", "321301085", "story_v_out_321301.awb")

						arg_343_1:RecordAudio("321301085", var_346_11)
						arg_343_1:RecordAudio("321301085", var_346_11)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_321301", "321301085", "story_v_out_321301.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_321301", "321301085", "story_v_out_321301.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_12 = math.max(var_346_5, arg_343_1.talkMaxDuration)

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_12 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_4) / var_346_12

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_4 + var_346_12 and arg_343_1.time_ < var_346_4 + var_346_12 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play321301086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 321301086
		arg_347_1.duration_ = 8

		local var_347_0 = {
			zh = 7.4,
			ja = 8
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play321301087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.825

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(321301086)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 33 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 33)

				if (33 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 33)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301086", "story_v_out_321301.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301086", "story_v_out_321301.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_321301", "321301086", "story_v_out_321301.awb")

						arg_347_1:RecordAudio("321301086", var_350_6)
						arg_347_1:RecordAudio("321301086", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_321301", "321301086", "story_v_out_321301.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_321301", "321301086", "story_v_out_321301.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play321301087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 321301087
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play321301088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1111ui_story = arg_351_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).z)
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles = arg_351_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1111ui_story"].transform.position).z)
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1111ui_story"].transform.localEulerAngles = arg_351_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["10131ui_story"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos10131ui_story = var_354_1.localPosition
			end

			local var_354_2 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 then
				var_354_1.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 0) / var_354_2)
				var_354_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_1.position).x, (manager.ui.mainCamera.transform.position - var_354_1.position).y, (manager.ui.mainCamera.transform.position - var_354_1.position).z)
				var_354_1.localEulerAngles.z = 0
				var_354_1.localEulerAngles.x = 0
				var_354_1.localEulerAngles = var_354_1.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 then
				var_354_1.localPosition = Vector3.New(0, 100, 0)
				var_354_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_1.position).x, (manager.ui.mainCamera.transform.position - var_354_1.position).y, (manager.ui.mainCamera.transform.position - var_354_1.position).z)
				var_354_1.localEulerAngles.z = 0
				var_354_1.localEulerAngles.x = 0
				var_354_1.localEulerAngles = var_354_1.localEulerAngles
			end

			local var_354_3 = arg_351_1.actors_["1111ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_3) and arg_351_1.var_.characterEffect1111ui_story == nil then
				arg_351_1.var_.characterEffect1111ui_story = var_354_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_4 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 and not isNil(var_354_3) then
				if arg_351_1.var_.characterEffect1111ui_story and not isNil(var_354_3) then
					arg_351_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_4)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 and not isNil(var_354_3) and arg_351_1.var_.characterEffect1111ui_story then
				arg_351_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_354_5 = 0
			local var_354_6 = 1.4

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(321301087).content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 56 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_7) / 56)

				if (56 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_7) / 56)) > 0 and var_354_6 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_10 and arg_351_1.time_ < var_354_5 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play321301088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 321301088
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play321301089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.575

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(321301088).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 23 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 23)

				if (23 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 23)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play321301089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 321301089
		arg_359_1.duration_ = 3.9

		local var_359_0 = {
			zh = 2.866,
			ja = 3.9
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play321301090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1043ui_story = arg_359_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1043ui_story"].transform.position).z)
				arg_359_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1043ui_story"].transform.localEulerAngles = arg_359_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_359_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1043ui_story"].transform.position).z)
				arg_359_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1043ui_story"].transform.localEulerAngles = arg_359_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1043ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1043ui_story == nil then
				arg_359_1.var_.characterEffect1043ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect1043ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1043ui_story then
				arg_359_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_362_4 = 0
			local var_362_5 = 0.325

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(321301089)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 13 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 13)

				if (13 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 13)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301089", "story_v_out_321301.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301089", "story_v_out_321301.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_321301", "321301089", "story_v_out_321301.awb")

						arg_359_1:RecordAudio("321301089", var_362_11)
						arg_359_1:RecordAudio("321301089", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_321301", "321301089", "story_v_out_321301.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_321301", "321301089", "story_v_out_321301.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play321301090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 321301090
		arg_363_1.duration_ = 4.27

		local var_363_0 = {
			zh = 3,
			ja = 4.266
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play321301091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1043ui_story"]) and arg_363_1.var_.characterEffect1043ui_story == nil then
				arg_363_1.var_.characterEffect1043ui_story = arg_363_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1043ui_story"]) then
				if arg_363_1.var_.characterEffect1043ui_story and not isNil(arg_363_1.actors_["1043ui_story"]) then
					arg_363_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_363_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1043ui_story"]) and arg_363_1.var_.characterEffect1043ui_story then
				arg_363_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_363_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0
			local var_366_2 = 0.225

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:GetWordFromCfg(321301090)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_6 = 9 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_4) / 9)

				if (9 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_4) / 9)) > 0 and var_366_2 < var_366_6 then
					arg_363_1.talkMaxDuration = var_366_6

					if var_366_6 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301090", "story_v_out_321301.awb") ~= 0 then
					local var_366_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301090", "story_v_out_321301.awb") / 1000

					if var_366_7 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_1
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_321301", "321301090", "story_v_out_321301.awb")

						arg_363_1:RecordAudio("321301090", var_366_8)
						arg_363_1:RecordAudio("321301090", var_366_8)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_321301", "321301090", "story_v_out_321301.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_321301", "321301090", "story_v_out_321301.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_9 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_9 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_9

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_9 and arg_363_1.time_ < var_366_1 + var_366_9 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play321301091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 321301091
		arg_367_1.duration_ = 2.93

		local var_367_0 = {
			zh = 2.933,
			ja = 1.999999999999
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play321301092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1043ui_story = arg_367_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1043ui_story"].transform.position).z)
				arg_367_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1043ui_story"].transform.localEulerAngles = arg_367_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_367_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1043ui_story"].transform.position).z)
				arg_367_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1043ui_story"].transform.localEulerAngles = arg_367_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1043ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1043ui_story == nil then
				arg_367_1.var_.characterEffect1043ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1043ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1043ui_story then
				arg_367_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_370_4 = 0
			local var_370_5 = 0.325

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(321301091)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 13 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 13)

				if (13 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 13)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301091", "story_v_out_321301.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301091", "story_v_out_321301.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_out_321301", "321301091", "story_v_out_321301.awb")

						arg_367_1:RecordAudio("321301091", var_370_11)
						arg_367_1:RecordAudio("321301091", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_321301", "321301091", "story_v_out_321301.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_321301", "321301091", "story_v_out_321301.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play321301092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 321301092
		arg_371_1.duration_ = 4.93

		local var_371_0 = {
			zh = 3.2,
			ja = 4.933
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play321301093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1043ui_story"]) and arg_371_1.var_.characterEffect1043ui_story == nil then
				arg_371_1.var_.characterEffect1043ui_story = arg_371_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1043ui_story"]) then
				if arg_371_1.var_.characterEffect1043ui_story and not isNil(arg_371_1.actors_["1043ui_story"]) then
					arg_371_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1043ui_story"]) and arg_371_1.var_.characterEffect1043ui_story then
				arg_371_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0
			local var_374_2 = 0.15

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[1210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:GetWordFromCfg(321301092)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_6 = 6 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_4) / 6)

				if (6 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_4) / 6)) > 0 and var_374_2 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301092", "story_v_out_321301.awb") ~= 0 then
					local var_374_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301092", "story_v_out_321301.awb") / 1000

					if var_374_7 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_1
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_out_321301", "321301092", "story_v_out_321301.awb")

						arg_371_1:RecordAudio("321301092", var_374_8)
						arg_371_1:RecordAudio("321301092", var_374_8)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_321301", "321301092", "story_v_out_321301.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_321301", "321301092", "story_v_out_321301.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_9 = math.max(var_374_2, arg_371_1.talkMaxDuration)

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_9 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_1) / var_374_9

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_1 + var_374_9 and arg_371_1.time_ < var_374_1 + var_374_9 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play321301093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 321301093
		arg_375_1.duration_ = 2

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play321301094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1043ui_story = arg_375_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1043ui_story"].transform.position).z)
				arg_375_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1043ui_story"].transform.localEulerAngles = arg_375_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_375_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1043ui_story"].transform.position).z)
				arg_375_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1043ui_story"].transform.localEulerAngles = arg_375_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1043ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1043ui_story == nil then
				arg_375_1.var_.characterEffect1043ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1043ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1043ui_story then
				arg_375_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043actionlink/1043action425")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_378_4 = 0
			local var_378_5 = 0.15

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(321301093)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 6 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 6)

				if (6 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 6)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301093", "story_v_out_321301.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301093", "story_v_out_321301.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_321301", "321301093", "story_v_out_321301.awb")

						arg_375_1:RecordAudio("321301093", var_378_11)
						arg_375_1:RecordAudio("321301093", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_321301", "321301093", "story_v_out_321301.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_321301", "321301093", "story_v_out_321301.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play321301094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 321301094
		arg_379_1.duration_ = 8.83

		local var_379_0 = {
			zh = 8.3,
			ja = 8.833
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play321301095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1043ui_story"]) and arg_379_1.var_.characterEffect1043ui_story == nil then
				arg_379_1.var_.characterEffect1043ui_story = arg_379_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1043ui_story"]) then
				if arg_379_1.var_.characterEffect1043ui_story and not isNil(arg_379_1.actors_["1043ui_story"]) then
					arg_379_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1043ui_story"]) and arg_379_1.var_.characterEffect1043ui_story then
				arg_379_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 0.8

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(321301094)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_6 = 32 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 32)

				if (32 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_4) / 32)) > 0 and var_382_2 < var_382_6 then
					arg_379_1.talkMaxDuration = var_382_6

					if var_382_6 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_6 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301094", "story_v_out_321301.awb") ~= 0 then
					local var_382_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301094", "story_v_out_321301.awb") / 1000

					if var_382_7 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_1
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_out_321301", "321301094", "story_v_out_321301.awb")

						arg_379_1:RecordAudio("321301094", var_382_8)
						arg_379_1:RecordAudio("321301094", var_382_8)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_321301", "321301094", "story_v_out_321301.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_321301", "321301094", "story_v_out_321301.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_9 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_9 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_9

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_9 and arg_379_1.time_ < var_382_1 + var_382_9 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play321301095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 321301095
		arg_383_1.duration_ = 10

		local var_383_0 = {
			zh = 7.366,
			ja = 10
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play321301096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.85

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[1210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_1 = arg_383_1:GetWordFromCfg(321301095)
				local var_386_2 = arg_383_1:FormatText(var_386_1.content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 34 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 34)

				if (34 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 34)) > 0 and var_386_0 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301095", "story_v_out_321301.awb") ~= 0 then
					local var_386_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301095", "story_v_out_321301.awb") / 1000

					if var_386_5 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + 0
					end

					if var_386_1.prefab_name ~= "" and arg_383_1.actors_[var_386_1.prefab_name] ~= nil then
						local var_386_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_1.prefab_name].transform, "story_v_out_321301", "321301095", "story_v_out_321301.awb")

						arg_383_1:RecordAudio("321301095", var_386_6)
						arg_383_1:RecordAudio("321301095", var_386_6)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_321301", "321301095", "story_v_out_321301.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_321301", "321301095", "story_v_out_321301.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play321301096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 321301096
		arg_387_1.duration_ = 12.37

		local var_387_0 = {
			zh = 9.933,
			ja = 12.366
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play321301097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1.15

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[1210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_1 = arg_387_1:GetWordFromCfg(321301096)
				local var_390_2 = arg_387_1:FormatText(var_390_1.content)

				arg_387_1.text_.text = var_390_2

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 46 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 46)

				if (46 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 46)) > 0 and var_390_0 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end

				arg_387_1.text_.text = var_390_2
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301096", "story_v_out_321301.awb") ~= 0 then
					local var_390_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301096", "story_v_out_321301.awb") / 1000

					if var_390_5 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + 0
					end

					if var_390_1.prefab_name ~= "" and arg_387_1.actors_[var_390_1.prefab_name] ~= nil then
						local var_390_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_1.prefab_name].transform, "story_v_out_321301", "321301096", "story_v_out_321301.awb")

						arg_387_1:RecordAudio("321301096", var_390_6)
						arg_387_1:RecordAudio("321301096", var_390_6)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_321301", "321301096", "story_v_out_321301.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_321301", "321301096", "story_v_out_321301.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play321301097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 321301097
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play321301098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1043ui_story = arg_391_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1043ui_story"].transform.position).z)
				arg_391_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1043ui_story"].transform.localEulerAngles = arg_391_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1043ui_story"].transform.position).z)
				arg_391_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1043ui_story"].transform.localEulerAngles = arg_391_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_394_1 = 0
			local var_394_2 = 0.85

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(321301097).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 34 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 34)

				if (34 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 34)) > 0 and var_394_2 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_6 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_6 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_6

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_6 and arg_391_1.time_ < var_394_1 + var_394_6 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play321301098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 321301098
		arg_395_1.duration_ = 3.77

		local var_395_0 = {
			zh = 3.5,
			ja = 3.766
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play321301099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1111ui_story = arg_395_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).z)
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles = arg_395_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_395_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1111ui_story"].transform.position).z)
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1111ui_story"].transform.localEulerAngles = arg_395_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1111ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1111ui_story == nil then
				arg_395_1.var_.characterEffect1111ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1111ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1111ui_story then
				arg_395_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_398_4 = 0
			local var_398_5 = 0.3

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:GetWordFromCfg(321301098)
				local var_398_7 = arg_395_1:FormatText(var_398_6.content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 12 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 12)

				if (12 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 12)) > 0 and var_398_5 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301098", "story_v_out_321301.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301098", "story_v_out_321301.awb") / 1000

					if var_398_10 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_4
					end

					if var_398_6.prefab_name ~= "" and arg_395_1.actors_[var_398_6.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_6.prefab_name].transform, "story_v_out_321301", "321301098", "story_v_out_321301.awb")

						arg_395_1:RecordAudio("321301098", var_398_11)
						arg_395_1:RecordAudio("321301098", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_321301", "321301098", "story_v_out_321301.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_321301", "321301098", "story_v_out_321301.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_12 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_12 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_12

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_12 and arg_395_1.time_ < var_398_4 + var_398_12 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play321301099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 321301099
		arg_399_1.duration_ = 8.53

		local var_399_0 = {
			zh = 5.1,
			ja = 8.533
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play321301100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1111ui_story"]) and arg_399_1.var_.characterEffect1111ui_story == nil then
				arg_399_1.var_.characterEffect1111ui_story = arg_399_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1111ui_story"]) then
				if arg_399_1.var_.characterEffect1111ui_story and not isNil(arg_399_1.actors_["1111ui_story"]) then
					arg_399_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1111ui_story"]) and arg_399_1.var_.characterEffect1111ui_story then
				arg_399_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.475

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[1210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Elizabeth")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:GetWordFromCfg(321301099)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_6 = 19 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_4) / 19)

				if (19 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_4) / 19)) > 0 and var_402_2 < var_402_6 then
					arg_399_1.talkMaxDuration = var_402_6

					if var_402_6 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_6 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301099", "story_v_out_321301.awb") ~= 0 then
					local var_402_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301099", "story_v_out_321301.awb") / 1000

					if var_402_7 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_1
					end

					if var_402_3.prefab_name ~= "" and arg_399_1.actors_[var_402_3.prefab_name] ~= nil then
						local var_402_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_3.prefab_name].transform, "story_v_out_321301", "321301099", "story_v_out_321301.awb")

						arg_399_1:RecordAudio("321301099", var_402_8)
						arg_399_1:RecordAudio("321301099", var_402_8)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_321301", "321301099", "story_v_out_321301.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_321301", "321301099", "story_v_out_321301.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_9 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_9 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_9

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_9 and arg_399_1.time_ < var_402_1 + var_402_9 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play321301100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 321301100
		arg_403_1.duration_ = 2.4

		local var_403_0 = {
			zh = 1.9,
			ja = 2.4
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play321301101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1111ui_story"]) and arg_403_1.var_.characterEffect1111ui_story == nil then
				arg_403_1.var_.characterEffect1111ui_story = arg_403_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1111ui_story"]) then
				if arg_403_1.var_.characterEffect1111ui_story and not isNil(arg_403_1.actors_["1111ui_story"]) then
					arg_403_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1111ui_story"]) and arg_403_1.var_.characterEffect1111ui_story then
				arg_403_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_406_2 = 0
			local var_406_3 = 0.2

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_4 = arg_403_1:GetWordFromCfg(321301100)
				local var_406_5 = arg_403_1:FormatText(var_406_4.content)

				arg_403_1.text_.text = var_406_5

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 8 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 8)

				if (8 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 8)) > 0 and var_406_3 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_2
					end
				end

				arg_403_1.text_.text = var_406_5
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301100", "story_v_out_321301.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_321301", "321301100", "story_v_out_321301.awb") / 1000

					if var_406_8 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_2
					end

					if var_406_4.prefab_name ~= "" and arg_403_1.actors_[var_406_4.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_4.prefab_name].transform, "story_v_out_321301", "321301100", "story_v_out_321301.awb")

						arg_403_1:RecordAudio("321301100", var_406_9)
						arg_403_1:RecordAudio("321301100", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_321301", "321301100", "story_v_out_321301.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_321301", "321301100", "story_v_out_321301.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_3, arg_403_1.talkMaxDuration)

			if var_406_2 <= arg_403_1.time_ and arg_403_1.time_ < var_406_2 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_2) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_2 + var_406_10 and arg_403_1.time_ < var_406_2 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play321301101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 321301101
		arg_407_1.duration_ = 5.2

		local var_407_0 = {
			zh = 4.666,
			ja = 5.2
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play321301102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1111ui_story = arg_407_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1111ui_story"].transform.position).z)
				arg_407_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1111ui_story"].transform.localEulerAngles = arg_407_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_407_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1111ui_story"].transform.position).z)
				arg_407_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1111ui_story"].transform.localEulerAngles = arg_407_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_410_1 = 0
			local var_410_2 = 0.4

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_3 = arg_407_1:GetWordFromCfg(321301101)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_6 = 16 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_4) / 16)

				if (16 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_4) / 16)) > 0 and var_410_2 < var_410_6 then
					arg_407_1.talkMaxDuration = var_410_6

					if var_410_6 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_4
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301101", "story_v_out_321301.awb") ~= 0 then
					local var_410_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301101", "story_v_out_321301.awb") / 1000

					if var_410_7 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_1
					end

					if var_410_3.prefab_name ~= "" and arg_407_1.actors_[var_410_3.prefab_name] ~= nil then
						local var_410_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_3.prefab_name].transform, "story_v_out_321301", "321301101", "story_v_out_321301.awb")

						arg_407_1:RecordAudio("321301101", var_410_8)
						arg_407_1:RecordAudio("321301101", var_410_8)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_321301", "321301101", "story_v_out_321301.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_321301", "321301101", "story_v_out_321301.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_9 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_9 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_9

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_9 and arg_407_1.time_ < var_410_1 + var_410_9 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play321301102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 321301102
		arg_411_1.duration_ = 5.8

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play321301103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 2 < arg_411_1.time_ and arg_411_1.time_ <= 2 + arg_414_0 then
				local var_414_0 = arg_411_1.bgs_.L09g

				arg_411_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_414_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_414_1 = var_414_0:GetComponent("SpriteRenderer")

				if var_414_1 and var_414_1.sprite then
					local var_414_2 = 2 * (var_414_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_414_0.transform.localScale = Vector3.New(var_414_2 / var_414_1.sprite.bounds.size.y < var_414_2 * manager.ui.mainCameraCom_.aspect / var_414_1.sprite.bounds.size.x and var_414_2 * manager.ui.mainCameraCom_.aspect / var_414_1.sprite.bounds.size.x or var_414_2 / var_414_1.sprite.bounds.size.y, var_414_2 / var_414_1.sprite.bounds.size.y < var_414_2 * manager.ui.mainCameraCom_.aspect / var_414_1.sprite.bounds.size.x and var_414_2 * manager.ui.mainCameraCom_.aspect / var_414_1.sprite.bounds.size.x or var_414_2 / var_414_1.sprite.bounds.size.y, 0)
				end

				for iter_414_0, iter_414_1 in pairs(arg_411_1.bgs_) do
					if iter_414_0 ~= "L09g" then
						iter_414_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_414_3 = 4

			if 4 < arg_411_1.time_ and arg_411_1.time_ <= var_414_3 + arg_414_0 then
				arg_411_1.allBtn_.enabled = false
			end

			if arg_411_1.time_ >= var_414_3 + 0.3 and arg_411_1.time_ < var_414_3 + 0.3 + arg_414_0 then
				arg_411_1.allBtn_.enabled = true
			end

			local var_414_4 = 0

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1.mask_.enabled = true
				arg_411_1.mask_.raycastTarget = true

				arg_411_1:SetGaussion(false)
			end

			local var_414_5 = 2

			if var_414_4 <= arg_411_1.time_ and arg_411_1.time_ < var_414_4 + var_414_5 then
				local var_414_6 = Color.New(0, 0, 0)

				var_414_6.a = Mathf.Lerp(0, 1, (arg_411_1.time_ - var_414_4) / var_414_5)
				arg_411_1.mask_.color = var_414_6
			end

			if arg_411_1.time_ >= var_414_4 + var_414_5 and arg_411_1.time_ < var_414_4 + var_414_5 + arg_414_0 then
				local var_414_7 = Color.New(0, 0, 0)

				var_414_7.a = 1
				arg_411_1.mask_.color = var_414_7
			end

			local var_414_8 = 2

			if 2 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.mask_.enabled = true
				arg_411_1.mask_.raycastTarget = true

				arg_411_1:SetGaussion(false)
			end

			local var_414_9 = 2

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_9 then
				local var_414_10 = Color.New(0, 0, 0)

				var_414_10.a = Mathf.Lerp(1, 0, (arg_411_1.time_ - var_414_8) / var_414_9)
				arg_411_1.mask_.color = var_414_10
			end

			if arg_411_1.time_ >= var_414_8 + var_414_9 and arg_411_1.time_ < var_414_8 + var_414_9 + arg_414_0 then
				local var_414_11 = Color.New(0, 0, 0)

				arg_411_1.mask_.enabled = false
				var_414_11.a = 0
				arg_411_1.mask_.color = var_414_11
			end

			local var_414_12 = arg_411_1.actors_["1111ui_story"].transform

			if 1.96599999815226 < arg_411_1.time_ and arg_411_1.time_ <= 1.96599999815226 + arg_414_0 then
				arg_411_1.var_.moveOldPos1111ui_story = var_414_12.localPosition
			end

			local var_414_13 = 0.001

			if 1.96599999815226 <= arg_411_1.time_ and arg_411_1.time_ < 1.96599999815226 + var_414_13 then
				var_414_12.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_411_1.time_ - 1.96599999815226) / var_414_13)
				var_414_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_12.position).x, (manager.ui.mainCamera.transform.position - var_414_12.position).y, (manager.ui.mainCamera.transform.position - var_414_12.position).z)
				var_414_12.localEulerAngles.z = 0
				var_414_12.localEulerAngles.x = 0
				var_414_12.localEulerAngles = var_414_12.localEulerAngles
			end

			if arg_411_1.time_ >= 1.96599999815226 + var_414_13 and arg_411_1.time_ < 1.96599999815226 + var_414_13 + arg_414_0 then
				var_414_12.localPosition = Vector3.New(0, 100, 0)
				var_414_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_12.position).x, (manager.ui.mainCamera.transform.position - var_414_12.position).y, (manager.ui.mainCamera.transform.position - var_414_12.position).z)
				var_414_12.localEulerAngles.z = 0
				var_414_12.localEulerAngles.x = 0
				var_414_12.localEulerAngles = var_414_12.localEulerAngles
			end

			local var_414_14 = arg_411_1.actors_["1111ui_story"]

			if 1.966 < arg_411_1.time_ and arg_411_1.time_ <= 1.966 + arg_414_0 and not isNil(var_414_14) and arg_411_1.var_.characterEffect1111ui_story == nil then
				arg_411_1.var_.characterEffect1111ui_story = var_414_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_15 = 0.034

			if 1.966 <= arg_411_1.time_ and arg_411_1.time_ < 1.966 + var_414_15 and not isNil(var_414_14) then
				if arg_411_1.var_.characterEffect1111ui_story and not isNil(var_414_14) then
					arg_411_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 1.966) / var_414_15)
				end
			end

			if arg_411_1.time_ >= 1.966 + var_414_15 and arg_411_1.time_ < 1.966 + var_414_15 + arg_414_0 and not isNil(var_414_14) and arg_411_1.var_.characterEffect1111ui_story then
				arg_411_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_414_16 = arg_411_1.actors_["1043ui_story"].transform

			if 3.8 < arg_411_1.time_ and arg_411_1.time_ <= 3.8 + arg_414_0 then
				arg_411_1.var_.moveOldPos1043ui_story = var_414_16.localPosition
			end

			local var_414_17 = 0.001

			if 3.8 <= arg_411_1.time_ and arg_411_1.time_ < 3.8 + var_414_17 then
				var_414_16.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_411_1.time_ - 3.8) / var_414_17)
				var_414_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_16.position).x, (manager.ui.mainCamera.transform.position - var_414_16.position).y, (manager.ui.mainCamera.transform.position - var_414_16.position).z)
				var_414_16.localEulerAngles.z = 0
				var_414_16.localEulerAngles.x = 0
				var_414_16.localEulerAngles = var_414_16.localEulerAngles
			end

			if arg_411_1.time_ >= 3.8 + var_414_17 and arg_411_1.time_ < 3.8 + var_414_17 + arg_414_0 then
				var_414_16.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_414_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_414_16.position).x, (manager.ui.mainCamera.transform.position - var_414_16.position).y, (manager.ui.mainCamera.transform.position - var_414_16.position).z)
				var_414_16.localEulerAngles.z = 0
				var_414_16.localEulerAngles.x = 0
				var_414_16.localEulerAngles = var_414_16.localEulerAngles
			end

			local var_414_18 = arg_411_1.actors_["1043ui_story"]

			if 3.8 < arg_411_1.time_ and arg_411_1.time_ <= 3.8 + arg_414_0 and not isNil(var_414_18) and arg_411_1.var_.characterEffect1043ui_story == nil then
				arg_411_1.var_.characterEffect1043ui_story = var_414_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_19 = 0.200000002980232

			if 3.8 <= arg_411_1.time_ and arg_411_1.time_ < 3.8 + var_414_19 and not isNil(var_414_18) then
				if arg_411_1.var_.characterEffect1043ui_story and not isNil(var_414_18) then
					arg_411_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 3.8 + var_414_19 and arg_411_1.time_ < 3.8 + var_414_19 + arg_414_0 and not isNil(var_414_18) and arg_411_1.var_.characterEffect1043ui_story then
				arg_411_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 3.8 < arg_411_1.time_ and arg_411_1.time_ <= 3.8 + arg_414_0 then
				arg_411_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 3.8 < arg_411_1.time_ and arg_411_1.time_ <= 3.8 + arg_414_0 then
				arg_411_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_411_1.frameCnt_ <= 1 then
				arg_411_1.dialog_:SetActive(false)
			end

			local var_414_21 = 4
			local var_414_22 = 0.1

			if 4 < arg_411_1.time_ and arg_411_1.time_ <= var_414_21 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0

				arg_411_1.dialog_:SetActive(true)

				arg_411_1.dialogCg_.alpha = 0

				local var_414_23 = LeanTween.value(arg_411_1.dialog_, 0, 1, 0.3)

				var_414_23:setOnUpdate(LuaHelper.FloatAction(function(arg_415_0)
					arg_411_1.dialogCg_.alpha = arg_415_0
				end))
				var_414_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_411_1.dialog_)
					var_414_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_411_1.duration_ = arg_411_1.duration_ + 0.3

				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_24 = arg_411_1:GetWordFromCfg(321301102)
				local var_414_25 = arg_411_1:FormatText(var_414_24.content)

				arg_411_1.text_.text = var_414_25

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_27 = 4 <= 0 and var_414_22 or var_414_22 * (utf8.len(var_414_25) / 4)

				if (4 <= 0 and var_414_22 or var_414_22 * (utf8.len(var_414_25) / 4)) > 0 and var_414_22 < var_414_27 then
					arg_411_1.talkMaxDuration = var_414_27
					var_414_21 = var_414_21 + 0.3

					if var_414_27 + var_414_21 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_27 + var_414_21
					end
				end

				arg_411_1.text_.text = var_414_25
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301102", "story_v_out_321301.awb") ~= 0 then
					local var_414_28 = manager.audio:GetVoiceLength("story_v_out_321301", "321301102", "story_v_out_321301.awb") / 1000

					if var_414_28 + var_414_21 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_28 + var_414_21
					end

					if var_414_24.prefab_name ~= "" and arg_411_1.actors_[var_414_24.prefab_name] ~= nil then
						local var_414_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_24.prefab_name].transform, "story_v_out_321301", "321301102", "story_v_out_321301.awb")

						arg_411_1:RecordAudio("321301102", var_414_29)
						arg_411_1:RecordAudio("321301102", var_414_29)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_321301", "321301102", "story_v_out_321301.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_321301", "321301102", "story_v_out_321301.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_30 = var_414_21 + 0.3
			local var_414_31 = math.max(var_414_22, arg_411_1.talkMaxDuration)

			if var_414_21 + 0.3 <= arg_411_1.time_ and arg_411_1.time_ < var_414_30 + var_414_31 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_30) / var_414_31

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_30 + var_414_31 and arg_411_1.time_ < var_414_30 + var_414_31 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play321301103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 321301103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play321301104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1043ui_story = arg_417_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).z)
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles = arg_417_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_417_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1043ui_story"].transform.position).z)
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1043ui_story"].transform.localEulerAngles = arg_417_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["1043ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1043ui_story == nil then
				arg_417_1.var_.characterEffect1043ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect1043ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_2)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1043ui_story then
				arg_417_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_420_3 = 0
			local var_420_4 = 1.175

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_3 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_5 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(321301103).content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 47 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 47)

				if (47 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 47)) > 0 and var_420_4 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_3 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_3
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_4, arg_417_1.talkMaxDuration)

			if var_420_3 <= arg_417_1.time_ and arg_417_1.time_ < var_420_3 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_3) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_3 + var_420_8 and arg_417_1.time_ < var_420_3 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play321301104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 321301104
		arg_421_1.duration_ = 9.53

		local var_421_0 = {
			zh = 8.066,
			ja = 9.533
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play321301105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1111ui_story = arg_421_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1111ui_story"].transform.position).z)
				arg_421_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1111ui_story"].transform.localEulerAngles = arg_421_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_421_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1111ui_story"].transform.position).z)
				arg_421_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1111ui_story"].transform.localEulerAngles = arg_421_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["1111ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1111ui_story == nil then
				arg_421_1.var_.characterEffect1111ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect1111ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1111ui_story then
				arg_421_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_424_4 = 0
			local var_424_5 = 0.95

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_4 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_6 = arg_421_1:GetWordFromCfg(321301104)
				local var_424_7 = arg_421_1:FormatText(var_424_6.content)

				arg_421_1.text_.text = var_424_7

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_9 = 38 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 38)

				if (38 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 38)) > 0 and var_424_5 < var_424_9 then
					arg_421_1.talkMaxDuration = var_424_9

					if var_424_9 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_9 + var_424_4
					end
				end

				arg_421_1.text_.text = var_424_7
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301104", "story_v_out_321301.awb") ~= 0 then
					local var_424_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301104", "story_v_out_321301.awb") / 1000

					if var_424_10 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_10 + var_424_4
					end

					if var_424_6.prefab_name ~= "" and arg_421_1.actors_[var_424_6.prefab_name] ~= nil then
						local var_424_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_6.prefab_name].transform, "story_v_out_321301", "321301104", "story_v_out_321301.awb")

						arg_421_1:RecordAudio("321301104", var_424_11)
						arg_421_1:RecordAudio("321301104", var_424_11)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_321301", "321301104", "story_v_out_321301.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_321301", "321301104", "story_v_out_321301.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_12 = math.max(var_424_5, arg_421_1.talkMaxDuration)

			if var_424_4 <= arg_421_1.time_ and arg_421_1.time_ < var_424_4 + var_424_12 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_4) / var_424_12

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_4 + var_424_12 and arg_421_1.time_ < var_424_4 + var_424_12 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play321301105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 321301105
		arg_425_1.duration_ = 6.7

		local var_425_0 = {
			zh = 6.7,
			ja = 6.233
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play321301106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.75

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_1 = arg_425_1:GetWordFromCfg(321301105)
				local var_428_2 = arg_425_1:FormatText(var_428_1.content)

				arg_425_1.text_.text = var_428_2

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_4 = 30 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 30)

				if (30 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 30)) > 0 and var_428_0 < var_428_4 then
					arg_425_1.talkMaxDuration = var_428_4

					if var_428_4 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_4 + 0
					end
				end

				arg_425_1.text_.text = var_428_2
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301105", "story_v_out_321301.awb") ~= 0 then
					local var_428_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301105", "story_v_out_321301.awb") / 1000

					if var_428_5 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + 0
					end

					if var_428_1.prefab_name ~= "" and arg_425_1.actors_[var_428_1.prefab_name] ~= nil then
						local var_428_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_1.prefab_name].transform, "story_v_out_321301", "321301105", "story_v_out_321301.awb")

						arg_425_1:RecordAudio("321301105", var_428_6)
						arg_425_1:RecordAudio("321301105", var_428_6)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_321301", "321301105", "story_v_out_321301.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_321301", "321301105", "story_v_out_321301.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play321301106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 321301106
		arg_429_1.duration_ = 8.83

		local var_429_0 = {
			zh = 8.833,
			ja = 8.333
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play321301107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 1.15

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:GetWordFromCfg(321301106)
				local var_432_2 = arg_429_1:FormatText(var_432_1.content)

				arg_429_1.text_.text = var_432_2

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 46 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 46)

				if (46 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 46)) > 0 and var_432_0 < var_432_4 then
					arg_429_1.talkMaxDuration = var_432_4

					if var_432_4 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_4 + 0
					end
				end

				arg_429_1.text_.text = var_432_2
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301106", "story_v_out_321301.awb") ~= 0 then
					local var_432_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301106", "story_v_out_321301.awb") / 1000

					if var_432_5 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + 0
					end

					if var_432_1.prefab_name ~= "" and arg_429_1.actors_[var_432_1.prefab_name] ~= nil then
						local var_432_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_1.prefab_name].transform, "story_v_out_321301", "321301106", "story_v_out_321301.awb")

						arg_429_1:RecordAudio("321301106", var_432_6)
						arg_429_1:RecordAudio("321301106", var_432_6)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_321301", "321301106", "story_v_out_321301.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_321301", "321301106", "story_v_out_321301.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_7 and arg_429_1.time_ < 0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play321301107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 321301107
		arg_433_1.duration_ = 2.6

		local var_433_0 = {
			zh = 1.999999999999,
			ja = 2.6
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play321301108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1111ui_story = arg_433_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1111ui_story"].transform.position).z)
				arg_433_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1111ui_story"].transform.localEulerAngles = arg_433_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_433_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1111ui_story"].transform.position).z)
				arg_433_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1111ui_story"].transform.localEulerAngles = arg_433_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1043ui_story"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1043ui_story = var_436_1.localPosition
			end

			local var_436_2 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 then
				var_436_1.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_433_1.time_ - 0) / var_436_2)
				var_436_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_436_1.position).x, (manager.ui.mainCamera.transform.position - var_436_1.position).y, (manager.ui.mainCamera.transform.position - var_436_1.position).z)
				var_436_1.localEulerAngles.z = 0
				var_436_1.localEulerAngles.x = 0
				var_436_1.localEulerAngles = var_436_1.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 then
				var_436_1.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_436_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_436_1.position).x, (manager.ui.mainCamera.transform.position - var_436_1.position).y, (manager.ui.mainCamera.transform.position - var_436_1.position).z)
				var_436_1.localEulerAngles.z = 0
				var_436_1.localEulerAngles.x = 0
				var_436_1.localEulerAngles = var_436_1.localEulerAngles
			end

			local var_436_3 = arg_433_1.actors_["1043ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_3) and arg_433_1.var_.characterEffect1043ui_story == nil then
				arg_433_1.var_.characterEffect1043ui_story = var_436_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_4 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 and not isNil(var_436_3) then
				if arg_433_1.var_.characterEffect1043ui_story and not isNil(var_436_3) then
					arg_433_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 and not isNil(var_436_3) and arg_433_1.var_.characterEffect1043ui_story then
				arg_433_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_436_6 = arg_433_1.actors_["1111ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_6) and arg_433_1.var_.characterEffect1111ui_story == nil then
				arg_433_1.var_.characterEffect1111ui_story = var_436_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_7 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_7 and not isNil(var_436_6) then
				if arg_433_1.var_.characterEffect1111ui_story and not isNil(var_436_6) then
					arg_433_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_7)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_7 and arg_433_1.time_ < 0 + var_436_7 + arg_436_0 and not isNil(var_436_6) and arg_433_1.var_.characterEffect1111ui_story then
				arg_433_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_436_8 = 0
			local var_436_9 = 0.225

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_8 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_10 = arg_433_1:GetWordFromCfg(321301107)
				local var_436_11 = arg_433_1:FormatText(var_436_10.content)

				arg_433_1.text_.text = var_436_11

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_13 = 9 <= 0 and var_436_9 or var_436_9 * (utf8.len(var_436_11) / 9)

				if (9 <= 0 and var_436_9 or var_436_9 * (utf8.len(var_436_11) / 9)) > 0 and var_436_9 < var_436_13 then
					arg_433_1.talkMaxDuration = var_436_13

					if var_436_13 + var_436_8 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_13 + var_436_8
					end
				end

				arg_433_1.text_.text = var_436_11
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301107", "story_v_out_321301.awb") ~= 0 then
					local var_436_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301107", "story_v_out_321301.awb") / 1000

					if var_436_14 + var_436_8 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_14 + var_436_8
					end

					if var_436_10.prefab_name ~= "" and arg_433_1.actors_[var_436_10.prefab_name] ~= nil then
						local var_436_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_10.prefab_name].transform, "story_v_out_321301", "321301107", "story_v_out_321301.awb")

						arg_433_1:RecordAudio("321301107", var_436_15)
						arg_433_1:RecordAudio("321301107", var_436_15)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_321301", "321301107", "story_v_out_321301.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_321301", "321301107", "story_v_out_321301.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_16 = math.max(var_436_9, arg_433_1.talkMaxDuration)

			if var_436_8 <= arg_433_1.time_ and arg_433_1.time_ < var_436_8 + var_436_16 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_8) / var_436_16

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_8 + var_436_16 and arg_433_1.time_ < var_436_8 + var_436_16 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play321301108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 321301108
		arg_437_1.duration_ = 3.6

		local var_437_0 = {
			zh = 3.6,
			ja = 2.7
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play321301109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1111ui_story"]) and arg_437_1.var_.characterEffect1111ui_story == nil then
				arg_437_1.var_.characterEffect1111ui_story = arg_437_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1111ui_story"]) then
				if arg_437_1.var_.characterEffect1111ui_story and not isNil(arg_437_1.actors_["1111ui_story"]) then
					arg_437_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1111ui_story"]) and arg_437_1.var_.characterEffect1111ui_story then
				arg_437_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_440_2 = arg_437_1.actors_["1043ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_2) and arg_437_1.var_.characterEffect1043ui_story == nil then
				arg_437_1.var_.characterEffect1043ui_story = var_440_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_3 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_3 and not isNil(var_440_2) then
				if arg_437_1.var_.characterEffect1043ui_story and not isNil(var_440_2) then
					arg_437_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_3)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_3 and arg_437_1.time_ < 0 + var_440_3 + arg_440_0 and not isNil(var_440_2) and arg_437_1.var_.characterEffect1043ui_story then
				arg_437_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_440_4 = 0
			local var_440_5 = 0.375

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(321301108)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 15 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 15)

				if (15 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 15)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301108", "story_v_out_321301.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301108", "story_v_out_321301.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_out_321301", "321301108", "story_v_out_321301.awb")

						arg_437_1:RecordAudio("321301108", var_440_11)
						arg_437_1:RecordAudio("321301108", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_321301", "321301108", "story_v_out_321301.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_321301", "321301108", "story_v_out_321301.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_12 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_12 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_12

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_12 and arg_437_1.time_ < var_440_4 + var_440_12 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play321301109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 321301109
		arg_441_1.duration_ = 4.2

		local var_441_0 = {
			zh = 3.5,
			ja = 4.2
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play321301110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.35

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:GetWordFromCfg(321301109)
				local var_444_2 = arg_441_1:FormatText(var_444_1.content)

				arg_441_1.text_.text = var_444_2

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 14 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 14)

				if (14 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 14)) > 0 and var_444_0 < var_444_4 then
					arg_441_1.talkMaxDuration = var_444_4

					if var_444_4 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_4 + 0
					end
				end

				arg_441_1.text_.text = var_444_2
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301109", "story_v_out_321301.awb") ~= 0 then
					local var_444_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301109", "story_v_out_321301.awb") / 1000

					if var_444_5 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + 0
					end

					if var_444_1.prefab_name ~= "" and arg_441_1.actors_[var_444_1.prefab_name] ~= nil then
						local var_444_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_1.prefab_name].transform, "story_v_out_321301", "321301109", "story_v_out_321301.awb")

						arg_441_1:RecordAudio("321301109", var_444_6)
						arg_441_1:RecordAudio("321301109", var_444_6)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_321301", "321301109", "story_v_out_321301.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_321301", "321301109", "story_v_out_321301.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_7 and arg_441_1.time_ < 0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play321301110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 321301110
		arg_445_1.duration_ = 5.4

		local var_445_0 = {
			zh = 3.3,
			ja = 5.4
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play321301111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1043ui_story"]) and arg_445_1.var_.characterEffect1043ui_story == nil then
				arg_445_1.var_.characterEffect1043ui_story = arg_445_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1043ui_story"]) then
				if arg_445_1.var_.characterEffect1043ui_story and not isNil(arg_445_1.actors_["1043ui_story"]) then
					arg_445_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1043ui_story"]) and arg_445_1.var_.characterEffect1043ui_story then
				arg_445_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_448_2 = arg_445_1.actors_["1111ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_2) and arg_445_1.var_.characterEffect1111ui_story == nil then
				arg_445_1.var_.characterEffect1111ui_story = var_448_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_3 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_3 and not isNil(var_448_2) then
				if arg_445_1.var_.characterEffect1111ui_story and not isNil(var_448_2) then
					arg_445_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_3)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_3 and arg_445_1.time_ < 0 + var_448_3 + arg_448_0 and not isNil(var_448_2) and arg_445_1.var_.characterEffect1111ui_story then
				arg_445_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043actionlink/1043action425")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_448_4 = 0
			local var_448_5 = 0.4

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_6 = arg_445_1:GetWordFromCfg(321301110)
				local var_448_7 = arg_445_1:FormatText(var_448_6.content)

				arg_445_1.text_.text = var_448_7

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_9 = 16 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 16)

				if (16 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 16)) > 0 and var_448_5 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_4
					end
				end

				arg_445_1.text_.text = var_448_7
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301110", "story_v_out_321301.awb") ~= 0 then
					local var_448_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301110", "story_v_out_321301.awb") / 1000

					if var_448_10 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_4
					end

					if var_448_6.prefab_name ~= "" and arg_445_1.actors_[var_448_6.prefab_name] ~= nil then
						local var_448_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_6.prefab_name].transform, "story_v_out_321301", "321301110", "story_v_out_321301.awb")

						arg_445_1:RecordAudio("321301110", var_448_11)
						arg_445_1:RecordAudio("321301110", var_448_11)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_321301", "321301110", "story_v_out_321301.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_321301", "321301110", "story_v_out_321301.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_12 = math.max(var_448_5, arg_445_1.talkMaxDuration)

			if var_448_4 <= arg_445_1.time_ and arg_445_1.time_ < var_448_4 + var_448_12 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_4) / var_448_12

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_4 + var_448_12 and arg_445_1.time_ < var_448_4 + var_448_12 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play321301111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 321301111
		arg_449_1.duration_ = 4.57

		local var_449_0 = {
			zh = 3.866,
			ja = 4.566
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play321301112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1111ui_story"]) and arg_449_1.var_.characterEffect1111ui_story == nil then
				arg_449_1.var_.characterEffect1111ui_story = arg_449_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1111ui_story"]) then
				if arg_449_1.var_.characterEffect1111ui_story and not isNil(arg_449_1.actors_["1111ui_story"]) then
					arg_449_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1111ui_story"]) and arg_449_1.var_.characterEffect1111ui_story then
				arg_449_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_452_2 = arg_449_1.actors_["1043ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_2) and arg_449_1.var_.characterEffect1043ui_story == nil then
				arg_449_1.var_.characterEffect1043ui_story = var_452_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_3 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_3 and not isNil(var_452_2) then
				if arg_449_1.var_.characterEffect1043ui_story and not isNil(var_452_2) then
					arg_449_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_3)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_3 and arg_449_1.time_ < 0 + var_452_3 + arg_452_0 and not isNil(var_452_2) and arg_449_1.var_.characterEffect1043ui_story then
				arg_449_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_452_4 = 0
			local var_452_5 = 0.35

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_4 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_6 = arg_449_1:GetWordFromCfg(321301111)
				local var_452_7 = arg_449_1:FormatText(var_452_6.content)

				arg_449_1.text_.text = var_452_7

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_9 = 14 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 14)

				if (14 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 14)) > 0 and var_452_5 < var_452_9 then
					arg_449_1.talkMaxDuration = var_452_9

					if var_452_9 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_9 + var_452_4
					end
				end

				arg_449_1.text_.text = var_452_7
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301111", "story_v_out_321301.awb") ~= 0 then
					local var_452_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301111", "story_v_out_321301.awb") / 1000

					if var_452_10 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_4
					end

					if var_452_6.prefab_name ~= "" and arg_449_1.actors_[var_452_6.prefab_name] ~= nil then
						local var_452_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_6.prefab_name].transform, "story_v_out_321301", "321301111", "story_v_out_321301.awb")

						arg_449_1:RecordAudio("321301111", var_452_11)
						arg_449_1:RecordAudio("321301111", var_452_11)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_321301", "321301111", "story_v_out_321301.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_321301", "321301111", "story_v_out_321301.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_12 = math.max(var_452_5, arg_449_1.talkMaxDuration)

			if var_452_4 <= arg_449_1.time_ and arg_449_1.time_ < var_452_4 + var_452_12 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_4) / var_452_12

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_4 + var_452_12 and arg_449_1.time_ < var_452_4 + var_452_12 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play321301112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 321301112
		arg_453_1.duration_ = 5.33

		local var_453_0 = {
			zh = 4.166,
			ja = 5.333
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play321301113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.525

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_1 = arg_453_1:GetWordFromCfg(321301112)
				local var_456_2 = arg_453_1:FormatText(var_456_1.content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 21 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 21)

				if (21 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 21)) > 0 and var_456_0 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + 0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301112", "story_v_out_321301.awb") ~= 0 then
					local var_456_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301112", "story_v_out_321301.awb") / 1000

					if var_456_5 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + 0
					end

					if var_456_1.prefab_name ~= "" and arg_453_1.actors_[var_456_1.prefab_name] ~= nil then
						local var_456_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_1.prefab_name].transform, "story_v_out_321301", "321301112", "story_v_out_321301.awb")

						arg_453_1:RecordAudio("321301112", var_456_6)
						arg_453_1:RecordAudio("321301112", var_456_6)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_321301", "321301112", "story_v_out_321301.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_321301", "321301112", "story_v_out_321301.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play321301113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 321301113
		arg_457_1.duration_ = 9.4

		local var_457_0 = {
			zh = 7.333,
			ja = 9.4
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play321301114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1043ui_story = arg_457_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1043ui_story"].transform.position).z)
				arg_457_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1043ui_story"].transform.localEulerAngles = arg_457_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_457_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1043ui_story"].transform.position).z)
				arg_457_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1043ui_story"].transform.localEulerAngles = arg_457_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["10131ui_story"].transform

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10131ui_story = var_460_1.localPosition
			end

			local var_460_2 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 then
				var_460_1.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_457_1.time_ - 0) / var_460_2)
				var_460_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_1.position).x, (manager.ui.mainCamera.transform.position - var_460_1.position).y, (manager.ui.mainCamera.transform.position - var_460_1.position).z)
				var_460_1.localEulerAngles.z = 0
				var_460_1.localEulerAngles.x = 0
				var_460_1.localEulerAngles = var_460_1.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 then
				var_460_1.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_460_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_1.position).x, (manager.ui.mainCamera.transform.position - var_460_1.position).y, (manager.ui.mainCamera.transform.position - var_460_1.position).z)
				var_460_1.localEulerAngles.z = 0
				var_460_1.localEulerAngles.x = 0
				var_460_1.localEulerAngles = var_460_1.localEulerAngles
			end

			local var_460_3 = arg_457_1.actors_["10131ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_3) and arg_457_1.var_.characterEffect10131ui_story == nil then
				arg_457_1.var_.characterEffect10131ui_story = var_460_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_4 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 and not isNil(var_460_3) then
				if arg_457_1.var_.characterEffect10131ui_story and not isNil(var_460_3) then
					arg_457_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 and not isNil(var_460_3) and arg_457_1.var_.characterEffect10131ui_story then
				arg_457_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_460_6 = arg_457_1.actors_["1111ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_6) and arg_457_1.var_.characterEffect1111ui_story == nil then
				arg_457_1.var_.characterEffect1111ui_story = var_460_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_7 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 and not isNil(var_460_6) then
				if arg_457_1.var_.characterEffect1111ui_story and not isNil(var_460_6) then
					arg_457_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_7)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 and not isNil(var_460_6) and arg_457_1.var_.characterEffect1111ui_story then
				arg_457_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_460_8 = 0
			local var_460_9 = 0.725

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_8 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_10 = arg_457_1:GetWordFromCfg(321301113)
				local var_460_11 = arg_457_1:FormatText(var_460_10.content)

				arg_457_1.text_.text = var_460_11

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_13 = 29 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_11) / 29)

				if (29 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_11) / 29)) > 0 and var_460_9 < var_460_13 then
					arg_457_1.talkMaxDuration = var_460_13

					if var_460_13 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_13 + var_460_8
					end
				end

				arg_457_1.text_.text = var_460_11
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301113", "story_v_out_321301.awb") ~= 0 then
					local var_460_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301113", "story_v_out_321301.awb") / 1000

					if var_460_14 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_14 + var_460_8
					end

					if var_460_10.prefab_name ~= "" and arg_457_1.actors_[var_460_10.prefab_name] ~= nil then
						local var_460_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_10.prefab_name].transform, "story_v_out_321301", "321301113", "story_v_out_321301.awb")

						arg_457_1:RecordAudio("321301113", var_460_15)
						arg_457_1:RecordAudio("321301113", var_460_15)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_321301", "321301113", "story_v_out_321301.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_321301", "321301113", "story_v_out_321301.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_16 = math.max(var_460_9, arg_457_1.talkMaxDuration)

			if var_460_8 <= arg_457_1.time_ and arg_457_1.time_ < var_460_8 + var_460_16 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_8) / var_460_16

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_8 + var_460_16 and arg_457_1.time_ < var_460_8 + var_460_16 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play321301114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 321301114
		arg_461_1.duration_ = 9

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play321301115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_9002
			local var_464_9001
			local var_464_9000

			if arg_461_1.bgs_.L09h == nil then
				local var_464_0 = Object.Instantiate(arg_461_1.paintGo_)

				var_464_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09h")
				var_464_0.name = "L09h"
				var_464_0.transform.parent = arg_461_1.stage_.transform
				var_464_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_461_1.bgs_.L09h = var_464_0
			end

			if 1.999999999999 < arg_461_1.time_ and arg_461_1.time_ <= 1.999999999999 + arg_464_0 then
				local var_464_1 = arg_461_1.bgs_.L09h

				arg_461_1.bgs_.L09h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_464_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_464_2 = var_464_1:GetComponent("SpriteRenderer")

				if var_464_2 and var_464_2.sprite then
					local var_464_3 = 2 * (var_464_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_464_1.transform.localScale = Vector3.New(var_464_3 / var_464_2.sprite.bounds.size.y < var_464_3 * manager.ui.mainCameraCom_.aspect / var_464_2.sprite.bounds.size.x and var_464_3 * manager.ui.mainCameraCom_.aspect / var_464_2.sprite.bounds.size.x or var_464_3 / var_464_2.sprite.bounds.size.y, var_464_3 / var_464_2.sprite.bounds.size.y < var_464_3 * manager.ui.mainCameraCom_.aspect / var_464_2.sprite.bounds.size.x and var_464_3 * manager.ui.mainCameraCom_.aspect / var_464_2.sprite.bounds.size.x or var_464_3 / var_464_2.sprite.bounds.size.y, 0)
				end

				for iter_464_0, iter_464_1 in pairs(arg_461_1.bgs_) do
					if iter_464_0 ~= "L09h" then
						iter_464_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_464_4 = 3.999999999999

			if 3.999999999999 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1.allBtn_.enabled = false
			end

			if arg_461_1.time_ >= var_464_4 + 0.3 and arg_461_1.time_ < var_464_4 + 0.3 + arg_464_0 then
				arg_461_1.allBtn_.enabled = true
			end

			local var_464_5 = 0

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.mask_.enabled = true
				arg_461_1.mask_.raycastTarget = true

				arg_461_1:SetGaussion(false)
			end

			local var_464_6 = 2

			if var_464_5 <= arg_461_1.time_ and arg_461_1.time_ < var_464_5 + var_464_6 then
				local var_464_7 = Color.New(0, 0, 0)

				var_464_7.a = Mathf.Lerp(0, 1, (arg_461_1.time_ - var_464_5) / var_464_6)
				arg_461_1.mask_.color = var_464_7
			end

			if arg_461_1.time_ >= var_464_5 + var_464_6 and arg_461_1.time_ < var_464_5 + var_464_6 + arg_464_0 then
				local var_464_8 = Color.New(0, 0, 0)

				var_464_8.a = 1
				arg_461_1.mask_.color = var_464_8
			end

			local var_464_9 = 2

			if 2 < arg_461_1.time_ and arg_461_1.time_ <= var_464_9 + arg_464_0 then
				arg_461_1.mask_.enabled = true
				arg_461_1.mask_.raycastTarget = true

				arg_461_1:SetGaussion(false)
			end

			local var_464_10 = 2

			if var_464_9 <= arg_461_1.time_ and arg_461_1.time_ < var_464_9 + var_464_10 then
				local var_464_11 = Color.New(0, 0, 0)

				var_464_11.a = Mathf.Lerp(1, 0, (arg_461_1.time_ - var_464_9) / var_464_10)
				arg_461_1.mask_.color = var_464_11
			end

			if arg_461_1.time_ >= var_464_9 + var_464_10 and arg_461_1.time_ < var_464_9 + var_464_10 + arg_464_0 then
				local var_464_12 = Color.New(0, 0, 0)

				arg_461_1.mask_.enabled = false
				var_464_12.a = 0
				arg_461_1.mask_.color = var_464_12
			end

			local var_464_13 = arg_461_1.actors_["1111ui_story"].transform

			if 1.96599999815226 < arg_461_1.time_ and arg_461_1.time_ <= 1.96599999815226 + arg_464_0 then
				arg_461_1.var_.moveOldPos1111ui_story = var_464_13.localPosition
			end

			local var_464_14 = 0.001

			if 1.96599999815226 <= arg_461_1.time_ and arg_461_1.time_ < 1.96599999815226 + var_464_14 then
				var_464_13.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_461_1.time_ - 1.96599999815226) / var_464_14)
				var_464_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_13.position).x, (manager.ui.mainCamera.transform.position - var_464_13.position).y, (manager.ui.mainCamera.transform.position - var_464_13.position).z)
				var_464_13.localEulerAngles.z = 0
				var_464_13.localEulerAngles.x = 0
				var_464_13.localEulerAngles = var_464_13.localEulerAngles
			end

			if arg_461_1.time_ >= 1.96599999815226 + var_464_14 and arg_461_1.time_ < 1.96599999815226 + var_464_14 + arg_464_0 then
				var_464_13.localPosition = Vector3.New(0, 100, 0)
				var_464_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_13.position).x, (manager.ui.mainCamera.transform.position - var_464_13.position).y, (manager.ui.mainCamera.transform.position - var_464_13.position).z)
				var_464_13.localEulerAngles.z = 0
				var_464_13.localEulerAngles.x = 0
				var_464_13.localEulerAngles = var_464_13.localEulerAngles
			end

			local var_464_15 = arg_461_1.actors_["10131ui_story"].transform

			if 1.96599999815226 < arg_461_1.time_ and arg_461_1.time_ <= 1.96599999815226 + arg_464_0 then
				arg_461_1.var_.moveOldPos10131ui_story = var_464_15.localPosition
			end

			local var_464_16 = 0.001

			if 1.96599999815226 <= arg_461_1.time_ and arg_461_1.time_ < 1.96599999815226 + var_464_16 then
				var_464_15.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_461_1.time_ - 1.96599999815226) / var_464_16)
				var_464_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_15.position).x, (manager.ui.mainCamera.transform.position - var_464_15.position).y, (manager.ui.mainCamera.transform.position - var_464_15.position).z)
				var_464_15.localEulerAngles.z = 0
				var_464_15.localEulerAngles.x = 0
				var_464_15.localEulerAngles = var_464_15.localEulerAngles
			end

			if arg_461_1.time_ >= 1.96599999815226 + var_464_16 and arg_461_1.time_ < 1.96599999815226 + var_464_16 + arg_464_0 then
				var_464_15.localPosition = Vector3.New(0, 100, 0)
				var_464_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_15.position).x, (manager.ui.mainCamera.transform.position - var_464_15.position).y, (manager.ui.mainCamera.transform.position - var_464_15.position).z)
				var_464_15.localEulerAngles.z = 0
				var_464_15.localEulerAngles.x = 0
				var_464_15.localEulerAngles = var_464_15.localEulerAngles
			end

			local var_464_17 = arg_461_1.actors_["10131ui_story"]

			if 1.96599999815226 < arg_461_1.time_ and arg_461_1.time_ <= 1.96599999815226 + arg_464_0 and not isNil(var_464_17) and arg_461_1.var_.characterEffect10131ui_story == nil then
				arg_461_1.var_.characterEffect10131ui_story = var_464_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_18 = 0.034000001847744

			if 1.96599999815226 <= arg_461_1.time_ and arg_461_1.time_ < 1.96599999815226 + var_464_18 and not isNil(var_464_17) then
				if arg_461_1.var_.characterEffect10131ui_story and not isNil(var_464_17) then
					arg_461_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 1.96599999815226) / var_464_18)
				end
			end

			if arg_461_1.time_ >= 1.96599999815226 + var_464_18 and arg_461_1.time_ < 1.96599999815226 + var_464_18 + arg_464_0 and not isNil(var_464_17) and arg_461_1.var_.characterEffect10131ui_story then
				arg_461_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_464_19 = manager.ui.mainCamera.transform

			if 2.8 < arg_461_1.time_ and arg_461_1.time_ <= 2.8 + arg_464_0 then
				arg_461_1.var_.shakeOldPos = var_464_19.localPosition
			end

			local var_464_20 = 1

			if 2.8 <= arg_461_1.time_ and arg_461_1.time_ < 2.8 + var_464_20 then
				local var_464_21, var_464_22 = math.modf((arg_461_1.time_ - 2.8) / 0.066)

				var_464_19.localPosition = Vector3.New(var_464_22 * 0.13, var_464_22 * 0.13, var_464_22 * 0.13) + arg_461_1.var_.shakeOldPos
			end

			if arg_461_1.time_ >= 2.8 + var_464_20 and arg_461_1.time_ < 2.8 + var_464_20 + arg_464_0 then
				var_464_19.localPosition = arg_461_1.var_.shakeOldPos
			end

			local var_464_23 = 3.8

			if 3.8 < arg_461_1.time_ and arg_461_1.time_ <= var_464_23 + arg_464_0 then
				arg_461_1.allBtn_.enabled = false
			end

			if arg_461_1.time_ >= var_464_23 + 1.000001 and arg_461_1.time_ < var_464_23 + 1.000001 + arg_464_0 then
				arg_461_1.allBtn_.enabled = true
			end

			if 2.8 < arg_461_1.time_ and arg_461_1.time_ <= 2.8 + arg_464_0 then
				local var_464_24 = arg_461_1.var_.effectliandaohengsao2

				if not arg_461_1.var_.effectliandaohengsao2 then
					var_464_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_464_24.name = "liandaohengsao2"
					arg_461_1.var_.effectliandaohengsao2 = var_464_24
				else
					var_464_24.transform:SetParent(var_464_9002)
				end

				var_464_24.transform.localPosition = Vector3.New(0, 0, -1.9)
				var_464_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.600001 < arg_461_1.time_ and arg_461_1.time_ <= 4.600001 + arg_464_0 then
				if arg_461_1.var_.effectliandaohengsao2 then
					Object.Destroy(arg_461_1.var_.effectliandaohengsao2)

					arg_461_1.var_.effectliandaohengsao2 = nil
				end
			end

			if 2.8 < arg_461_1.time_ and arg_461_1.time_ <= 2.8 + arg_464_0 then
				local var_464_27 = arg_461_1.var_.effectliandaohengsao3

				if not arg_461_1.var_.effectliandaohengsao3 then
					var_464_27 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_464_27.name = "liandaohengsao3"
					arg_461_1.var_.effectliandaohengsao3 = var_464_27
				else
					var_464_27.transform:SetParent(var_464_9001)
				end

				var_464_27.transform.localPosition = Vector3.New(1.15, -0.57, -3.92)
				var_464_27.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.600001 < arg_461_1.time_ and arg_461_1.time_ <= 4.600001 + arg_464_0 then
				if arg_461_1.var_.effectliandaohengsao3 then
					Object.Destroy(arg_461_1.var_.effectliandaohengsao3)

					arg_461_1.var_.effectliandaohengsao3 = nil
				end
			end

			if 2.8 < arg_461_1.time_ and arg_461_1.time_ <= 2.8 + arg_464_0 then
				local var_464_30 = arg_461_1.var_.effectliandaohengsao4

				if not arg_461_1.var_.effectliandaohengsao4 then
					var_464_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_464_30.name = "liandaohengsao4"
					arg_461_1.var_.effectliandaohengsao4 = var_464_30
				else
					var_464_30.transform:SetParent(var_464_9000)
				end

				var_464_30.transform.localPosition = Vector3.New(0, 0, -1.9)
				var_464_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.600001 < arg_461_1.time_ and arg_461_1.time_ <= 4.600001 + arg_464_0 then
				if arg_461_1.var_.effectliandaohengsao4 then
					Object.Destroy(arg_461_1.var_.effectliandaohengsao4)

					arg_461_1.var_.effectliandaohengsao4 = nil
				end
			end

			if 2 < arg_461_1.time_ and arg_461_1.time_ <= 2 + arg_464_0 then
				arg_461_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe1", "")
			end

			if arg_461_1.frameCnt_ <= 1 then
				arg_461_1.dialog_:SetActive(false)
			end

			local var_464_34 = 4
			local var_464_35 = 1.3

			if 4 < arg_461_1.time_ and arg_461_1.time_ <= var_464_34 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0

				arg_461_1.dialog_:SetActive(true)

				arg_461_1.dialogCg_.alpha = 0

				local var_464_36 = LeanTween.value(arg_461_1.dialog_, 0, 1, 0.3)

				var_464_36:setOnUpdate(LuaHelper.FloatAction(function(arg_465_0)
					arg_461_1.dialogCg_.alpha = arg_465_0
				end))
				var_464_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_461_1.dialog_)
					var_464_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_461_1.duration_ = arg_461_1.duration_ + 0.3

				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_37 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(321301114).content)

				arg_461_1.text_.text = var_464_37

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_39 = 52 <= 0 and var_464_35 or var_464_35 * (utf8.len(var_464_37) / 52)

				if (52 <= 0 and var_464_35 or var_464_35 * (utf8.len(var_464_37) / 52)) > 0 and var_464_35 < var_464_39 then
					arg_461_1.talkMaxDuration = var_464_39
					var_464_34 = var_464_34 + 0.3

					if var_464_39 + var_464_34 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_39 + var_464_34
					end
				end

				arg_461_1.text_.text = var_464_37
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_40 = var_464_34 + 0.3
			local var_464_41 = math.max(var_464_35, arg_461_1.talkMaxDuration)

			if var_464_34 + 0.3 <= arg_461_1.time_ and arg_461_1.time_ < var_464_40 + var_464_41 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_40) / var_464_41

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_40 + var_464_41 and arg_461_1.time_ < var_464_40 + var_464_41 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play321301115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 321301115
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play321301116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 1.475

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, false)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_1 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(321301115).content)

				arg_467_1.text_.text = var_470_1

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_3 = 59 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 59)

				if (59 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 59)) > 0 and var_470_0 < var_470_3 then
					arg_467_1.talkMaxDuration = var_470_3

					if var_470_3 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_3 + 0
					end
				end

				arg_467_1.text_.text = var_470_1
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_4 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_4 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_4

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_4 and arg_467_1.time_ < 0 + var_470_4 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play321301116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 321301116
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play321301117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0.05 < arg_471_1.time_ and arg_471_1.time_ <= 0.05 + arg_474_0 then
				arg_471_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe5", "")
			end

			local var_474_1 = 0
			local var_474_2 = 1.2

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_3 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(321301116).content)

				arg_471_1.text_.text = var_474_3

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 48 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 48)

				if (48 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_3) / 48)) > 0 and var_474_2 < var_474_5 then
					arg_471_1.talkMaxDuration = var_474_5

					if var_474_5 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_5 + var_474_1
					end
				end

				arg_471_1.text_.text = var_474_3
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_6 = math.max(var_474_2, arg_471_1.talkMaxDuration)

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_6 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_1) / var_474_6

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_1 + var_474_6 and arg_471_1.time_ < var_474_1 + var_474_6 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play321301117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 321301117
		arg_475_1.duration_ = 4.17

		local var_475_0 = {
			zh = 4.166,
			ja = 3.7
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play321301118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos1111ui_story = arg_475_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_478_0 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 then
				arg_475_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_475_1.time_ - 0) / var_478_0)
				arg_475_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1111ui_story"].transform.position).z)
				arg_475_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1111ui_story"].transform.localEulerAngles = arg_475_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 then
				arg_475_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_475_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_475_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_475_1.actors_["1111ui_story"].transform.position).z)
				arg_475_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_475_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_475_1.actors_["1111ui_story"].transform.localEulerAngles = arg_475_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_478_1 = arg_475_1.actors_["1111ui_story"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1111ui_story == nil then
				arg_475_1.var_.characterEffect1111ui_story = var_478_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_2 and not isNil(var_478_1) then
				if arg_475_1.var_.characterEffect1111ui_story and not isNil(var_478_1) then
					arg_475_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_2 and arg_475_1.time_ < 0 + var_478_2 + arg_478_0 and not isNil(var_478_1) and arg_475_1.var_.characterEffect1111ui_story then
				arg_475_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_478_4 = 0
			local var_478_5 = 0.4

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_6 = arg_475_1:GetWordFromCfg(321301117)
				local var_478_7 = arg_475_1:FormatText(var_478_6.content)

				arg_475_1.text_.text = var_478_7

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_9 = 16 <= 0 and var_478_5 or var_478_5 * (utf8.len(var_478_7) / 16)

				if (16 <= 0 and var_478_5 or var_478_5 * (utf8.len(var_478_7) / 16)) > 0 and var_478_5 < var_478_9 then
					arg_475_1.talkMaxDuration = var_478_9

					if var_478_9 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_9 + var_478_4
					end
				end

				arg_475_1.text_.text = var_478_7
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301117", "story_v_out_321301.awb") ~= 0 then
					local var_478_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301117", "story_v_out_321301.awb") / 1000

					if var_478_10 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_10 + var_478_4
					end

					if var_478_6.prefab_name ~= "" and arg_475_1.actors_[var_478_6.prefab_name] ~= nil then
						local var_478_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_6.prefab_name].transform, "story_v_out_321301", "321301117", "story_v_out_321301.awb")

						arg_475_1:RecordAudio("321301117", var_478_11)
						arg_475_1:RecordAudio("321301117", var_478_11)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_321301", "321301117", "story_v_out_321301.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_321301", "321301117", "story_v_out_321301.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_12 = math.max(var_478_5, arg_475_1.talkMaxDuration)

			if var_478_4 <= arg_475_1.time_ and arg_475_1.time_ < var_478_4 + var_478_12 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_4) / var_478_12

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_4 + var_478_12 and arg_475_1.time_ < var_478_4 + var_478_12 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play321301118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 321301118
		arg_479_1.duration_ = 1.8

		local var_479_0 = {
			zh = 0.999999999999,
			ja = 1.8
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play321301119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos1111ui_story = arg_479_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_482_0 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 then
				arg_479_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_479_1.time_ - 0) / var_482_0)
				arg_479_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1111ui_story"].transform.position).z)
				arg_479_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1111ui_story"].transform.localEulerAngles = arg_479_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 then
				arg_479_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_479_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1111ui_story"].transform.position).z)
				arg_479_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1111ui_story"].transform.localEulerAngles = arg_479_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_482_1 = arg_479_1.actors_["10131ui_story"].transform

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos10131ui_story = var_482_1.localPosition
			end

			local var_482_2 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_2 then
				var_482_1.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10131ui_story, Vector3.New(0.05, -0.96, -5.8), (arg_479_1.time_ - 0) / var_482_2)
				var_482_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_482_1.position).x, (manager.ui.mainCamera.transform.position - var_482_1.position).y, (manager.ui.mainCamera.transform.position - var_482_1.position).z)
				var_482_1.localEulerAngles.z = 0
				var_482_1.localEulerAngles.x = 0
				var_482_1.localEulerAngles = var_482_1.localEulerAngles
			end

			if arg_479_1.time_ >= 0 + var_482_2 and arg_479_1.time_ < 0 + var_482_2 + arg_482_0 then
				var_482_1.localPosition = Vector3.New(0.05, -0.96, -5.8)
				var_482_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_482_1.position).x, (manager.ui.mainCamera.transform.position - var_482_1.position).y, (manager.ui.mainCamera.transform.position - var_482_1.position).z)
				var_482_1.localEulerAngles.z = 0
				var_482_1.localEulerAngles.x = 0
				var_482_1.localEulerAngles = var_482_1.localEulerAngles
			end

			local var_482_3 = arg_479_1.actors_["10131ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_3) and arg_479_1.var_.characterEffect10131ui_story == nil then
				arg_479_1.var_.characterEffect10131ui_story = var_482_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_4 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_4 and not isNil(var_482_3) then
				if arg_479_1.var_.characterEffect10131ui_story and not isNil(var_482_3) then
					arg_479_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= 0 + var_482_4 and arg_479_1.time_ < 0 + var_482_4 + arg_482_0 and not isNil(var_482_3) and arg_479_1.var_.characterEffect10131ui_story then
				arg_479_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_482_6 = arg_479_1.actors_["1111ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_6) and arg_479_1.var_.characterEffect1111ui_story == nil then
				arg_479_1.var_.characterEffect1111ui_story = var_482_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_7 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 and not isNil(var_482_6) then
				if arg_479_1.var_.characterEffect1111ui_story and not isNil(var_482_6) then
					arg_479_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_7)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 and not isNil(var_482_6) and arg_479_1.var_.characterEffect1111ui_story then
				arg_479_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_482_8 = 0
			local var_482_9 = 0.075

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_8 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_10 = arg_479_1:GetWordFromCfg(321301118)
				local var_482_11 = arg_479_1:FormatText(var_482_10.content)

				arg_479_1.text_.text = var_482_11

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_13 = 3 <= 0 and var_482_9 or var_482_9 * (utf8.len(var_482_11) / 3)

				if (3 <= 0 and var_482_9 or var_482_9 * (utf8.len(var_482_11) / 3)) > 0 and var_482_9 < var_482_13 then
					arg_479_1.talkMaxDuration = var_482_13

					if var_482_13 + var_482_8 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_13 + var_482_8
					end
				end

				arg_479_1.text_.text = var_482_11
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301118", "story_v_out_321301.awb") ~= 0 then
					local var_482_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301118", "story_v_out_321301.awb") / 1000

					if var_482_14 + var_482_8 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_14 + var_482_8
					end

					if var_482_10.prefab_name ~= "" and arg_479_1.actors_[var_482_10.prefab_name] ~= nil then
						local var_482_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_10.prefab_name].transform, "story_v_out_321301", "321301118", "story_v_out_321301.awb")

						arg_479_1:RecordAudio("321301118", var_482_15)
						arg_479_1:RecordAudio("321301118", var_482_15)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_321301", "321301118", "story_v_out_321301.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_321301", "321301118", "story_v_out_321301.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_16 = math.max(var_482_9, arg_479_1.talkMaxDuration)

			if var_482_8 <= arg_479_1.time_ and arg_479_1.time_ < var_482_8 + var_482_16 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_8) / var_482_16

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_8 + var_482_16 and arg_479_1.time_ < var_482_8 + var_482_16 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play321301119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 321301119
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play321301120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos10131ui_story = arg_483_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_486_0 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				arg_483_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10131ui_story"].transform.position).z)
				arg_483_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["10131ui_story"].transform.localEulerAngles = arg_483_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				arg_483_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_483_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["10131ui_story"].transform.position).z)
				arg_483_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["10131ui_story"].transform.localEulerAngles = arg_483_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_486_1 = arg_483_1.actors_["10131ui_story"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect10131ui_story == nil then
				arg_483_1.var_.characterEffect10131ui_story = var_486_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_2 and not isNil(var_486_1) then
				if arg_483_1.var_.characterEffect10131ui_story and not isNil(var_486_1) then
					arg_483_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_483_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_483_1.time_ - 0) / var_486_2)
				end
			end

			if arg_483_1.time_ >= 0 + var_486_2 and arg_483_1.time_ < 0 + var_486_2 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect10131ui_story then
				arg_483_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_483_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_486_3 = 0
			local var_486_4 = 1.375

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_3 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_5 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(321301119).content)

				arg_483_1.text_.text = var_486_5

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_7 = 55 <= 0 and var_486_4 or var_486_4 * (utf8.len(var_486_5) / 55)

				if (55 <= 0 and var_486_4 or var_486_4 * (utf8.len(var_486_5) / 55)) > 0 and var_486_4 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_3 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_3
					end
				end

				arg_483_1.text_.text = var_486_5
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_8 = math.max(var_486_4, arg_483_1.talkMaxDuration)

			if var_486_3 <= arg_483_1.time_ and arg_483_1.time_ < var_486_3 + var_486_8 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_3) / var_486_8

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_3 + var_486_8 and arg_483_1.time_ < var_486_3 + var_486_8 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play321301120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 321301120
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play321301121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0.566666666666667 < arg_487_1.time_ and arg_487_1.time_ <= 0.566666666666667 + arg_490_0 then
				arg_487_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe3", "")
			end

			local var_490_1 = 0
			local var_490_2 = 1.425

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_3 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(321301120).content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 57 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 57)

				if (57 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 57)) > 0 and var_490_2 < var_490_5 then
					arg_487_1.talkMaxDuration = var_490_5

					if var_490_5 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + var_490_1
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_6 = math.max(var_490_2, arg_487_1.talkMaxDuration)

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_6 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_1) / var_490_6

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_1 + var_490_6 and arg_487_1.time_ < var_490_1 + var_490_6 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play321301121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 321301121
		arg_491_1.duration_ = 3.83

		local var_491_0 = {
			zh = 3.833,
			ja = 2.466
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play321301122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_9000

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1111ui_story = arg_491_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1111ui_story"].transform.position).z)
				arg_491_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1111ui_story"].transform.localEulerAngles = arg_491_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_491_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1111ui_story"].transform.position).z)
				arg_491_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1111ui_story"].transform.localEulerAngles = arg_491_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_494_1 = arg_491_1.actors_["1111ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1111ui_story == nil then
				arg_491_1.var_.characterEffect1111ui_story = var_494_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_2 and not isNil(var_494_1) then
				if arg_491_1.var_.characterEffect1111ui_story and not isNil(var_494_1) then
					arg_491_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_2 and arg_491_1.time_ < 0 + var_494_2 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1111ui_story then
				arg_491_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action7_2")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1 < arg_491_1.time_ and arg_491_1.time_ <= 1 + arg_494_0 then
				local var_494_4 = arg_491_1.var_.effectmingwangdaoguang2

				if not arg_491_1.var_.effectmingwangdaoguang2 then
					var_494_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), manager.ui.mainCamera.transform)
					var_494_4.name = "mingwangdaoguang2"
					arg_491_1.var_.effectmingwangdaoguang2 = var_494_4
				else
					var_494_4.transform:SetParent(var_494_9000)
				end

				var_494_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_494_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_494_6 = 0

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_6 + arg_494_0 then
				arg_491_1.allBtn_.enabled = false
			end

			if arg_491_1.time_ >= var_494_6 + 1.53333333333333 and arg_491_1.time_ < var_494_6 + 1.53333333333333 + arg_494_0 then
				arg_491_1.allBtn_.enabled = true
			end

			if 1 < arg_491_1.time_ and arg_491_1.time_ <= 1 + arg_494_0 then
				arg_491_1:AudioAction("play", "effect", "se_story_140", "se_story_140_scythe6", "")
			end

			local var_494_8 = 0
			local var_494_9 = 0.225

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_8 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_10 = arg_491_1:GetWordFromCfg(321301121)
				local var_494_11 = arg_491_1:FormatText(var_494_10.content)

				arg_491_1.text_.text = var_494_11

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_13 = 9 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 9)

				if (9 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 9)) > 0 and var_494_9 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_8
					end
				end

				arg_491_1.text_.text = var_494_11
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301121", "story_v_out_321301.awb") ~= 0 then
					local var_494_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301121", "story_v_out_321301.awb") / 1000

					if var_494_14 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_14 + var_494_8
					end

					if var_494_10.prefab_name ~= "" and arg_491_1.actors_[var_494_10.prefab_name] ~= nil then
						local var_494_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_10.prefab_name].transform, "story_v_out_321301", "321301121", "story_v_out_321301.awb")

						arg_491_1:RecordAudio("321301121", var_494_15)
						arg_491_1:RecordAudio("321301121", var_494_15)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_321301", "321301121", "story_v_out_321301.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_321301", "321301121", "story_v_out_321301.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_16 = math.max(var_494_9, arg_491_1.talkMaxDuration)

			if var_494_8 <= arg_491_1.time_ and arg_491_1.time_ < var_494_8 + var_494_16 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_8) / var_494_16

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_8 + var_494_16 and arg_491_1.time_ < var_494_8 + var_494_16 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play321301122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 321301122
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play321301123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos1111ui_story = arg_495_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1111ui_story"].transform.position).z)
				arg_495_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1111ui_story"].transform.localEulerAngles = arg_495_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_495_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1111ui_story"].transform.position).z)
				arg_495_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1111ui_story"].transform.localEulerAngles = arg_495_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_498_1 = arg_495_1.actors_["1111ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1111ui_story == nil then
				arg_495_1.var_.characterEffect1111ui_story = var_498_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_2 and not isNil(var_498_1) then
				if arg_495_1.var_.characterEffect1111ui_story and not isNil(var_498_1) then
					arg_495_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_495_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_2)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_2 and arg_495_1.time_ < 0 + var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1111ui_story then
				arg_495_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_495_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_498_3 = 0
			local var_498_4 = 1.2

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_3 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_5 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(321301122).content)

				arg_495_1.text_.text = var_498_5

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_7 = 48 <= 0 and var_498_4 or var_498_4 * (utf8.len(var_498_5) / 48)

				if (48 <= 0 and var_498_4 or var_498_4 * (utf8.len(var_498_5) / 48)) > 0 and var_498_4 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_3 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_3
					end
				end

				arg_495_1.text_.text = var_498_5
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_8 = math.max(var_498_4, arg_495_1.talkMaxDuration)

			if var_498_3 <= arg_495_1.time_ and arg_495_1.time_ < var_498_3 + var_498_8 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_3) / var_498_8

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_3 + var_498_8 and arg_495_1.time_ < var_498_3 + var_498_8 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play321301123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 321301123
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play321301124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				local var_502_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_502_0 then
					var_502_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_502_0.radialBlurScale = 0
					var_502_0.radialBlurGradient = 1
					var_502_0.radialBlurIntensity = 1

					if nil then
						var_502_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_502_1 = 1

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_1 then
				local var_502_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_502_2 then
					var_502_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_502_2.radialBlurScale = Mathf.Lerp(0, 0.7, (arg_499_1.time_ - 0) / var_502_1)
					var_502_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_499_1.time_ - 0) / var_502_1)
					var_502_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_499_1.time_ - 0) / var_502_1)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_1 and arg_499_1.time_ < 0 + var_502_1 + arg_502_0 then
				local var_502_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_502_3 then
					var_502_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_502_3.radialBlurScale = 0.7
					var_502_3.radialBlurGradient = 1
					var_502_3.radialBlurIntensity = 1
				end
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:AudioAction("play", "effect", "se_story_141", "se_story_141_shake", "")
			end

			local var_502_5 = 0
			local var_502_6 = 1.1

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_5 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_7 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(321301123).content)

				arg_499_1.text_.text = var_502_7

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_9 = 44 <= 0 and var_502_6 or var_502_6 * (utf8.len(var_502_7) / 44)

				if (44 <= 0 and var_502_6 or var_502_6 * (utf8.len(var_502_7) / 44)) > 0 and var_502_6 < var_502_9 then
					arg_499_1.talkMaxDuration = var_502_9

					if var_502_9 + var_502_5 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_9 + var_502_5
					end
				end

				arg_499_1.text_.text = var_502_7
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_6, arg_499_1.talkMaxDuration)

			if var_502_5 <= arg_499_1.time_ and arg_499_1.time_ < var_502_5 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_5) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_5 + var_502_10 and arg_499_1.time_ < var_502_5 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play321301124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 321301124
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play321301125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				local var_506_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_506_0 then
					var_506_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_506_0.radialBlurScale = 0
					var_506_0.radialBlurGradient = 1
					var_506_0.radialBlurIntensity = 1

					if nil then
						var_506_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_506_1 = 1

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_1 then
				local var_506_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_506_2 then
					var_506_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_506_2.radialBlurScale = Mathf.Lerp(0, 0, (arg_503_1.time_ - 0) / var_506_1)
					var_506_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_503_1.time_ - 0) / var_506_1)
					var_506_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_503_1.time_ - 0) / var_506_1)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_1 and arg_503_1.time_ < 0 + var_506_1 + arg_506_0 then
				local var_506_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_506_3 then
					var_506_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_506_3.radialBlurScale = 0
					var_506_3.radialBlurGradient = 1
					var_506_3.radialBlurIntensity = 1
				end
			end

			local var_506_4

			if 1 < arg_503_1.time_ and arg_503_1.time_ <= 1 + arg_506_0 then
				local var_506_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_506_5 then
					var_506_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_506_5.radialBlurScale = 0
					var_506_5.radialBlurGradient = 1
					var_506_5.radialBlurIntensity = 1

					if var_506_4 then
						var_506_5.radialBlurTarget = var_506_4.transform
					end
				end
			end

			local var_506_6 = 0.2

			if 1 <= arg_503_1.time_ and arg_503_1.time_ < 1 + var_506_6 then
				local var_506_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_506_7 then
					var_506_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_506_7.radialBlurScale = Mathf.Lerp(0, 0, (arg_503_1.time_ - 1) / var_506_6)
					var_506_7.radialBlurGradient = Mathf.Lerp(1, 1, (arg_503_1.time_ - 1) / var_506_6)
					var_506_7.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_503_1.time_ - 1) / var_506_6)
				end
			end

			if arg_503_1.time_ >= 1 + var_506_6 and arg_503_1.time_ < 1 + var_506_6 + arg_506_0 then
				local var_506_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_506_8 then
					var_506_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_506_8.radialBlurScale = 0
					var_506_8.radialBlurGradient = 1
					var_506_8.radialBlurIntensity = 1
				end
			end

			local var_506_9 = 0
			local var_506_10 = 1.2

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_9 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_11 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(321301124).content)

				arg_503_1.text_.text = var_506_11

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_13 = 48 <= 0 and var_506_10 or var_506_10 * (utf8.len(var_506_11) / 48)

				if (48 <= 0 and var_506_10 or var_506_10 * (utf8.len(var_506_11) / 48)) > 0 and var_506_10 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_9 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_9
					end
				end

				arg_503_1.text_.text = var_506_11
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_14 = math.max(var_506_10, arg_503_1.talkMaxDuration)

			if var_506_9 <= arg_503_1.time_ and arg_503_1.time_ < var_506_9 + var_506_14 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_9) / var_506_14

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_9 + var_506_14 and arg_503_1.time_ < var_506_9 + var_506_14 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play321301125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 321301125
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play321301126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 1.275

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(321301125).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 51 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 51)

				if (51 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 51)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play321301126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 321301126
		arg_511_1.duration_ = 3.67

		local var_511_0 = {
			zh = 3.666,
			ja = 3.1
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play321301127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos1111ui_story = arg_511_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_514_0 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 then
				arg_511_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_511_1.time_ - 0) / var_514_0)
				arg_511_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1111ui_story"].transform.position).z)
				arg_511_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["1111ui_story"].transform.localEulerAngles = arg_511_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 then
				arg_511_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_511_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_511_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_511_1.actors_["1111ui_story"].transform.position).z)
				arg_511_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_511_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_511_1.actors_["1111ui_story"].transform.localEulerAngles = arg_511_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_514_1 = arg_511_1.actors_["1111ui_story"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect1111ui_story == nil then
				arg_511_1.var_.characterEffect1111ui_story = var_514_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_2 and not isNil(var_514_1) then
				if arg_511_1.var_.characterEffect1111ui_story and not isNil(var_514_1) then
					arg_511_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_2 and arg_511_1.time_ < 0 + var_514_2 + arg_514_0 and not isNil(var_514_1) and arg_511_1.var_.characterEffect1111ui_story then
				arg_511_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_514_4 = 0
			local var_514_5 = 0.35

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_6 = arg_511_1:GetWordFromCfg(321301126)
				local var_514_7 = arg_511_1:FormatText(var_514_6.content)

				arg_511_1.text_.text = var_514_7

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_9 = 14 <= 0 and var_514_5 or var_514_5 * (utf8.len(var_514_7) / 14)

				if (14 <= 0 and var_514_5 or var_514_5 * (utf8.len(var_514_7) / 14)) > 0 and var_514_5 < var_514_9 then
					arg_511_1.talkMaxDuration = var_514_9

					if var_514_9 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_9 + var_514_4
					end
				end

				arg_511_1.text_.text = var_514_7
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301126", "story_v_out_321301.awb") ~= 0 then
					local var_514_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301126", "story_v_out_321301.awb") / 1000

					if var_514_10 + var_514_4 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_10 + var_514_4
					end

					if var_514_6.prefab_name ~= "" and arg_511_1.actors_[var_514_6.prefab_name] ~= nil then
						local var_514_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_6.prefab_name].transform, "story_v_out_321301", "321301126", "story_v_out_321301.awb")

						arg_511_1:RecordAudio("321301126", var_514_11)
						arg_511_1:RecordAudio("321301126", var_514_11)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_321301", "321301126", "story_v_out_321301.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_321301", "321301126", "story_v_out_321301.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_12 = math.max(var_514_5, arg_511_1.talkMaxDuration)

			if var_514_4 <= arg_511_1.time_ and arg_511_1.time_ < var_514_4 + var_514_12 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_4) / var_514_12

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_4 + var_514_12 and arg_511_1.time_ < var_514_4 + var_514_12 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play321301127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 321301127
		arg_515_1.duration_ = 9.03

		local var_515_0 = {
			zh = 8.766,
			ja = 9.033
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play321301128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 2 < arg_515_1.time_ and arg_515_1.time_ <= 2 + arg_518_0 then
				local var_518_0 = arg_515_1.bgs_.L09g

				arg_515_1.bgs_.L09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_518_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_518_1 = var_518_0:GetComponent("SpriteRenderer")

				if var_518_1 and var_518_1.sprite then
					local var_518_2 = 2 * (var_518_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_518_0.transform.localScale = Vector3.New(var_518_2 / var_518_1.sprite.bounds.size.y < var_518_2 * manager.ui.mainCameraCom_.aspect / var_518_1.sprite.bounds.size.x and var_518_2 * manager.ui.mainCameraCom_.aspect / var_518_1.sprite.bounds.size.x or var_518_2 / var_518_1.sprite.bounds.size.y, var_518_2 / var_518_1.sprite.bounds.size.y < var_518_2 * manager.ui.mainCameraCom_.aspect / var_518_1.sprite.bounds.size.x and var_518_2 * manager.ui.mainCameraCom_.aspect / var_518_1.sprite.bounds.size.x or var_518_2 / var_518_1.sprite.bounds.size.y, 0)
				end

				for iter_518_0, iter_518_1 in pairs(arg_515_1.bgs_) do
					if iter_518_0 ~= "L09g" then
						iter_518_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_518_3 = 4

			if 4 < arg_515_1.time_ and arg_515_1.time_ <= var_518_3 + arg_518_0 then
				arg_515_1.allBtn_.enabled = false
			end

			if arg_515_1.time_ >= var_518_3 + 0.3 and arg_515_1.time_ < var_518_3 + 0.3 + arg_518_0 then
				arg_515_1.allBtn_.enabled = true
			end

			local var_518_4 = 0

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_4 + arg_518_0 then
				arg_515_1.mask_.enabled = true
				arg_515_1.mask_.raycastTarget = true

				arg_515_1:SetGaussion(false)
			end

			local var_518_5 = 2

			if var_518_4 <= arg_515_1.time_ and arg_515_1.time_ < var_518_4 + var_518_5 then
				local var_518_6 = Color.New(0, 0, 0)

				var_518_6.a = Mathf.Lerp(0, 1, (arg_515_1.time_ - var_518_4) / var_518_5)
				arg_515_1.mask_.color = var_518_6
			end

			if arg_515_1.time_ >= var_518_4 + var_518_5 and arg_515_1.time_ < var_518_4 + var_518_5 + arg_518_0 then
				local var_518_7 = Color.New(0, 0, 0)

				var_518_7.a = 1
				arg_515_1.mask_.color = var_518_7
			end

			local var_518_8 = 2

			if 2 < arg_515_1.time_ and arg_515_1.time_ <= var_518_8 + arg_518_0 then
				arg_515_1.mask_.enabled = true
				arg_515_1.mask_.raycastTarget = true

				arg_515_1:SetGaussion(false)
			end

			local var_518_9 = 2

			if var_518_8 <= arg_515_1.time_ and arg_515_1.time_ < var_518_8 + var_518_9 then
				local var_518_10 = Color.New(0, 0, 0)

				var_518_10.a = Mathf.Lerp(1, 0, (arg_515_1.time_ - var_518_8) / var_518_9)
				arg_515_1.mask_.color = var_518_10
			end

			if arg_515_1.time_ >= var_518_8 + var_518_9 and arg_515_1.time_ < var_518_8 + var_518_9 + arg_518_0 then
				local var_518_11 = Color.New(0, 0, 0)

				arg_515_1.mask_.enabled = false
				var_518_11.a = 0
				arg_515_1.mask_.color = var_518_11
			end

			local var_518_12 = arg_515_1.actors_["1111ui_story"].transform

			if 1.96599999815226 < arg_515_1.time_ and arg_515_1.time_ <= 1.96599999815226 + arg_518_0 then
				arg_515_1.var_.moveOldPos1111ui_story = var_518_12.localPosition
			end

			local var_518_13 = 0.001

			if 1.96599999815226 <= arg_515_1.time_ and arg_515_1.time_ < 1.96599999815226 + var_518_13 then
				var_518_12.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_515_1.time_ - 1.96599999815226) / var_518_13)
				var_518_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_12.position).x, (manager.ui.mainCamera.transform.position - var_518_12.position).y, (manager.ui.mainCamera.transform.position - var_518_12.position).z)
				var_518_12.localEulerAngles.z = 0
				var_518_12.localEulerAngles.x = 0
				var_518_12.localEulerAngles = var_518_12.localEulerAngles
			end

			if arg_515_1.time_ >= 1.96599999815226 + var_518_13 and arg_515_1.time_ < 1.96599999815226 + var_518_13 + arg_518_0 then
				var_518_12.localPosition = Vector3.New(0, 100, 0)
				var_518_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_12.position).x, (manager.ui.mainCamera.transform.position - var_518_12.position).y, (manager.ui.mainCamera.transform.position - var_518_12.position).z)
				var_518_12.localEulerAngles.z = 0
				var_518_12.localEulerAngles.x = 0
				var_518_12.localEulerAngles = var_518_12.localEulerAngles
			end

			local var_518_14 = arg_515_1.actors_["10131ui_story"].transform

			if 3.8 < arg_515_1.time_ and arg_515_1.time_ <= 3.8 + arg_518_0 then
				arg_515_1.var_.moveOldPos10131ui_story = var_518_14.localPosition
			end

			local var_518_15 = 0.001

			if 3.8 <= arg_515_1.time_ and arg_515_1.time_ < 3.8 + var_518_15 then
				var_518_14.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10131ui_story, Vector3.New(0.05, -0.96, -5.8), (arg_515_1.time_ - 3.8) / var_518_15)
				var_518_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_14.position).x, (manager.ui.mainCamera.transform.position - var_518_14.position).y, (manager.ui.mainCamera.transform.position - var_518_14.position).z)
				var_518_14.localEulerAngles.z = 0
				var_518_14.localEulerAngles.x = 0
				var_518_14.localEulerAngles = var_518_14.localEulerAngles
			end

			if arg_515_1.time_ >= 3.8 + var_518_15 and arg_515_1.time_ < 3.8 + var_518_15 + arg_518_0 then
				var_518_14.localPosition = Vector3.New(0.05, -0.96, -5.8)
				var_518_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_518_14.position).x, (manager.ui.mainCamera.transform.position - var_518_14.position).y, (manager.ui.mainCamera.transform.position - var_518_14.position).z)
				var_518_14.localEulerAngles.z = 0
				var_518_14.localEulerAngles.x = 0
				var_518_14.localEulerAngles = var_518_14.localEulerAngles
			end

			local var_518_16 = arg_515_1.actors_["10131ui_story"]

			if 3.79999999701977 < arg_515_1.time_ and arg_515_1.time_ <= 3.79999999701977 + arg_518_0 and not isNil(var_518_16) and arg_515_1.var_.characterEffect10131ui_story == nil then
				arg_515_1.var_.characterEffect10131ui_story = var_518_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_17 = 0.200000002980232

			if 3.79999999701977 <= arg_515_1.time_ and arg_515_1.time_ < 3.79999999701977 + var_518_17 and not isNil(var_518_16) then
				if arg_515_1.var_.characterEffect10131ui_story and not isNil(var_518_16) then
					arg_515_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 3.79999999701977 + var_518_17 and arg_515_1.time_ < 3.79999999701977 + var_518_17 + arg_518_0 and not isNil(var_518_16) and arg_515_1.var_.characterEffect10131ui_story then
				arg_515_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 3.8 < arg_515_1.time_ and arg_515_1.time_ <= 3.8 + arg_518_0 then
				arg_515_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 3.8 < arg_515_1.time_ and arg_515_1.time_ <= 3.8 + arg_518_0 then
				arg_515_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if arg_515_1.frameCnt_ <= 1 then
				arg_515_1.dialog_:SetActive(false)
			end

			local var_518_19 = 4
			local var_518_20 = 0.575

			if 4 < arg_515_1.time_ and arg_515_1.time_ <= var_518_19 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0

				arg_515_1.dialog_:SetActive(true)

				arg_515_1.dialogCg_.alpha = 0

				local var_518_21 = LeanTween.value(arg_515_1.dialog_, 0, 1, 0.3)

				var_518_21:setOnUpdate(LuaHelper.FloatAction(function(arg_519_0)
					arg_515_1.dialogCg_.alpha = arg_519_0
				end))
				var_518_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_515_1.dialog_)
					var_518_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_515_1.duration_ = arg_515_1.duration_ + 0.3

				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_22 = arg_515_1:GetWordFromCfg(321301127)
				local var_518_23 = arg_515_1:FormatText(var_518_22.content)

				arg_515_1.text_.text = var_518_23

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_25 = 23 <= 0 and var_518_20 or var_518_20 * (utf8.len(var_518_23) / 23)

				if (23 <= 0 and var_518_20 or var_518_20 * (utf8.len(var_518_23) / 23)) > 0 and var_518_20 < var_518_25 then
					arg_515_1.talkMaxDuration = var_518_25
					var_518_19 = var_518_19 + 0.3

					if var_518_25 + var_518_19 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_25 + var_518_19
					end
				end

				arg_515_1.text_.text = var_518_23
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301127", "story_v_out_321301.awb") ~= 0 then
					local var_518_26 = manager.audio:GetVoiceLength("story_v_out_321301", "321301127", "story_v_out_321301.awb") / 1000

					if var_518_26 + var_518_19 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_26 + var_518_19
					end

					if var_518_22.prefab_name ~= "" and arg_515_1.actors_[var_518_22.prefab_name] ~= nil then
						local var_518_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_22.prefab_name].transform, "story_v_out_321301", "321301127", "story_v_out_321301.awb")

						arg_515_1:RecordAudio("321301127", var_518_27)
						arg_515_1:RecordAudio("321301127", var_518_27)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_321301", "321301127", "story_v_out_321301.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_321301", "321301127", "story_v_out_321301.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_28 = var_518_19 + 0.3
			local var_518_29 = math.max(var_518_20, arg_515_1.talkMaxDuration)

			if var_518_19 + 0.3 <= arg_515_1.time_ and arg_515_1.time_ < var_518_28 + var_518_29 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_28) / var_518_29

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_28 + var_518_29 and arg_515_1.time_ < var_518_28 + var_518_29 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play321301128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 321301128
		arg_521_1.duration_ = 10.5

		local var_521_0 = {
			zh = 8.366,
			ja = 10.5
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play321301129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.925

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:GetWordFromCfg(321301128)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 37 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 37)

				if (37 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 37)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301128", "story_v_out_321301.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301128", "story_v_out_321301.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_out_321301", "321301128", "story_v_out_321301.awb")

						arg_521_1:RecordAudio("321301128", var_524_6)
						arg_521_1:RecordAudio("321301128", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_321301", "321301128", "story_v_out_321301.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_321301", "321301128", "story_v_out_321301.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_7 and arg_521_1.time_ < 0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play321301129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 321301129
		arg_525_1.duration_ = 4.83

		local var_525_0 = {
			zh = 4.833,
			ja = 4.566
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play321301130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.525

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:GetWordFromCfg(321301129)
				local var_528_2 = arg_525_1:FormatText(var_528_1.content)

				arg_525_1.text_.text = var_528_2

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_4 = 21 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 21)

				if (21 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_2) / 21)) > 0 and var_528_0 < var_528_4 then
					arg_525_1.talkMaxDuration = var_528_4

					if var_528_4 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_4 + 0
					end
				end

				arg_525_1.text_.text = var_528_2
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301129", "story_v_out_321301.awb") ~= 0 then
					local var_528_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301129", "story_v_out_321301.awb") / 1000

					if var_528_5 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + 0
					end

					if var_528_1.prefab_name ~= "" and arg_525_1.actors_[var_528_1.prefab_name] ~= nil then
						local var_528_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_1.prefab_name].transform, "story_v_out_321301", "321301129", "story_v_out_321301.awb")

						arg_525_1:RecordAudio("321301129", var_528_6)
						arg_525_1:RecordAudio("321301129", var_528_6)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_321301", "321301129", "story_v_out_321301.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_321301", "321301129", "story_v_out_321301.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_7 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_7 and arg_525_1.time_ < 0 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play321301130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 321301130
		arg_529_1.duration_ = 9.87

		local var_529_0 = {
			zh = 8.966,
			ja = 9.866
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play321301131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos1111ui_story = arg_529_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_532_0 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 then
				arg_529_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_529_1.time_ - 0) / var_532_0)
				arg_529_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1111ui_story"].transform.position).z)
				arg_529_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["1111ui_story"].transform.localEulerAngles = arg_529_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 then
				arg_529_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_529_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["1111ui_story"].transform.position).z)
				arg_529_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["1111ui_story"].transform.localEulerAngles = arg_529_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_532_1 = arg_529_1.actors_["10131ui_story"].transform

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos10131ui_story = var_532_1.localPosition
			end

			local var_532_2 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_2 then
				var_532_1.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_529_1.time_ - 0) / var_532_2)
				var_532_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_532_1.position).x, (manager.ui.mainCamera.transform.position - var_532_1.position).y, (manager.ui.mainCamera.transform.position - var_532_1.position).z)
				var_532_1.localEulerAngles.z = 0
				var_532_1.localEulerAngles.x = 0
				var_532_1.localEulerAngles = var_532_1.localEulerAngles
			end

			if arg_529_1.time_ >= 0 + var_532_2 and arg_529_1.time_ < 0 + var_532_2 + arg_532_0 then
				var_532_1.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_532_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_532_1.position).x, (manager.ui.mainCamera.transform.position - var_532_1.position).y, (manager.ui.mainCamera.transform.position - var_532_1.position).z)
				var_532_1.localEulerAngles.z = 0
				var_532_1.localEulerAngles.x = 0
				var_532_1.localEulerAngles = var_532_1.localEulerAngles
			end

			local var_532_3 = arg_529_1.actors_["1111ui_story"]

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(var_532_3) and arg_529_1.var_.characterEffect1111ui_story == nil then
				arg_529_1.var_.characterEffect1111ui_story = var_532_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_4 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_4 and not isNil(var_532_3) then
				if arg_529_1.var_.characterEffect1111ui_story and not isNil(var_532_3) then
					arg_529_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= 0 + var_532_4 and arg_529_1.time_ < 0 + var_532_4 + arg_532_0 and not isNil(var_532_3) and arg_529_1.var_.characterEffect1111ui_story then
				arg_529_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_532_6 = arg_529_1.actors_["10131ui_story"]

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(var_532_6) and arg_529_1.var_.characterEffect10131ui_story == nil then
				arg_529_1.var_.characterEffect10131ui_story = var_532_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_7 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_7 and not isNil(var_532_6) then
				if arg_529_1.var_.characterEffect10131ui_story and not isNil(var_532_6) then
					arg_529_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_529_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 0) / var_532_7)
				end
			end

			if arg_529_1.time_ >= 0 + var_532_7 and arg_529_1.time_ < 0 + var_532_7 + arg_532_0 and not isNil(var_532_6) and arg_529_1.var_.characterEffect10131ui_story then
				arg_529_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_529_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_532_8 = 0
			local var_532_9 = 1.075

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_8 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_10 = arg_529_1:GetWordFromCfg(321301130)
				local var_532_11 = arg_529_1:FormatText(var_532_10.content)

				arg_529_1.text_.text = var_532_11

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_13 = 43 <= 0 and var_532_9 or var_532_9 * (utf8.len(var_532_11) / 43)

				if (43 <= 0 and var_532_9 or var_532_9 * (utf8.len(var_532_11) / 43)) > 0 and var_532_9 < var_532_13 then
					arg_529_1.talkMaxDuration = var_532_13

					if var_532_13 + var_532_8 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_13 + var_532_8
					end
				end

				arg_529_1.text_.text = var_532_11
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301130", "story_v_out_321301.awb") ~= 0 then
					local var_532_14 = manager.audio:GetVoiceLength("story_v_out_321301", "321301130", "story_v_out_321301.awb") / 1000

					if var_532_14 + var_532_8 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_14 + var_532_8
					end

					if var_532_10.prefab_name ~= "" and arg_529_1.actors_[var_532_10.prefab_name] ~= nil then
						local var_532_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_10.prefab_name].transform, "story_v_out_321301", "321301130", "story_v_out_321301.awb")

						arg_529_1:RecordAudio("321301130", var_532_15)
						arg_529_1:RecordAudio("321301130", var_532_15)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_321301", "321301130", "story_v_out_321301.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_321301", "321301130", "story_v_out_321301.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_16 = math.max(var_532_9, arg_529_1.talkMaxDuration)

			if var_532_8 <= arg_529_1.time_ and arg_529_1.time_ < var_532_8 + var_532_16 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_8) / var_532_16

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_8 + var_532_16 and arg_529_1.time_ < var_532_8 + var_532_16 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play321301131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 321301131
		arg_533_1.duration_ = 5.8

		local var_533_0 = {
			zh = 4.333,
			ja = 5.8
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play321301132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos1111ui_story = arg_533_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_536_0 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 then
				arg_533_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_533_1.time_ - 0) / var_536_0)
				arg_533_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1111ui_story"].transform.position).z)
				arg_533_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["1111ui_story"].transform.localEulerAngles = arg_533_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 then
				arg_533_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_533_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1111ui_story"].transform.position).z)
				arg_533_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["1111ui_story"].transform.localEulerAngles = arg_533_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_536_1 = arg_533_1.actors_["10131ui_story"].transform

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos10131ui_story = var_536_1.localPosition
			end

			local var_536_2 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_2 then
				var_536_1.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_533_1.time_ - 0) / var_536_2)
				var_536_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_536_1.position).x, (manager.ui.mainCamera.transform.position - var_536_1.position).y, (manager.ui.mainCamera.transform.position - var_536_1.position).z)
				var_536_1.localEulerAngles.z = 0
				var_536_1.localEulerAngles.x = 0
				var_536_1.localEulerAngles = var_536_1.localEulerAngles
			end

			if arg_533_1.time_ >= 0 + var_536_2 and arg_533_1.time_ < 0 + var_536_2 + arg_536_0 then
				var_536_1.localPosition = Vector3.New(0, 100, 0)
				var_536_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_536_1.position).x, (manager.ui.mainCamera.transform.position - var_536_1.position).y, (manager.ui.mainCamera.transform.position - var_536_1.position).z)
				var_536_1.localEulerAngles.z = 0
				var_536_1.localEulerAngles.x = 0
				var_536_1.localEulerAngles = var_536_1.localEulerAngles
			end

			local var_536_3 = arg_533_1.actors_["1043ui_story"].transform

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos1043ui_story = var_536_3.localPosition
			end

			local var_536_4 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_4 then
				var_536_3.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_533_1.time_ - 0) / var_536_4)
				var_536_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_536_3.position).x, (manager.ui.mainCamera.transform.position - var_536_3.position).y, (manager.ui.mainCamera.transform.position - var_536_3.position).z)
				var_536_3.localEulerAngles.z = 0
				var_536_3.localEulerAngles.x = 0
				var_536_3.localEulerAngles = var_536_3.localEulerAngles
			end

			if arg_533_1.time_ >= 0 + var_536_4 and arg_533_1.time_ < 0 + var_536_4 + arg_536_0 then
				var_536_3.localPosition = Vector3.New(0.81, -1.01, -5.73)
				var_536_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_536_3.position).x, (manager.ui.mainCamera.transform.position - var_536_3.position).y, (manager.ui.mainCamera.transform.position - var_536_3.position).z)
				var_536_3.localEulerAngles.z = 0
				var_536_3.localEulerAngles.x = 0
				var_536_3.localEulerAngles = var_536_3.localEulerAngles
			end

			local var_536_5 = arg_533_1.actors_["1043ui_story"]

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(var_536_5) and arg_533_1.var_.characterEffect1043ui_story == nil then
				arg_533_1.var_.characterEffect1043ui_story = var_536_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_6 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_6 and not isNil(var_536_5) then
				if arg_533_1.var_.characterEffect1043ui_story and not isNil(var_536_5) then
					arg_533_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= 0 + var_536_6 and arg_533_1.time_ < 0 + var_536_6 + arg_536_0 and not isNil(var_536_5) and arg_533_1.var_.characterEffect1043ui_story then
				arg_533_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_536_8 = arg_533_1.actors_["1111ui_story"]

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(var_536_8) and arg_533_1.var_.characterEffect1111ui_story == nil then
				arg_533_1.var_.characterEffect1111ui_story = var_536_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_9 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_9 and not isNil(var_536_8) then
				if arg_533_1.var_.characterEffect1111ui_story and not isNil(var_536_8) then
					arg_533_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_9)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_9 and arg_533_1.time_ < 0 + var_536_9 + arg_536_0 and not isNil(var_536_8) and arg_533_1.var_.characterEffect1111ui_story then
				arg_533_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_536_10 = 0
			local var_536_11 = 0.625

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_10 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_12 = arg_533_1:GetWordFromCfg(321301131)
				local var_536_13 = arg_533_1:FormatText(var_536_12.content)

				arg_533_1.text_.text = var_536_13

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_15 = 25 <= 0 and var_536_11 or var_536_11 * (utf8.len(var_536_13) / 25)

				if (25 <= 0 and var_536_11 or var_536_11 * (utf8.len(var_536_13) / 25)) > 0 and var_536_11 < var_536_15 then
					arg_533_1.talkMaxDuration = var_536_15

					if var_536_15 + var_536_10 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_15 + var_536_10
					end
				end

				arg_533_1.text_.text = var_536_13
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301131", "story_v_out_321301.awb") ~= 0 then
					local var_536_16 = manager.audio:GetVoiceLength("story_v_out_321301", "321301131", "story_v_out_321301.awb") / 1000

					if var_536_16 + var_536_10 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_16 + var_536_10
					end

					if var_536_12.prefab_name ~= "" and arg_533_1.actors_[var_536_12.prefab_name] ~= nil then
						local var_536_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_12.prefab_name].transform, "story_v_out_321301", "321301131", "story_v_out_321301.awb")

						arg_533_1:RecordAudio("321301131", var_536_17)
						arg_533_1:RecordAudio("321301131", var_536_17)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_321301", "321301131", "story_v_out_321301.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_321301", "321301131", "story_v_out_321301.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_18 = math.max(var_536_11, arg_533_1.talkMaxDuration)

			if var_536_10 <= arg_533_1.time_ and arg_533_1.time_ < var_536_10 + var_536_18 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_10) / var_536_18

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_10 + var_536_18 and arg_533_1.time_ < var_536_10 + var_536_18 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play321301132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 321301132
		arg_537_1.duration_ = 7.37

		local var_537_0 = {
			zh = 4.633,
			ja = 7.366
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play321301133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.725

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_1 = arg_537_1:GetWordFromCfg(321301132)
				local var_540_2 = arg_537_1:FormatText(var_540_1.content)

				arg_537_1.text_.text = var_540_2

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_4 = 29 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 29)

				if (29 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_2) / 29)) > 0 and var_540_0 < var_540_4 then
					arg_537_1.talkMaxDuration = var_540_4

					if var_540_4 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_4 + 0
					end
				end

				arg_537_1.text_.text = var_540_2
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301132", "story_v_out_321301.awb") ~= 0 then
					local var_540_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301132", "story_v_out_321301.awb") / 1000

					if var_540_5 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + 0
					end

					if var_540_1.prefab_name ~= "" and arg_537_1.actors_[var_540_1.prefab_name] ~= nil then
						local var_540_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_1.prefab_name].transform, "story_v_out_321301", "321301132", "story_v_out_321301.awb")

						arg_537_1:RecordAudio("321301132", var_540_6)
						arg_537_1:RecordAudio("321301132", var_540_6)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_321301", "321301132", "story_v_out_321301.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_321301", "321301132", "story_v_out_321301.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_7 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_7 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_7

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_7 and arg_537_1.time_ < 0 + var_540_7 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play321301133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 321301133
		arg_541_1.duration_ = 3.17

		local var_541_0 = {
			zh = 2.6,
			ja = 3.166
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play321301134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["1111ui_story"]) and arg_541_1.var_.characterEffect1111ui_story == nil then
				arg_541_1.var_.characterEffect1111ui_story = arg_541_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_0 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["1111ui_story"]) then
				if arg_541_1.var_.characterEffect1111ui_story and not isNil(arg_541_1.actors_["1111ui_story"]) then
					arg_541_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["1111ui_story"]) and arg_541_1.var_.characterEffect1111ui_story then
				arg_541_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_544_2 = arg_541_1.actors_["1043ui_story"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_2) and arg_541_1.var_.characterEffect1043ui_story == nil then
				arg_541_1.var_.characterEffect1043ui_story = var_544_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_3 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_3 and not isNil(var_544_2) then
				if arg_541_1.var_.characterEffect1043ui_story and not isNil(var_544_2) then
					arg_541_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_541_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_541_1.time_ - 0) / var_544_3)
				end
			end

			if arg_541_1.time_ >= 0 + var_544_3 and arg_541_1.time_ < 0 + var_544_3 + arg_544_0 and not isNil(var_544_2) and arg_541_1.var_.characterEffect1043ui_story then
				arg_541_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_541_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_544_4 = 0
			local var_544_5 = 0.275

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_4 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_6 = arg_541_1:GetWordFromCfg(321301133)
				local var_544_7 = arg_541_1:FormatText(var_544_6.content)

				arg_541_1.text_.text = var_544_7

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_9 = 11 <= 0 and var_544_5 or var_544_5 * (utf8.len(var_544_7) / 11)

				if (11 <= 0 and var_544_5 or var_544_5 * (utf8.len(var_544_7) / 11)) > 0 and var_544_5 < var_544_9 then
					arg_541_1.talkMaxDuration = var_544_9

					if var_544_9 + var_544_4 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_9 + var_544_4
					end
				end

				arg_541_1.text_.text = var_544_7
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301133", "story_v_out_321301.awb") ~= 0 then
					local var_544_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301133", "story_v_out_321301.awb") / 1000

					if var_544_10 + var_544_4 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_10 + var_544_4
					end

					if var_544_6.prefab_name ~= "" and arg_541_1.actors_[var_544_6.prefab_name] ~= nil then
						local var_544_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_6.prefab_name].transform, "story_v_out_321301", "321301133", "story_v_out_321301.awb")

						arg_541_1:RecordAudio("321301133", var_544_11)
						arg_541_1:RecordAudio("321301133", var_544_11)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_321301", "321301133", "story_v_out_321301.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_321301", "321301133", "story_v_out_321301.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_12 = math.max(var_544_5, arg_541_1.talkMaxDuration)

			if var_544_4 <= arg_541_1.time_ and arg_541_1.time_ < var_544_4 + var_544_12 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_4) / var_544_12

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_4 + var_544_12 and arg_541_1.time_ < var_544_4 + var_544_12 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play321301134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 321301134
		arg_545_1.duration_ = 11.1

		local var_545_0 = {
			zh = 11.1,
			ja = 10.3
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play321301135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 1.25

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_1 = arg_545_1:GetWordFromCfg(321301134)
				local var_548_2 = arg_545_1:FormatText(var_548_1.content)

				arg_545_1.text_.text = var_548_2

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_4 = 50 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_2) / 50)

				if (50 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_2) / 50)) > 0 and var_548_0 < var_548_4 then
					arg_545_1.talkMaxDuration = var_548_4

					if var_548_4 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_4 + 0
					end
				end

				arg_545_1.text_.text = var_548_2
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301134", "story_v_out_321301.awb") ~= 0 then
					local var_548_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301134", "story_v_out_321301.awb") / 1000

					if var_548_5 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_5 + 0
					end

					if var_548_1.prefab_name ~= "" and arg_545_1.actors_[var_548_1.prefab_name] ~= nil then
						local var_548_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_1.prefab_name].transform, "story_v_out_321301", "321301134", "story_v_out_321301.awb")

						arg_545_1:RecordAudio("321301134", var_548_6)
						arg_545_1:RecordAudio("321301134", var_548_6)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_321301", "321301134", "story_v_out_321301.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_321301", "321301134", "story_v_out_321301.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_7 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_7 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_7

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_7 and arg_545_1.time_ < 0 + var_548_7 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play321301135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 321301135
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play321301136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.var_.moveOldPos1111ui_story = arg_549_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_552_0 = 0.001

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 then
				arg_549_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_549_1.time_ - 0) / var_552_0)
				arg_549_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1111ui_story"].transform.position).z)
				arg_549_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1111ui_story"].transform.localEulerAngles = arg_549_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 then
				arg_549_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_549_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1111ui_story"].transform.position).z)
				arg_549_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1111ui_story"].transform.localEulerAngles = arg_549_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_552_1 = arg_549_1.actors_["1043ui_story"].transform

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.var_.moveOldPos1043ui_story = var_552_1.localPosition
			end

			local var_552_2 = 0.001

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_2 then
				var_552_1.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_549_1.time_ - 0) / var_552_2)
				var_552_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_552_1.position).x, (manager.ui.mainCamera.transform.position - var_552_1.position).y, (manager.ui.mainCamera.transform.position - var_552_1.position).z)
				var_552_1.localEulerAngles.z = 0
				var_552_1.localEulerAngles.x = 0
				var_552_1.localEulerAngles = var_552_1.localEulerAngles
			end

			if arg_549_1.time_ >= 0 + var_552_2 and arg_549_1.time_ < 0 + var_552_2 + arg_552_0 then
				var_552_1.localPosition = Vector3.New(0, 100, 0)
				var_552_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_552_1.position).x, (manager.ui.mainCamera.transform.position - var_552_1.position).y, (manager.ui.mainCamera.transform.position - var_552_1.position).z)
				var_552_1.localEulerAngles.z = 0
				var_552_1.localEulerAngles.x = 0
				var_552_1.localEulerAngles = var_552_1.localEulerAngles
			end

			local var_552_3 = arg_549_1.actors_["1111ui_story"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_3) and arg_549_1.var_.characterEffect1111ui_story == nil then
				arg_549_1.var_.characterEffect1111ui_story = var_552_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_4 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_4 and not isNil(var_552_3) then
				if arg_549_1.var_.characterEffect1111ui_story and not isNil(var_552_3) then
					arg_549_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_549_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_4)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_4 and arg_549_1.time_ < 0 + var_552_4 + arg_552_0 and not isNil(var_552_3) and arg_549_1.var_.characterEffect1111ui_story then
				arg_549_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_549_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_552_5 = 0
			local var_552_6 = 0.65

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_5 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_7 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(321301135).content)

				arg_549_1.text_.text = var_552_7

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_9 = 26 <= 0 and var_552_6 or var_552_6 * (utf8.len(var_552_7) / 26)

				if (26 <= 0 and var_552_6 or var_552_6 * (utf8.len(var_552_7) / 26)) > 0 and var_552_6 < var_552_9 then
					arg_549_1.talkMaxDuration = var_552_9

					if var_552_9 + var_552_5 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_9 + var_552_5
					end
				end

				arg_549_1.text_.text = var_552_7
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_6, arg_549_1.talkMaxDuration)

			if var_552_5 <= arg_549_1.time_ and arg_549_1.time_ < var_552_5 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_5) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_5 + var_552_10 and arg_549_1.time_ < var_552_5 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_549_1:InitPlayNodeList()
	end,
	Play321301136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 321301136
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play321301137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0.05 < arg_553_1.time_ and arg_553_1.time_ <= 0.05 + arg_556_0 then
				arg_553_1:AudioAction("play", "effect", "se_story_140", "se_story_140_action02", "")
			end

			local var_556_1 = 0
			local var_556_2 = 0.725

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_3 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(321301136).content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 29 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_3) / 29)

				if (29 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_3) / 29)) > 0 and var_556_2 < var_556_5 then
					arg_553_1.talkMaxDuration = var_556_5

					if var_556_5 + var_556_1 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_5 + var_556_1
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_6 = math.max(var_556_2, arg_553_1.talkMaxDuration)

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_6 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_1) / var_556_6

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_1 + var_556_6 and arg_553_1.time_ < var_556_1 + var_556_6 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play321301137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 321301137
		arg_557_1.duration_ = 4.4

		local var_557_0 = {
			zh = 3.466,
			ja = 4.4
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play321301138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.4

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_1 = arg_557_1:GetWordFromCfg(321301137)
				local var_560_2 = arg_557_1:FormatText(var_560_1.content)

				arg_557_1.text_.text = var_560_2

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 16 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 16)

				if (16 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 16)) > 0 and var_560_0 < var_560_4 then
					arg_557_1.talkMaxDuration = var_560_4

					if var_560_4 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_4 + 0
					end
				end

				arg_557_1.text_.text = var_560_2
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301137", "story_v_out_321301.awb") ~= 0 then
					local var_560_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301137", "story_v_out_321301.awb") / 1000

					if var_560_5 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + 0
					end

					if var_560_1.prefab_name ~= "" and arg_557_1.actors_[var_560_1.prefab_name] ~= nil then
						local var_560_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_1.prefab_name].transform, "story_v_out_321301", "321301137", "story_v_out_321301.awb")

						arg_557_1:RecordAudio("321301137", var_560_6)
						arg_557_1:RecordAudio("321301137", var_560_6)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_321301", "321301137", "story_v_out_321301.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_321301", "321301137", "story_v_out_321301.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_7 and arg_557_1.time_ < 0 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play321301138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 321301138
		arg_561_1.duration_ = 8.43

		local var_561_0 = {
			zh = 4.066,
			ja = 8.433
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play321301139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos1043ui_story = arg_561_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_564_0 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 then
				arg_561_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_561_1.time_ - 0) / var_564_0)
				arg_561_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1043ui_story"].transform.position).z)
				arg_561_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1043ui_story"].transform.localEulerAngles = arg_561_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 then
				arg_561_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_561_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1043ui_story"].transform.position).z)
				arg_561_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1043ui_story"].transform.localEulerAngles = arg_561_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_564_1 = arg_561_1.actors_["1043ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1043ui_story == nil then
				arg_561_1.var_.characterEffect1043ui_story = var_564_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_2 and not isNil(var_564_1) then
				if arg_561_1.var_.characterEffect1043ui_story and not isNil(var_564_1) then
					arg_561_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_2 and arg_561_1.time_ < 0 + var_564_2 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1043ui_story then
				arg_561_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_564_4 = 0
			local var_564_5 = 0.525

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_6 = arg_561_1:GetWordFromCfg(321301138)
				local var_564_7 = arg_561_1:FormatText(var_564_6.content)

				arg_561_1.text_.text = var_564_7

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_9 = 21 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 21)

				if (21 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 21)) > 0 and var_564_5 < var_564_9 then
					arg_561_1.talkMaxDuration = var_564_9

					if var_564_9 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_9 + var_564_4
					end
				end

				arg_561_1.text_.text = var_564_7
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301138", "story_v_out_321301.awb") ~= 0 then
					local var_564_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301138", "story_v_out_321301.awb") / 1000

					if var_564_10 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_10 + var_564_4
					end

					if var_564_6.prefab_name ~= "" and arg_561_1.actors_[var_564_6.prefab_name] ~= nil then
						local var_564_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_6.prefab_name].transform, "story_v_out_321301", "321301138", "story_v_out_321301.awb")

						arg_561_1:RecordAudio("321301138", var_564_11)
						arg_561_1:RecordAudio("321301138", var_564_11)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_321301", "321301138", "story_v_out_321301.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_321301", "321301138", "story_v_out_321301.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_12 = math.max(var_564_5, arg_561_1.talkMaxDuration)

			if var_564_4 <= arg_561_1.time_ and arg_561_1.time_ < var_564_4 + var_564_12 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_4) / var_564_12

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_4 + var_564_12 and arg_561_1.time_ < var_564_4 + var_564_12 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play321301139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 321301139
		arg_565_1.duration_ = 6.03

		local var_565_0 = {
			zh = 3.066,
			ja = 6.033
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play321301140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1043ui_story"]) and arg_565_1.var_.characterEffect1043ui_story == nil then
				arg_565_1.var_.characterEffect1043ui_story = arg_565_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1043ui_story"]) then
				if arg_565_1.var_.characterEffect1043ui_story and not isNil(arg_565_1.actors_["1043ui_story"]) then
					arg_565_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 0) / var_568_0)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1043ui_story"]) and arg_565_1.var_.characterEffect1043ui_story then
				arg_565_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_568_1 = 0
			local var_568_2 = 0.325

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:GetWordFromCfg(321301139)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_6 = 13 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_4) / 13)

				if (13 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_4) / 13)) > 0 and var_568_2 < var_568_6 then
					arg_565_1.talkMaxDuration = var_568_6

					if var_568_6 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_6 + var_568_1
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301139", "story_v_out_321301.awb") ~= 0 then
					local var_568_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301139", "story_v_out_321301.awb") / 1000

					if var_568_7 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_1
					end

					if var_568_3.prefab_name ~= "" and arg_565_1.actors_[var_568_3.prefab_name] ~= nil then
						local var_568_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_3.prefab_name].transform, "story_v_out_321301", "321301139", "story_v_out_321301.awb")

						arg_565_1:RecordAudio("321301139", var_568_8)
						arg_565_1:RecordAudio("321301139", var_568_8)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_321301", "321301139", "story_v_out_321301.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_321301", "321301139", "story_v_out_321301.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_9 = math.max(var_568_2, arg_565_1.talkMaxDuration)

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_9 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_1) / var_568_9

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_1 + var_568_9 and arg_565_1.time_ < var_568_1 + var_568_9 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play321301140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 321301140
		arg_569_1.duration_ = 6.63

		local var_569_0 = {
			zh = 4,
			ja = 6.633
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play321301141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.var_.moveOldPos1043ui_story = arg_569_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_572_0 = 0.001

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 then
				arg_569_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_569_1.time_ - 0) / var_572_0)
				arg_569_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_569_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1043ui_story"].transform.position).z)
				arg_569_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_569_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_569_1.actors_["1043ui_story"].transform.localEulerAngles = arg_569_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 then
				arg_569_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_569_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_569_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1043ui_story"].transform.position).z)
				arg_569_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_569_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_569_1.actors_["1043ui_story"].transform.localEulerAngles = arg_569_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_572_1 = arg_569_1.actors_["1043ui_story"]

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(var_572_1) and arg_569_1.var_.characterEffect1043ui_story == nil then
				arg_569_1.var_.characterEffect1043ui_story = var_572_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.200000002980232

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_2 and not isNil(var_572_1) then
				if arg_569_1.var_.characterEffect1043ui_story and not isNil(var_572_1) then
					arg_569_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_569_1.time_ >= 0 + var_572_2 and arg_569_1.time_ < 0 + var_572_2 + arg_572_0 and not isNil(var_572_1) and arg_569_1.var_.characterEffect1043ui_story then
				arg_569_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_572_4 = 0
			local var_572_5 = 0.525

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_4 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_6 = arg_569_1:GetWordFromCfg(321301140)
				local var_572_7 = arg_569_1:FormatText(var_572_6.content)

				arg_569_1.text_.text = var_572_7

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_9 = 21 <= 0 and var_572_5 or var_572_5 * (utf8.len(var_572_7) / 21)

				if (21 <= 0 and var_572_5 or var_572_5 * (utf8.len(var_572_7) / 21)) > 0 and var_572_5 < var_572_9 then
					arg_569_1.talkMaxDuration = var_572_9

					if var_572_9 + var_572_4 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_9 + var_572_4
					end
				end

				arg_569_1.text_.text = var_572_7
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301140", "story_v_out_321301.awb") ~= 0 then
					local var_572_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301140", "story_v_out_321301.awb") / 1000

					if var_572_10 + var_572_4 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_10 + var_572_4
					end

					if var_572_6.prefab_name ~= "" and arg_569_1.actors_[var_572_6.prefab_name] ~= nil then
						local var_572_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_6.prefab_name].transform, "story_v_out_321301", "321301140", "story_v_out_321301.awb")

						arg_569_1:RecordAudio("321301140", var_572_11)
						arg_569_1:RecordAudio("321301140", var_572_11)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_out_321301", "321301140", "story_v_out_321301.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_out_321301", "321301140", "story_v_out_321301.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_12 = math.max(var_572_5, arg_569_1.talkMaxDuration)

			if var_572_4 <= arg_569_1.time_ and arg_569_1.time_ < var_572_4 + var_572_12 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_4) / var_572_12

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_4 + var_572_12 and arg_569_1.time_ < var_572_4 + var_572_12 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play321301141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 321301141
		arg_573_1.duration_ = 7.77

		local var_573_0 = {
			zh = 5.266,
			ja = 7.766
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play321301142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["1043ui_story"]) and arg_573_1.var_.characterEffect1043ui_story == nil then
				arg_573_1.var_.characterEffect1043ui_story = arg_573_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_0 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["1043ui_story"]) then
				if arg_573_1.var_.characterEffect1043ui_story and not isNil(arg_573_1.actors_["1043ui_story"]) then
					arg_573_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_573_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_573_1.time_ - 0) / var_576_0)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["1043ui_story"]) and arg_573_1.var_.characterEffect1043ui_story then
				arg_573_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_573_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_576_1 = 0
			local var_576_2 = 0.6

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_3 = arg_573_1:GetWordFromCfg(321301141)
				local var_576_4 = arg_573_1:FormatText(var_576_3.content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_6 = 24 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_4) / 24)

				if (24 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_4) / 24)) > 0 and var_576_2 < var_576_6 then
					arg_573_1.talkMaxDuration = var_576_6

					if var_576_6 + var_576_1 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_6 + var_576_1
					end
				end

				arg_573_1.text_.text = var_576_4
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301141", "story_v_out_321301.awb") ~= 0 then
					local var_576_7 = manager.audio:GetVoiceLength("story_v_out_321301", "321301141", "story_v_out_321301.awb") / 1000

					if var_576_7 + var_576_1 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_1
					end

					if var_576_3.prefab_name ~= "" and arg_573_1.actors_[var_576_3.prefab_name] ~= nil then
						local var_576_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_3.prefab_name].transform, "story_v_out_321301", "321301141", "story_v_out_321301.awb")

						arg_573_1:RecordAudio("321301141", var_576_8)
						arg_573_1:RecordAudio("321301141", var_576_8)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_321301", "321301141", "story_v_out_321301.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_321301", "321301141", "story_v_out_321301.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_9 = math.max(var_576_2, arg_573_1.talkMaxDuration)

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_9 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_1) / var_576_9

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_1 + var_576_9 and arg_573_1.time_ < var_576_1 + var_576_9 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play321301142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 321301142
		arg_577_1.duration_ = 10.8

		local var_577_0 = {
			zh = 7.4,
			ja = 10.8
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play321301143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0.975

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_1 = arg_577_1:GetWordFromCfg(321301142)
				local var_580_2 = arg_577_1:FormatText(var_580_1.content)

				arg_577_1.text_.text = var_580_2

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_4 = 39 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_2) / 39)

				if (39 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_2) / 39)) > 0 and var_580_0 < var_580_4 then
					arg_577_1.talkMaxDuration = var_580_4

					if var_580_4 + 0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_4 + 0
					end
				end

				arg_577_1.text_.text = var_580_2
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301142", "story_v_out_321301.awb") ~= 0 then
					local var_580_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301142", "story_v_out_321301.awb") / 1000

					if var_580_5 + 0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_5 + 0
					end

					if var_580_1.prefab_name ~= "" and arg_577_1.actors_[var_580_1.prefab_name] ~= nil then
						local var_580_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_1.prefab_name].transform, "story_v_out_321301", "321301142", "story_v_out_321301.awb")

						arg_577_1:RecordAudio("321301142", var_580_6)
						arg_577_1:RecordAudio("321301142", var_580_6)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_out_321301", "321301142", "story_v_out_321301.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_out_321301", "321301142", "story_v_out_321301.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_7 = math.max(var_580_0, arg_577_1.talkMaxDuration)

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_7 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - 0) / var_580_7

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= 0 + var_580_7 and arg_577_1.time_ < 0 + var_580_7 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play321301143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 321301143
		arg_581_1.duration_ = 3.03

		local var_581_0 = {
			zh = 2.333,
			ja = 3.033
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play321301144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0.2

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_1 = arg_581_1:GetWordFromCfg(321301143)
				local var_584_2 = arg_581_1:FormatText(var_584_1.content)

				arg_581_1.text_.text = var_584_2

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_4 = 8 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_2) / 8)

				if (8 <= 0 and var_584_0 or var_584_0 * (utf8.len(var_584_2) / 8)) > 0 and var_584_0 < var_584_4 then
					arg_581_1.talkMaxDuration = var_584_4

					if var_584_4 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_4 + 0
					end
				end

				arg_581_1.text_.text = var_584_2
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301143", "story_v_out_321301.awb") ~= 0 then
					local var_584_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301143", "story_v_out_321301.awb") / 1000

					if var_584_5 + 0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_5 + 0
					end

					if var_584_1.prefab_name ~= "" and arg_581_1.actors_[var_584_1.prefab_name] ~= nil then
						local var_584_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_1.prefab_name].transform, "story_v_out_321301", "321301143", "story_v_out_321301.awb")

						arg_581_1:RecordAudio("321301143", var_584_6)
						arg_581_1:RecordAudio("321301143", var_584_6)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_321301", "321301143", "story_v_out_321301.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_321301", "321301143", "story_v_out_321301.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_7 = math.max(var_584_0, arg_581_1.talkMaxDuration)

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_7 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - 0) / var_584_7

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= 0 + var_584_7 and arg_581_1.time_ < 0 + var_584_7 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play321301144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 321301144
		arg_585_1.duration_ = 3.43

		local var_585_0 = {
			zh = 3.433,
			ja = 3.4
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play321301145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.var_.moveOldPos1043ui_story = arg_585_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_588_0 = 0.001

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 then
				arg_585_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_585_1.time_ - 0) / var_588_0)
				arg_585_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_585_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1043ui_story"].transform.position).z)
				arg_585_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_585_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_585_1.actors_["1043ui_story"].transform.localEulerAngles = arg_585_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 then
				arg_585_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.01, -1.01, -5.73)
				arg_585_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_585_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1043ui_story"].transform.position).z)
				arg_585_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_585_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_585_1.actors_["1043ui_story"].transform.localEulerAngles = arg_585_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_588_1 = arg_585_1.actors_["1043ui_story"]

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(var_588_1) and arg_585_1.var_.characterEffect1043ui_story == nil then
				arg_585_1.var_.characterEffect1043ui_story = var_588_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_2 = 0.200000002980232

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_2 and not isNil(var_588_1) then
				if arg_585_1.var_.characterEffect1043ui_story and not isNil(var_588_1) then
					arg_585_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= 0 + var_588_2 and arg_585_1.time_ < 0 + var_588_2 + arg_588_0 and not isNil(var_588_1) and arg_585_1.var_.characterEffect1043ui_story then
				arg_585_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_588_4 = 0
			local var_588_5 = 0.3

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_4 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_6 = arg_585_1:GetWordFromCfg(321301144)
				local var_588_7 = arg_585_1:FormatText(var_588_6.content)

				arg_585_1.text_.text = var_588_7

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_9 = 12 <= 0 and var_588_5 or var_588_5 * (utf8.len(var_588_7) / 12)

				if (12 <= 0 and var_588_5 or var_588_5 * (utf8.len(var_588_7) / 12)) > 0 and var_588_5 < var_588_9 then
					arg_585_1.talkMaxDuration = var_588_9

					if var_588_9 + var_588_4 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_9 + var_588_4
					end
				end

				arg_585_1.text_.text = var_588_7
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301144", "story_v_out_321301.awb") ~= 0 then
					local var_588_10 = manager.audio:GetVoiceLength("story_v_out_321301", "321301144", "story_v_out_321301.awb") / 1000

					if var_588_10 + var_588_4 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_10 + var_588_4
					end

					if var_588_6.prefab_name ~= "" and arg_585_1.actors_[var_588_6.prefab_name] ~= nil then
						local var_588_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_6.prefab_name].transform, "story_v_out_321301", "321301144", "story_v_out_321301.awb")

						arg_585_1:RecordAudio("321301144", var_588_11)
						arg_585_1:RecordAudio("321301144", var_588_11)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_321301", "321301144", "story_v_out_321301.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_321301", "321301144", "story_v_out_321301.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_12 = math.max(var_588_5, arg_585_1.talkMaxDuration)

			if var_588_4 <= arg_585_1.time_ and arg_585_1.time_ < var_588_4 + var_588_12 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_4) / var_588_12

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_4 + var_588_12 and arg_585_1.time_ < var_588_4 + var_588_12 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play321301145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 321301145
		arg_589_1.duration_ = 3.1

		local var_589_0 = {
			zh = 3.066,
			ja = 3.1
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
			arg_589_1.auto_ = false
		end

		function arg_589_1.playNext_(arg_591_0)
			arg_589_1.onStoryFinished_()
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.325

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_1 = arg_589_1:GetWordFromCfg(321301145)
				local var_592_2 = arg_589_1:FormatText(var_592_1.content)

				arg_589_1.text_.text = var_592_2

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_4 = 13 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_2) / 13)

				if (13 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_2) / 13)) > 0 and var_592_0 < var_592_4 then
					arg_589_1.talkMaxDuration = var_592_4

					if var_592_4 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_4 + 0
					end
				end

				arg_589_1.text_.text = var_592_2
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321301", "321301145", "story_v_out_321301.awb") ~= 0 then
					local var_592_5 = manager.audio:GetVoiceLength("story_v_out_321301", "321301145", "story_v_out_321301.awb") / 1000

					if var_592_5 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_5 + 0
					end

					if var_592_1.prefab_name ~= "" and arg_589_1.actors_[var_592_1.prefab_name] ~= nil then
						local var_592_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_1.prefab_name].transform, "story_v_out_321301", "321301145", "story_v_out_321301.awb")

						arg_589_1:RecordAudio("321301145", var_592_6)
						arg_589_1:RecordAudio("321301145", var_592_6)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_321301", "321301145", "story_v_out_321301.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_321301", "321301145", "story_v_out_321301.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_7 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_7 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_7

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_7 and arg_589_1.time_ < 0 + var_592_7 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09g",
		"TextureConfig/Background/L09h"
	},
	voices = {
		"story_v_out_321301.awb"
	}
}
