return {
	Play411081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B02d == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B02d")
				var_4_0.name = "B02d"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B02d = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B02d

				arg_1_1.bgs_.B02d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02d" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.6 < arg_1_1.time_ and arg_1_1.time_ <= 0.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 1.999999999999
			local var_4_16 = 0.775

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411081001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 31 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 31)

				if (31 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 31)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411081002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1095ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1095ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1095ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1095ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1095ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1095ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1095ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1095ui_story == nil then
				arg_9_1.var_.characterEffect1095ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1095ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1095ui_story then
				arg_9_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action8_2")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(411081002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 3 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 3)

				if (3 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 3)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081002", "story_v_out_411081.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_411081", "411081002", "story_v_out_411081.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_411081", "411081002", "story_v_out_411081.awb")

						arg_9_1:RecordAudio("411081002", var_12_15)
						arg_9_1:RecordAudio("411081002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_411081", "411081002", "story_v_out_411081.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_411081", "411081002", "story_v_out_411081.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) and arg_13_1.var_.characterEffect1095ui_story == nil then
				arg_13_1.var_.characterEffect1095ui_story = arg_13_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) then
				if arg_13_1.var_.characterEffect1095ui_story and not isNil(arg_13_1.actors_["1095ui_story"]) then
					arg_13_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) and arg_13_1.var_.characterEffect1095ui_story then
				arg_13_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_131", "se_story_131__fallmetal", "")
			end

			local var_16_2 = 0
			local var_16_3 = 1.05

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(411081003).content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 42 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 42)

				if (42 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 42)) > 0 and var_16_3 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_7 and arg_13_1.time_ < var_16_2 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play411081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411081004
		arg_17_1.duration_ = 1.7

		local var_17_0 = {
			zh = 1.7,
			ja = 1.6
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
				arg_17_0:Play411081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = arg_17_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(arg_17_1.actors_["1095ui_story"]) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_20_2 = 0
			local var_20_3 = 0.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(411081004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 3 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 3)

				if (3 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 3)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081004", "story_v_out_411081.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081004", "story_v_out_411081.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_411081", "411081004", "story_v_out_411081.awb")

						arg_17_1:RecordAudio("411081004", var_20_9)
						arg_17_1:RecordAudio("411081004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_411081", "411081004", "story_v_out_411081.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_411081", "411081004", "story_v_out_411081.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play411081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411081005
		arg_21_1.duration_ = 4.63

		local var_21_0 = {
			zh = 4.3,
			ja = 4.633
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
				arg_21_0:Play411081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(411081005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 20 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 20)

				if (20 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 20)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081005", "story_v_out_411081.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081005", "story_v_out_411081.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_411081", "411081005", "story_v_out_411081.awb")

						arg_21_1:RecordAudio("411081005", var_24_6)
						arg_21_1:RecordAudio("411081005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_411081", "411081005", "story_v_out_411081.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_411081", "411081005", "story_v_out_411081.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play411081006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411081006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play411081007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = arg_25_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(arg_25_1.actors_["1095ui_story"]) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.35

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(411081006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 54 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 54)

				if (54 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 54)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411081007
		arg_29_1.duration_ = 4.13

		local var_29_0 = {
			zh = 3.533,
			ja = 4.133
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
				arg_29_0:Play411081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1095ui_story = arg_29_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).z)
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles = arg_29_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_29_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1095ui_story"].transform.position).z)
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1095ui_story"].transform.localEulerAngles = arg_29_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1095ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1095ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1095ui_story then
				arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.45

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(411081007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 18 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 18)

				if (18 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 18)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081007", "story_v_out_411081.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081007", "story_v_out_411081.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_411081", "411081007", "story_v_out_411081.awb")

						arg_29_1:RecordAudio("411081007", var_32_11)
						arg_29_1:RecordAudio("411081007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411081", "411081007", "story_v_out_411081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411081", "411081007", "story_v_out_411081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play411081008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411081008
		arg_33_1.duration_ = 4.8

		local var_33_0 = {
			zh = 4.8,
			ja = 3.366
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
				arg_33_0:Play411081009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(411081008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 21 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 21)

				if (21 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 21)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081008", "story_v_out_411081.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081008", "story_v_out_411081.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_411081", "411081008", "story_v_out_411081.awb")

						arg_33_1:RecordAudio("411081008", var_36_6)
						arg_33_1:RecordAudio("411081008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_411081", "411081008", "story_v_out_411081.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_411081", "411081008", "story_v_out_411081.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play411081009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411081009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411081010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = arg_37_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) then
				if arg_37_1.var_.characterEffect1095ui_story and not isNil(arg_37_1.actors_["1095ui_story"]) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_fastshot", "")
			end

			local var_40_2 = arg_37_1.actors_["1095ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1095ui_story = var_40_2.localPosition
			end

			local var_40_3 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_3)
				var_40_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_2.position).x, (manager.ui.mainCamera.transform.position - var_40_2.position).y, (manager.ui.mainCamera.transform.position - var_40_2.position).z)
				var_40_2.localEulerAngles.z = 0
				var_40_2.localEulerAngles.x = 0
				var_40_2.localEulerAngles = var_40_2.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(0, 100, 0)
				var_40_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_2.position).x, (manager.ui.mainCamera.transform.position - var_40_2.position).y, (manager.ui.mainCamera.transform.position - var_40_2.position).z)
				var_40_2.localEulerAngles.z = 0
				var_40_2.localEulerAngles.x = 0
				var_40_2.localEulerAngles = var_40_2.localEulerAngles
			end

			local var_40_4 = 0
			local var_40_5 = 1.5

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(411081009).content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_8 = 60 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_6) / 60)

				if (60 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_6) / 60)) > 0 and var_40_5 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_9 and arg_37_1.time_ < var_40_4 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play411081010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411081010
		arg_41_1.duration_ = 11.27

		local var_41_0 = {
			zh = 5.566,
			ja = 11.266
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
				arg_41_0:Play411081011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1095ui_story"]) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = arg_41_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1095ui_story"]) then
				if arg_41_1.var_.characterEffect1095ui_story and not isNil(arg_41_1.actors_["1095ui_story"]) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1095ui_story"]) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["1095ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1095ui_story = var_44_2.localPosition
			end

			local var_44_3 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_41_1.time_ - 0) / var_44_3)
				var_44_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_2.position).x, (manager.ui.mainCamera.transform.position - var_44_2.position).y, (manager.ui.mainCamera.transform.position - var_44_2.position).z)
				var_44_2.localEulerAngles.z = 0
				var_44_2.localEulerAngles.x = 0
				var_44_2.localEulerAngles = var_44_2.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_44_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_2.position).x, (manager.ui.mainCamera.transform.position - var_44_2.position).y, (manager.ui.mainCamera.transform.position - var_44_2.position).z)
				var_44_2.localEulerAngles.z = 0
				var_44_2.localEulerAngles.x = 0
				var_44_2.localEulerAngles = var_44_2.localEulerAngles
			end

			local var_44_4 = 0
			local var_44_5 = 0.7

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(411081010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 28 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 28)

				if (28 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 28)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081010", "story_v_out_411081.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081010", "story_v_out_411081.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_411081", "411081010", "story_v_out_411081.awb")

						arg_41_1:RecordAudio("411081010", var_44_11)
						arg_41_1:RecordAudio("411081010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_411081", "411081010", "story_v_out_411081.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_411081", "411081010", "story_v_out_411081.awb")
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

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play411081011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411081011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play411081012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1095ui_story = arg_45_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).z)
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles = arg_45_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).z)
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles = arg_45_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_48_1 = manager.ui.mainCamera.transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.shakeOldPos = var_48_1.localPosition
			end

			local var_48_2 = 0.766666666666667

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				local var_48_3, var_48_4 = math.modf((arg_45_1.time_ - 0) / 0.066)

				var_48_1.localPosition = Vector3.New(var_48_4 * 0.13, var_48_4 * 0.13, var_48_4 * 0.13) + arg_45_1.var_.shakeOldPos
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = arg_45_1.var_.shakeOldPos
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_fastshot", "")
			end

			local var_48_6 = 0
			local var_48_7 = 1.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(411081011).content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 45 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_8) / 45)

				if (45 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_8) / 45)) > 0 and var_48_7 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_11 and arg_45_1.time_ < var_48_6 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play411081012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411081012
		arg_49_1.duration_ = 5.2

		local var_49_0 = {
			zh = 5.2,
			ja = 4.033
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play411081013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = arg_49_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) then
				if arg_49_1.var_.characterEffect1095ui_story and not isNil(arg_49_1.actors_["1095ui_story"]) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["1095ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1095ui_story = var_52_2.localPosition
			end

			local var_52_3 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_49_1.time_ - 0) / var_52_3)
				var_52_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_2.position).x, (manager.ui.mainCamera.transform.position - var_52_2.position).y, (manager.ui.mainCamera.transform.position - var_52_2.position).z)
				var_52_2.localEulerAngles.z = 0
				var_52_2.localEulerAngles.x = 0
				var_52_2.localEulerAngles = var_52_2.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_52_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_2.position).x, (manager.ui.mainCamera.transform.position - var_52_2.position).y, (manager.ui.mainCamera.transform.position - var_52_2.position).z)
				var_52_2.localEulerAngles.z = 0
				var_52_2.localEulerAngles.x = 0
				var_52_2.localEulerAngles = var_52_2.localEulerAngles
			end

			local var_52_4 = 0
			local var_52_5 = 0.575

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(411081012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 23 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 23)

				if (23 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 23)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081012", "story_v_out_411081.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081012", "story_v_out_411081.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_411081", "411081012", "story_v_out_411081.awb")

						arg_49_1:RecordAudio("411081012", var_52_11)
						arg_49_1:RecordAudio("411081012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_411081", "411081012", "story_v_out_411081.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_411081", "411081012", "story_v_out_411081.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411081013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411081013
		arg_53_1.duration_ = 5.7

		local var_53_0 = {
			zh = 4.733,
			ja = 5.7
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play411081014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1095ui_story = arg_53_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).z)
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles = arg_53_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_53_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1095ui_story"].transform.position).z)
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1095ui_story"].transform.localEulerAngles = arg_53_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1095ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1095ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1095ui_story then
				arg_53_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_56_4 = 0
			local var_56_5 = 0.475

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(411081013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 19 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 19)

				if (19 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 19)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081013", "story_v_out_411081.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081013", "story_v_out_411081.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_411081", "411081013", "story_v_out_411081.awb")

						arg_53_1:RecordAudio("411081013", var_56_11)
						arg_53_1:RecordAudio("411081013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_411081", "411081013", "story_v_out_411081.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_411081", "411081013", "story_v_out_411081.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play411081014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411081014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play411081015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = arg_57_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) then
				if arg_57_1.var_.characterEffect1095ui_story and not isNil(arg_57_1.actors_["1095ui_story"]) then
					arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1095ui_story"]) and arg_57_1.var_.characterEffect1095ui_story then
				arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_60_1 = arg_57_1.actors_["1095ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1095ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, 100, 0)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = 0
			local var_60_4 = 0.725

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(411081014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 29 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 29)

				if (29 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 29)) > 0 and var_60_4 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_8 and arg_57_1.time_ < var_60_3 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play411081015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411081015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play411081016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.7

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(411081015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 28 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 28)

				if (28 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 28)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play411081016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411081016
		arg_65_1.duration_ = 1

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play411081017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.05

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(411081016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 2 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 2)

				if (2 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 2)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081016", "story_v_out_411081.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081016", "story_v_out_411081.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_411081", "411081016", "story_v_out_411081.awb")

						arg_65_1:RecordAudio("411081016", var_68_6)
						arg_65_1:RecordAudio("411081016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_411081", "411081016", "story_v_out_411081.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_411081", "411081016", "story_v_out_411081.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play411081017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411081017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play411081018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun05", "")
			end

			local var_72_1 = 0
			local var_72_2 = 0.975

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(411081017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 39 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 39)

				if (39 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 39)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play411081018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 411081018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play411081019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_76_0 = 0.5

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				local var_76_1, var_76_2 = math.modf((arg_73_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_76_2 * 0.13, var_76_2 * 0.13, var_76_2 * 0.13) + arg_73_1.var_.shakeOldPos
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				manager.ui.mainCamera.transform.localPosition = arg_73_1.var_.shakeOldPos
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_76_4 = 0
			local var_76_5 = 1.6

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_6 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_6:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(411081018).content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 64 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 64)

				if (64 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 64)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9
					var_76_4 = var_76_4 + 0.3

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = var_76_4 + 0.3
			local var_76_11 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_10) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play411081019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411081019
		arg_79_1.duration_ = 3.57

		local var_79_0 = {
			zh = 2.166,
			ja = 3.566
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play411081020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[680].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2018")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:GetWordFromCfg(411081019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 4 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 4)

				if (4 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 4)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081019", "story_v_out_411081.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081019", "story_v_out_411081.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_411081", "411081019", "story_v_out_411081.awb")

						arg_79_1:RecordAudio("411081019", var_82_6)
						arg_79_1:RecordAudio("411081019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_411081", "411081019", "story_v_out_411081.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_411081", "411081019", "story_v_out_411081.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play411081020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411081020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play411081021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(411081020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 40 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 40)

				if (40 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 40)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play411081021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411081021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411081022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.075

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(411081021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 43 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 43)

				if (43 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 43)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play411081022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 411081022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play411081023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_94_0 = 0.6

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				local var_94_1, var_94_2 = math.modf((arg_91_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_94_2 * 0.13, var_94_2 * 0.13, var_94_2 * 0.13) + arg_91_1.var_.shakeOldPos
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				manager.ui.mainCamera.transform.localPosition = arg_91_1.var_.shakeOldPos
			end

			local var_94_3 = 0

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			if arg_91_1.time_ >= var_94_3 + 0.6 and arg_91_1.time_ < var_94_3 + 0.6 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_15", "se_story_15_roar3", "")
			end

			local var_94_5 = 0
			local var_94_6 = 0.15

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[683].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_robota")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_7 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(411081022).content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 6 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_7) / 6)

				if (6 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_7) / 6)) > 0 and var_94_6 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_6, arg_91_1.talkMaxDuration)

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_5) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_5 + var_94_10 and arg_91_1.time_ < var_94_5 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play411081023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 411081023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play411081024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.65

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(411081023).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 66 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 66)

				if (66 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 66)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play411081024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 411081024
		arg_99_1.duration_ = 9

		local var_99_0 = {
			zh = 9,
			ja = 7.9
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play411081025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_0 = 2.033333333332

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				local var_102_1 = Color.New(0, 0, 0)

				var_102_1.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.mask_.color = var_102_1
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				local var_102_2 = Color.New(0, 0, 0)

				var_102_2.a = 1
				arg_99_1.mask_.color = var_102_2
			end

			local var_102_3 = 2.033333333332

			if 2.033333333332 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_4 = 1.966666666668

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_4 then
				local var_102_5 = Color.New(0, 0, 0)

				var_102_5.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_3) / var_102_4)
				arg_99_1.mask_.color = var_102_5
			end

			if arg_99_1.time_ >= var_102_3 + var_102_4 and arg_99_1.time_ < var_102_3 + var_102_4 + arg_102_0 then
				local var_102_6 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_6.a = 0
				arg_99_1.mask_.color = var_102_6
			end

			if 2.033333333332 < arg_99_1.time_ and arg_99_1.time_ <= 2.033333333332 + arg_102_0 then
				local var_102_7 = arg_99_1.bgs_.B02d

				arg_99_1.bgs_.B02d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_8 = var_102_7:GetComponent("SpriteRenderer")

				if var_102_8 and var_102_8.sprite then
					local var_102_9 = 2 * (var_102_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_7.transform.localScale = Vector3.New(var_102_9 / var_102_8.sprite.bounds.size.y < var_102_9 * manager.ui.mainCameraCom_.aspect / var_102_8.sprite.bounds.size.x and var_102_9 * manager.ui.mainCameraCom_.aspect / var_102_8.sprite.bounds.size.x or var_102_9 / var_102_8.sprite.bounds.size.y, var_102_9 / var_102_8.sprite.bounds.size.y < var_102_9 * manager.ui.mainCameraCom_.aspect / var_102_8.sprite.bounds.size.x and var_102_9 * manager.ui.mainCameraCom_.aspect / var_102_8.sprite.bounds.size.x or var_102_9 / var_102_8.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "B02d" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_10 = 4
			local var_102_11 = 0.675

			if 4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_12 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_12:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_13 = arg_99_1:GetWordFromCfg(411081024)
				local var_102_14 = arg_99_1:FormatText(var_102_13.content)

				arg_99_1.text_.text = var_102_14

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_16 = 27 <= 0 and var_102_11 or var_102_11 * (utf8.len(var_102_14) / 27)

				if (27 <= 0 and var_102_11 or var_102_11 * (utf8.len(var_102_14) / 27)) > 0 and var_102_11 < var_102_16 then
					arg_99_1.talkMaxDuration = var_102_16
					var_102_10 = var_102_10 + 0.3

					if var_102_16 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_10
					end
				end

				arg_99_1.text_.text = var_102_14
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081024", "story_v_out_411081.awb") ~= 0 then
					local var_102_17 = manager.audio:GetVoiceLength("story_v_out_411081", "411081024", "story_v_out_411081.awb") / 1000

					if var_102_17 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_10
					end

					if var_102_13.prefab_name ~= "" and arg_99_1.actors_[var_102_13.prefab_name] ~= nil then
						local var_102_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_13.prefab_name].transform, "story_v_out_411081", "411081024", "story_v_out_411081.awb")

						arg_99_1:RecordAudio("411081024", var_102_18)
						arg_99_1:RecordAudio("411081024", var_102_18)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_411081", "411081024", "story_v_out_411081.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_411081", "411081024", "story_v_out_411081.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_19 = var_102_10 + 0.3
			local var_102_20 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_10 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_19 + var_102_20 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_19) / var_102_20

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_19 + var_102_20 and arg_99_1.time_ < var_102_19 + var_102_20 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play411081025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411081025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play411081026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.1

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(411081025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 44 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 44)

				if (44 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 44)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play411081026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 411081026
		arg_109_1.duration_ = 5.17

		local var_109_0 = {
			zh = 3.633,
			ja = 5.166
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
				arg_109_0:Play411081027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1095ui_story = arg_109_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).z)
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles = arg_109_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_109_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).z)
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles = arg_109_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1095ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1095ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action8_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.4

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(411081026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 16 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 16)

				if (16 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 16)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081026", "story_v_out_411081.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081026", "story_v_out_411081.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_411081", "411081026", "story_v_out_411081.awb")

						arg_109_1:RecordAudio("411081026", var_112_11)
						arg_109_1:RecordAudio("411081026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_411081", "411081026", "story_v_out_411081.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_411081", "411081026", "story_v_out_411081.awb")
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

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play411081027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 411081027
		arg_113_1.duration_ = 10.7

		local var_113_0 = {
			zh = 9.066,
			ja = 10.7
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
				arg_113_0:Play411081028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) and arg_113_1.var_.characterEffect1095ui_story == nil then
				arg_113_1.var_.characterEffect1095ui_story = arg_113_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) then
				if arg_113_1.var_.characterEffect1095ui_story and not isNil(arg_113_1.actors_["1095ui_story"]) then
					arg_113_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) and arg_113_1.var_.characterEffect1095ui_story then
				arg_113_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 1.15

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(411081027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 46 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 46)

				if (46 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 46)) > 0 and var_116_2 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081027", "story_v_out_411081.awb") ~= 0 then
					local var_116_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081027", "story_v_out_411081.awb") / 1000

					if var_116_7 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_1
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_411081", "411081027", "story_v_out_411081.awb")

						arg_113_1:RecordAudio("411081027", var_116_8)
						arg_113_1:RecordAudio("411081027", var_116_8)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_411081", "411081027", "story_v_out_411081.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_411081", "411081027", "story_v_out_411081.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_9 and arg_113_1.time_ < var_116_1 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play411081028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 411081028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play411081029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.575

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(411081028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 23 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 23)

				if (23 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 23)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play411081029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 411081029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play411081030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1095ui_story = arg_121_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).z)
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles = arg_121_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).z)
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles = arg_121_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_124_1 = 0
			local var_124_2 = 1.25

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(411081029).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 50 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 50)

				if (50 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 50)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play411081030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 411081030
		arg_125_1.duration_ = 8.83

		local var_125_0 = {
			zh = 6.5,
			ja = 8.833
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
				arg_125_0:Play411081031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if arg_125_1.bgs_.B06a == nil then
				local var_128_0 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B06a")
				var_128_0.name = "B06a"
				var_128_0.transform.parent = arg_125_1.stage_.transform
				var_128_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_.B06a = var_128_0
			end

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				local var_128_1 = arg_125_1.bgs_.B06a

				arg_125_1.bgs_.B06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_128_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_2 = var_128_1:GetComponent("SpriteRenderer")

				if var_128_2 and var_128_2.sprite then
					local var_128_3 = 2 * (var_128_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_128_1.transform.localScale = Vector3.New(var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "B06a" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_4 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_5 = 2

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_5 then
				local var_128_6 = Color.New(0, 0, 0)

				var_128_6.a = Mathf.Lerp(0, 1, (arg_125_1.time_ - var_128_4) / var_128_5)
				arg_125_1.mask_.color = var_128_6
			end

			if arg_125_1.time_ >= var_128_4 + var_128_5 and arg_125_1.time_ < var_128_4 + var_128_5 + arg_128_0 then
				local var_128_7 = Color.New(0, 0, 0)

				var_128_7.a = 1
				arg_125_1.mask_.color = var_128_7
			end

			local var_128_8 = 2

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_9 = 2

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_9 then
				local var_128_10 = Color.New(0, 0, 0)

				var_128_10.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_8) / var_128_9)
				arg_125_1.mask_.color = var_128_10
			end

			if arg_125_1.time_ >= var_128_8 + var_128_9 and arg_125_1.time_ < var_128_8 + var_128_9 + arg_128_0 then
				local var_128_11 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_11.a = 0
				arg_125_1.mask_.color = var_128_11
			end

			local var_128_12 = arg_125_1.actors_["1095ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1095ui_story = var_128_12.localPosition
			end

			local var_128_13 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_13 then
				var_128_12.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_13)
				var_128_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_12.position).x, (manager.ui.mainCamera.transform.position - var_128_12.position).y, (manager.ui.mainCamera.transform.position - var_128_12.position).z)
				var_128_12.localEulerAngles.z = 0
				var_128_12.localEulerAngles.x = 0
				var_128_12.localEulerAngles = var_128_12.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_13 and arg_125_1.time_ < 0 + var_128_13 + arg_128_0 then
				var_128_12.localPosition = Vector3.New(0, 100, 0)
				var_128_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_12.position).x, (manager.ui.mainCamera.transform.position - var_128_12.position).y, (manager.ui.mainCamera.transform.position - var_128_12.position).z)
				var_128_12.localEulerAngles.z = 0
				var_128_12.localEulerAngles.x = 0
				var_128_12.localEulerAngles = var_128_12.localEulerAngles
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_14 = 4
			local var_128_15 = 0.225

			if 4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_16 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_16:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_17 = arg_125_1:GetWordFromCfg(411081030)
				local var_128_18 = arg_125_1:FormatText(var_128_17.content)

				arg_125_1.text_.text = var_128_18

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 9 <= 0 and var_128_15 or var_128_15 * (utf8.len(var_128_18) / 9)

				if (9 <= 0 and var_128_15 or var_128_15 * (utf8.len(var_128_18) / 9)) > 0 and var_128_15 < var_128_20 then
					arg_125_1.talkMaxDuration = var_128_20
					var_128_14 = var_128_14 + 0.3

					if var_128_20 + var_128_14 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_14
					end
				end

				arg_125_1.text_.text = var_128_18
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081030", "story_v_out_411081.awb") ~= 0 then
					local var_128_21 = manager.audio:GetVoiceLength("story_v_out_411081", "411081030", "story_v_out_411081.awb") / 1000

					if var_128_21 + var_128_14 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_21 + var_128_14
					end

					if var_128_17.prefab_name ~= "" and arg_125_1.actors_[var_128_17.prefab_name] ~= nil then
						local var_128_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_17.prefab_name].transform, "story_v_out_411081", "411081030", "story_v_out_411081.awb")

						arg_125_1:RecordAudio("411081030", var_128_22)
						arg_125_1:RecordAudio("411081030", var_128_22)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_411081", "411081030", "story_v_out_411081.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_411081", "411081030", "story_v_out_411081.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_23 = var_128_14 + 0.3
			local var_128_24 = math.max(var_128_15, arg_125_1.talkMaxDuration)

			if var_128_14 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_24 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_23) / var_128_24

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_23 + var_128_24 and arg_125_1.time_ < var_128_23 + var_128_24 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411081031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411081031
		arg_131_1.duration_ = 7.2

		local var_131_0 = {
			zh = 6.133,
			ja = 7.2
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411081032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.85

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:GetWordFromCfg(411081031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 34 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 34)

				if (34 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 34)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081031", "story_v_out_411081.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081031", "story_v_out_411081.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_411081", "411081031", "story_v_out_411081.awb")

						arg_131_1:RecordAudio("411081031", var_134_6)
						arg_131_1:RecordAudio("411081031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_411081", "411081031", "story_v_out_411081.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_411081", "411081031", "story_v_out_411081.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play411081032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411081032
		arg_135_1.duration_ = 3.53

		local var_135_0 = {
			zh = 2.033,
			ja = 3.533
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play411081033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.2

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(411081032)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 8 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 8)

				if (8 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 8)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081032", "story_v_out_411081.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081032", "story_v_out_411081.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_411081", "411081032", "story_v_out_411081.awb")

						arg_135_1:RecordAudio("411081032", var_138_6)
						arg_135_1:RecordAudio("411081032", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_411081", "411081032", "story_v_out_411081.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_411081", "411081032", "story_v_out_411081.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play411081033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411081033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play411081034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.85

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(411081033).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 34 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 34)

				if (34 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 34)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play411081034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411081034
		arg_143_1.duration_ = 3.63

		local var_143_0 = {
			zh = 3.033,
			ja = 3.633
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play411081035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1095ui_story = arg_143_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1095ui_story"].transform.position).z)
				arg_143_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1095ui_story"].transform.localEulerAngles = arg_143_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_143_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1095ui_story"].transform.position).z)
				arg_143_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1095ui_story"].transform.localEulerAngles = arg_143_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1095ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1095ui_story == nil then
				arg_143_1.var_.characterEffect1095ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1095ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1095ui_story then
				arg_143_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_146_4 = 0
			local var_146_5 = 0.225

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(411081034)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 9 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 9)

				if (9 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 9)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081034", "story_v_out_411081.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081034", "story_v_out_411081.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_411081", "411081034", "story_v_out_411081.awb")

						arg_143_1:RecordAudio("411081034", var_146_11)
						arg_143_1:RecordAudio("411081034", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_411081", "411081034", "story_v_out_411081.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_411081", "411081034", "story_v_out_411081.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play411081035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411081035
		arg_147_1.duration_ = 4.87

		local var_147_0 = {
			zh = 3.733,
			ja = 4.866
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play411081036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1095ui_story"]) and arg_147_1.var_.characterEffect1095ui_story == nil then
				arg_147_1.var_.characterEffect1095ui_story = arg_147_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1095ui_story"]) then
				if arg_147_1.var_.characterEffect1095ui_story and not isNil(arg_147_1.actors_["1095ui_story"]) then
					arg_147_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1095ui_story"]) and arg_147_1.var_.characterEffect1095ui_story then
				arg_147_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.475

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(411081035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 19 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_4) / 19)

				if (19 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_4) / 19)) > 0 and var_150_2 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081035", "story_v_out_411081.awb") ~= 0 then
					local var_150_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081035", "story_v_out_411081.awb") / 1000

					if var_150_7 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_1
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_411081", "411081035", "story_v_out_411081.awb")

						arg_147_1:RecordAudio("411081035", var_150_8)
						arg_147_1:RecordAudio("411081035", var_150_8)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_411081", "411081035", "story_v_out_411081.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_411081", "411081035", "story_v_out_411081.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_9 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_9 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_9

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_9 and arg_147_1.time_ < var_150_1 + var_150_9 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play411081036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411081036
		arg_151_1.duration_ = 7.3

		local var_151_0 = {
			zh = 7.3,
			ja = 5.066
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play411081037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.75

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_1 = arg_151_1:GetWordFromCfg(411081036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 30 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 30)

				if (30 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 30)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081036", "story_v_out_411081.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081036", "story_v_out_411081.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_411081", "411081036", "story_v_out_411081.awb")

						arg_151_1:RecordAudio("411081036", var_154_6)
						arg_151_1:RecordAudio("411081036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_411081", "411081036", "story_v_out_411081.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_411081", "411081036", "story_v_out_411081.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play411081037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411081037
		arg_155_1.duration_ = 6.17

		local var_155_0 = {
			zh = 6.166,
			ja = 4.6
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play411081038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1095ui_story"]) and arg_155_1.var_.characterEffect1095ui_story == nil then
				arg_155_1.var_.characterEffect1095ui_story = arg_155_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1095ui_story"]) then
				if arg_155_1.var_.characterEffect1095ui_story and not isNil(arg_155_1.actors_["1095ui_story"]) then
					arg_155_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1095ui_story"]) and arg_155_1.var_.characterEffect1095ui_story then
				arg_155_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_158_2 = 0
			local var_158_3 = 0.55

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(411081037)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 22 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 22)

				if (22 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 22)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081037", "story_v_out_411081.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081037", "story_v_out_411081.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_411081", "411081037", "story_v_out_411081.awb")

						arg_155_1:RecordAudio("411081037", var_158_9)
						arg_155_1:RecordAudio("411081037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411081", "411081037", "story_v_out_411081.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411081", "411081037", "story_v_out_411081.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play411081038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411081038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play411081039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1095ui_story"]) and arg_159_1.var_.characterEffect1095ui_story == nil then
				arg_159_1.var_.characterEffect1095ui_story = arg_159_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1095ui_story"]) then
				if arg_159_1.var_.characterEffect1095ui_story and not isNil(arg_159_1.actors_["1095ui_story"]) then
					arg_159_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1095ui_story"]) and arg_159_1.var_.characterEffect1095ui_story then
				arg_159_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 1.45

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(411081038).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 58 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 58)

				if (58 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 58)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play411081039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411081039
		arg_163_1.duration_ = 6.03

		local var_163_0 = {
			zh = 4.2,
			ja = 6.033
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play411081040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1095ui_story"]) and arg_163_1.var_.characterEffect1095ui_story == nil then
				arg_163_1.var_.characterEffect1095ui_story = arg_163_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1095ui_story"]) then
				if arg_163_1.var_.characterEffect1095ui_story and not isNil(arg_163_1.actors_["1095ui_story"]) then
					arg_163_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1095ui_story"]) and arg_163_1.var_.characterEffect1095ui_story then
				arg_163_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_166_2 = 0
			local var_166_3 = 0.55

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(411081039)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 22 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 22)

				if (22 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 22)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081039", "story_v_out_411081.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081039", "story_v_out_411081.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_411081", "411081039", "story_v_out_411081.awb")

						arg_163_1:RecordAudio("411081039", var_166_9)
						arg_163_1:RecordAudio("411081039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_411081", "411081039", "story_v_out_411081.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_411081", "411081039", "story_v_out_411081.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play411081040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411081040
		arg_167_1.duration_ = 8.97

		local var_167_0 = {
			zh = 8.333,
			ja = 8.966
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play411081041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1095ui_story = arg_167_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).z)
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles = arg_167_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_167_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).z)
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles = arg_167_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1095ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1095ui_story == nil then
				arg_167_1.var_.characterEffect1095ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1095ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1095ui_story then
				arg_167_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_4 = 0
			local var_170_5 = 0.65

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(411081040)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 26 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 26)

				if (26 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 26)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081040", "story_v_out_411081.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081040", "story_v_out_411081.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_411081", "411081040", "story_v_out_411081.awb")

						arg_167_1:RecordAudio("411081040", var_170_11)
						arg_167_1:RecordAudio("411081040", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411081", "411081040", "story_v_out_411081.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411081", "411081040", "story_v_out_411081.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play411081041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411081041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411081042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1095ui_story"]) and arg_171_1.var_.characterEffect1095ui_story == nil then
				arg_171_1.var_.characterEffect1095ui_story = arg_171_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1095ui_story"]) then
				if arg_171_1.var_.characterEffect1095ui_story and not isNil(arg_171_1.actors_["1095ui_story"]) then
					arg_171_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1095ui_story"]) and arg_171_1.var_.characterEffect1095ui_story then
				arg_171_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.325

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(411081041).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 13 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 13)

				if (13 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 13)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play411081042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411081042
		arg_175_1.duration_ = 3.7

		local var_175_0 = {
			zh = 2.666,
			ja = 3.7
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411081043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.375

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(411081042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 15 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 15)

				if (15 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 15)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081042", "story_v_out_411081.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081042", "story_v_out_411081.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_411081", "411081042", "story_v_out_411081.awb")

						arg_175_1:RecordAudio("411081042", var_178_6)
						arg_175_1:RecordAudio("411081042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_411081", "411081042", "story_v_out_411081.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_411081", "411081042", "story_v_out_411081.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play411081043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411081043
		arg_179_1.duration_ = 7.2

		local var_179_0 = {
			zh = 7.2,
			ja = 6.8
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play411081044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.075

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:GetWordFromCfg(411081043)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 43 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 43)

				if (43 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 43)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081043", "story_v_out_411081.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081043", "story_v_out_411081.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_411081", "411081043", "story_v_out_411081.awb")

						arg_179_1:RecordAudio("411081043", var_182_6)
						arg_179_1:RecordAudio("411081043", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_411081", "411081043", "story_v_out_411081.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_411081", "411081043", "story_v_out_411081.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play411081044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411081044
		arg_183_1.duration_ = 4.3

		local var_183_0 = {
			zh = 2.933,
			ja = 4.3
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play411081045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.3

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:GetWordFromCfg(411081044)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 12 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 12)

				if (12 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 12)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081044", "story_v_out_411081.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081044", "story_v_out_411081.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_411081", "411081044", "story_v_out_411081.awb")

						arg_183_1:RecordAudio("411081044", var_186_6)
						arg_183_1:RecordAudio("411081044", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_411081", "411081044", "story_v_out_411081.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_411081", "411081044", "story_v_out_411081.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play411081045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411081045
		arg_187_1.duration_ = 1.63

		local var_187_0 = {
			zh = 1.633,
			ja = 0.999999999999
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play411081046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1095ui_story"]) and arg_187_1.var_.characterEffect1095ui_story == nil then
				arg_187_1.var_.characterEffect1095ui_story = arg_187_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1095ui_story"]) then
				if arg_187_1.var_.characterEffect1095ui_story and not isNil(arg_187_1.actors_["1095ui_story"]) then
					arg_187_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1095ui_story"]) and arg_187_1.var_.characterEffect1095ui_story then
				arg_187_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_190_2 = 0
			local var_190_3 = 0.05

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(411081045)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 2 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 2)

				if (2 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_5) / 2)) > 0 and var_190_3 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081045", "story_v_out_411081.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081045", "story_v_out_411081.awb") / 1000

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end

					if var_190_4.prefab_name ~= "" and arg_187_1.actors_[var_190_4.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_4.prefab_name].transform, "story_v_out_411081", "411081045", "story_v_out_411081.awb")

						arg_187_1:RecordAudio("411081045", var_190_9)
						arg_187_1:RecordAudio("411081045", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_411081", "411081045", "story_v_out_411081.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_411081", "411081045", "story_v_out_411081.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_10 and arg_187_1.time_ < var_190_2 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play411081046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411081046
		arg_191_1.duration_ = 6.27

		local var_191_0 = {
			zh = 6.266,
			ja = 3.033
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play411081047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1095ui_story"]) and arg_191_1.var_.characterEffect1095ui_story == nil then
				arg_191_1.var_.characterEffect1095ui_story = arg_191_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1095ui_story"]) then
				if arg_191_1.var_.characterEffect1095ui_story and not isNil(arg_191_1.actors_["1095ui_story"]) then
					arg_191_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1095ui_story"]) and arg_191_1.var_.characterEffect1095ui_story then
				arg_191_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.5

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(411081046)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_6 = 20 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_4) / 20)

				if (20 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_4) / 20)) > 0 and var_194_2 < var_194_6 then
					arg_191_1.talkMaxDuration = var_194_6

					if var_194_6 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_6 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081046", "story_v_out_411081.awb") ~= 0 then
					local var_194_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081046", "story_v_out_411081.awb") / 1000

					if var_194_7 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_1
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_411081", "411081046", "story_v_out_411081.awb")

						arg_191_1:RecordAudio("411081046", var_194_8)
						arg_191_1:RecordAudio("411081046", var_194_8)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_411081", "411081046", "story_v_out_411081.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_411081", "411081046", "story_v_out_411081.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_9 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_9 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_9

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_9 and arg_191_1.time_ < var_194_1 + var_194_9 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play411081047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411081047
		arg_195_1.duration_ = 9.57

		local var_195_0 = {
			zh = 9.566,
			ja = 5.666
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play411081048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.325

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(411081047)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 53 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 53)

				if (53 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 53)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081047", "story_v_out_411081.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081047", "story_v_out_411081.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_411081", "411081047", "story_v_out_411081.awb")

						arg_195_1:RecordAudio("411081047", var_198_6)
						arg_195_1:RecordAudio("411081047", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_411081", "411081047", "story_v_out_411081.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_411081", "411081047", "story_v_out_411081.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play411081048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411081048
		arg_199_1.duration_ = 11.5

		local var_199_0 = {
			zh = 10.666,
			ja = 11.5
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411081049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.125

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(411081048)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 45 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 45)

				if (45 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 45)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081048", "story_v_out_411081.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081048", "story_v_out_411081.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_411081", "411081048", "story_v_out_411081.awb")

						arg_199_1:RecordAudio("411081048", var_202_6)
						arg_199_1:RecordAudio("411081048", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_411081", "411081048", "story_v_out_411081.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_411081", "411081048", "story_v_out_411081.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play411081049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 411081049
		arg_203_1.duration_ = 6.9

		local var_203_0 = {
			zh = 4.733,
			ja = 6.9
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play411081050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.525

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(411081049)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 21 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 21)

				if (21 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 21)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081049", "story_v_out_411081.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081049", "story_v_out_411081.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_411081", "411081049", "story_v_out_411081.awb")

						arg_203_1:RecordAudio("411081049", var_206_6)
						arg_203_1:RecordAudio("411081049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_411081", "411081049", "story_v_out_411081.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_411081", "411081049", "story_v_out_411081.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play411081050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 411081050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play411081051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.575

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(411081050).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 23 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 23)

				if (23 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 23)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play411081051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 411081051
		arg_211_1.duration_ = 2

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play411081052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1095ui_story = arg_211_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1095ui_story"].transform.position).z)
				arg_211_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1095ui_story"].transform.localEulerAngles = arg_211_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_211_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1095ui_story"].transform.position).z)
				arg_211_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1095ui_story"].transform.localEulerAngles = arg_211_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1095ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1095ui_story == nil then
				arg_211_1.var_.characterEffect1095ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1095ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1095ui_story then
				arg_211_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_4 = 0
			local var_214_5 = 0.05

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(411081051)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 2 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 2)

				if (2 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 2)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081051", "story_v_out_411081.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081051", "story_v_out_411081.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_411081", "411081051", "story_v_out_411081.awb")

						arg_211_1:RecordAudio("411081051", var_214_11)
						arg_211_1:RecordAudio("411081051", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_411081", "411081051", "story_v_out_411081.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_411081", "411081051", "story_v_out_411081.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play411081052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 411081052
		arg_215_1.duration_ = 6.73

		local var_215_0 = {
			zh = 6.5,
			ja = 6.733
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play411081053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				local var_218_0 = arg_215_1.bgs_.B06a

				arg_215_1.bgs_.B06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_1 = var_218_0:GetComponent("SpriteRenderer")

				if var_218_1 and var_218_1.sprite then
					local var_218_2 = 2 * (var_218_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_0.transform.localScale = Vector3.New(var_218_2 / var_218_1.sprite.bounds.size.y < var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x and var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x or var_218_2 / var_218_1.sprite.bounds.size.y, var_218_2 / var_218_1.sprite.bounds.size.y < var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x and var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x or var_218_2 / var_218_1.sprite.bounds.size.y, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "B06a" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_3 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_4 = 2

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_4 then
				local var_218_5 = Color.New(0, 0, 0)

				var_218_5.a = Mathf.Lerp(0, 1, (arg_215_1.time_ - var_218_3) / var_218_4)
				arg_215_1.mask_.color = var_218_5
			end

			if arg_215_1.time_ >= var_218_3 + var_218_4 and arg_215_1.time_ < var_218_3 + var_218_4 + arg_218_0 then
				local var_218_6 = Color.New(0, 0, 0)

				var_218_6.a = 1
				arg_215_1.mask_.color = var_218_6
			end

			local var_218_7 = 2

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_8 = 2

			if var_218_7 <= arg_215_1.time_ and arg_215_1.time_ < var_218_7 + var_218_8 then
				local var_218_9 = Color.New(0, 0, 0)

				var_218_9.a = Mathf.Lerp(1, 0, (arg_215_1.time_ - var_218_7) / var_218_8)
				arg_215_1.mask_.color = var_218_9
			end

			if arg_215_1.time_ >= var_218_7 + var_218_8 and arg_215_1.time_ < var_218_7 + var_218_8 + arg_218_0 then
				local var_218_10 = Color.New(0, 0, 0)

				arg_215_1.mask_.enabled = false
				var_218_10.a = 0
				arg_215_1.mask_.color = var_218_10
			end

			local var_218_11 = arg_215_1.actors_["1095ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1095ui_story = var_218_11.localPosition
			end

			local var_218_12 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_12 then
				var_218_11.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_12)
				var_218_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_11.position).x, (manager.ui.mainCamera.transform.position - var_218_11.position).y, (manager.ui.mainCamera.transform.position - var_218_11.position).z)
				var_218_11.localEulerAngles.z = 0
				var_218_11.localEulerAngles.x = 0
				var_218_11.localEulerAngles = var_218_11.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_12 and arg_215_1.time_ < 0 + var_218_12 + arg_218_0 then
				var_218_11.localPosition = Vector3.New(0, 100, 0)
				var_218_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_11.position).x, (manager.ui.mainCamera.transform.position - var_218_11.position).y, (manager.ui.mainCamera.transform.position - var_218_11.position).z)
				var_218_11.localEulerAngles.z = 0
				var_218_11.localEulerAngles.x = 0
				var_218_11.localEulerAngles = var_218_11.localEulerAngles
			end

			local var_218_13 = arg_215_1.actors_["1095ui_story"].transform

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= 4 + arg_218_0 then
				arg_215_1.var_.moveOldPos1095ui_story = var_218_13.localPosition
			end

			local var_218_14 = 0.001

			if 4 <= arg_215_1.time_ and arg_215_1.time_ < 4 + var_218_14 then
				var_218_13.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_215_1.time_ - 4) / var_218_14)
				var_218_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_13.position).x, (manager.ui.mainCamera.transform.position - var_218_13.position).y, (manager.ui.mainCamera.transform.position - var_218_13.position).z)
				var_218_13.localEulerAngles.z = 0
				var_218_13.localEulerAngles.x = 0
				var_218_13.localEulerAngles = var_218_13.localEulerAngles
			end

			if arg_215_1.time_ >= 4 + var_218_14 and arg_215_1.time_ < 4 + var_218_14 + arg_218_0 then
				var_218_13.localPosition = Vector3.New(0, -0.98, -6.1)
				var_218_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_13.position).x, (manager.ui.mainCamera.transform.position - var_218_13.position).y, (manager.ui.mainCamera.transform.position - var_218_13.position).z)
				var_218_13.localEulerAngles.z = 0
				var_218_13.localEulerAngles.x = 0
				var_218_13.localEulerAngles = var_218_13.localEulerAngles
			end

			local var_218_15 = arg_215_1.actors_["1095ui_story"]

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= 4 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.characterEffect1095ui_story == nil then
				arg_215_1.var_.characterEffect1095ui_story = var_218_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_16 = 0.200000002980232

			if 4 <= arg_215_1.time_ and arg_215_1.time_ < 4 + var_218_16 and not isNil(var_218_15) then
				if arg_215_1.var_.characterEffect1095ui_story and not isNil(var_218_15) then
					arg_215_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 4 + var_218_16 and arg_215_1.time_ < 4 + var_218_16 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.characterEffect1095ui_story then
				arg_215_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_18 = 4
			local var_218_19 = 0.3

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_18 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_20 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_20:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_21 = arg_215_1:GetWordFromCfg(411081052)
				local var_218_22 = arg_215_1:FormatText(var_218_21.content)

				arg_215_1.text_.text = var_218_22

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_24 = 12 <= 0 and var_218_19 or var_218_19 * (utf8.len(var_218_22) / 12)

				if (12 <= 0 and var_218_19 or var_218_19 * (utf8.len(var_218_22) / 12)) > 0 and var_218_19 < var_218_24 then
					arg_215_1.talkMaxDuration = var_218_24
					var_218_18 = var_218_18 + 0.3

					if var_218_24 + var_218_18 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_24 + var_218_18
					end
				end

				arg_215_1.text_.text = var_218_22
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081052", "story_v_out_411081.awb") ~= 0 then
					local var_218_25 = manager.audio:GetVoiceLength("story_v_out_411081", "411081052", "story_v_out_411081.awb") / 1000

					if var_218_25 + var_218_18 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_25 + var_218_18
					end

					if var_218_21.prefab_name ~= "" and arg_215_1.actors_[var_218_21.prefab_name] ~= nil then
						local var_218_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_21.prefab_name].transform, "story_v_out_411081", "411081052", "story_v_out_411081.awb")

						arg_215_1:RecordAudio("411081052", var_218_26)
						arg_215_1:RecordAudio("411081052", var_218_26)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_411081", "411081052", "story_v_out_411081.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_411081", "411081052", "story_v_out_411081.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_27 = var_218_18 + 0.3
			local var_218_28 = math.max(var_218_19, arg_215_1.talkMaxDuration)

			if var_218_18 + 0.3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_27 + var_218_28 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_27) / var_218_28

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_27 + var_218_28 and arg_215_1.time_ < var_218_27 + var_218_28 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play411081053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 411081053
		arg_221_1.duration_ = 5.9

		local var_221_0 = {
			zh = 4.6,
			ja = 5.9
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
				arg_221_0:Play411081054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) and arg_221_1.var_.characterEffect1095ui_story == nil then
				arg_221_1.var_.characterEffect1095ui_story = arg_221_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) then
				if arg_221_1.var_.characterEffect1095ui_story and not isNil(arg_221_1.actors_["1095ui_story"]) then
					arg_221_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1095ui_story"]) and arg_221_1.var_.characterEffect1095ui_story then
				arg_221_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_224_1 = 0
			local var_224_2 = 0.625

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(411081053)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 25 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_4) / 25)

				if (25 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_4) / 25)) > 0 and var_224_2 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081053", "story_v_out_411081.awb") ~= 0 then
					local var_224_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081053", "story_v_out_411081.awb") / 1000

					if var_224_7 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_1
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_411081", "411081053", "story_v_out_411081.awb")

						arg_221_1:RecordAudio("411081053", var_224_8)
						arg_221_1:RecordAudio("411081053", var_224_8)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_411081", "411081053", "story_v_out_411081.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_411081", "411081053", "story_v_out_411081.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_9 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_9 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_9

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_9 and arg_221_1.time_ < var_224_1 + var_224_9 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play411081054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 411081054
		arg_225_1.duration_ = 9.73

		local var_225_0 = {
			zh = 9.733,
			ja = 8.633
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play411081055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.375

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(411081054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 55 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 55)

				if (55 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 55)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081054", "story_v_out_411081.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081054", "story_v_out_411081.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_411081", "411081054", "story_v_out_411081.awb")

						arg_225_1:RecordAudio("411081054", var_228_6)
						arg_225_1:RecordAudio("411081054", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_411081", "411081054", "story_v_out_411081.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_411081", "411081054", "story_v_out_411081.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play411081055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 411081055
		arg_229_1.duration_ = 3.63

		local var_229_0 = {
			zh = 2.1,
			ja = 3.633
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
				arg_229_0:Play411081056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.225

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:GetWordFromCfg(411081055)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 9 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 9)

				if (9 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 9)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081055", "story_v_out_411081.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081055", "story_v_out_411081.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_411081", "411081055", "story_v_out_411081.awb")

						arg_229_1:RecordAudio("411081055", var_232_6)
						arg_229_1:RecordAudio("411081055", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_411081", "411081055", "story_v_out_411081.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_411081", "411081055", "story_v_out_411081.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play411081056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 411081056
		arg_233_1.duration_ = 1.43

		local var_233_0 = {
			zh = 1,
			ja = 1.433
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
				arg_233_0:Play411081057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1095ui_story"]) and arg_233_1.var_.characterEffect1095ui_story == nil then
				arg_233_1.var_.characterEffect1095ui_story = arg_233_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1095ui_story"]) then
				if arg_233_1.var_.characterEffect1095ui_story and not isNil(arg_233_1.actors_["1095ui_story"]) then
					arg_233_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1095ui_story"]) and arg_233_1.var_.characterEffect1095ui_story then
				arg_233_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_236_2 = 0
			local var_236_3 = 0.075

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(411081056)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 3 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 3)

				if (3 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 3)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081056", "story_v_out_411081.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081056", "story_v_out_411081.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_411081", "411081056", "story_v_out_411081.awb")

						arg_233_1:RecordAudio("411081056", var_236_9)
						arg_233_1:RecordAudio("411081056", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_411081", "411081056", "story_v_out_411081.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_411081", "411081056", "story_v_out_411081.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play411081057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 411081057
		arg_237_1.duration_ = 3.2

		local var_237_0 = {
			zh = 3.2,
			ja = 2.9
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
				arg_237_0:Play411081058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1095ui_story"]) and arg_237_1.var_.characterEffect1095ui_story == nil then
				arg_237_1.var_.characterEffect1095ui_story = arg_237_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1095ui_story"]) then
				if arg_237_1.var_.characterEffect1095ui_story and not isNil(arg_237_1.actors_["1095ui_story"]) then
					arg_237_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1095ui_story"]) and arg_237_1.var_.characterEffect1095ui_story then
				arg_237_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.425

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(411081057)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 17 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_4) / 17)

				if (17 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_4) / 17)) > 0 and var_240_2 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081057", "story_v_out_411081.awb") ~= 0 then
					local var_240_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081057", "story_v_out_411081.awb") / 1000

					if var_240_7 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_1
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_411081", "411081057", "story_v_out_411081.awb")

						arg_237_1:RecordAudio("411081057", var_240_8)
						arg_237_1:RecordAudio("411081057", var_240_8)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_411081", "411081057", "story_v_out_411081.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_411081", "411081057", "story_v_out_411081.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_9 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_9 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_9

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_9 and arg_237_1.time_ < var_240_1 + var_240_9 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play411081058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 411081058
		arg_241_1.duration_ = 6.4

		local var_241_0 = {
			zh = 6.4,
			ja = 5.466
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
				arg_241_0:Play411081059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1095ui_story"]) and arg_241_1.var_.characterEffect1095ui_story == nil then
				arg_241_1.var_.characterEffect1095ui_story = arg_241_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1095ui_story"]) then
				if arg_241_1.var_.characterEffect1095ui_story and not isNil(arg_241_1.actors_["1095ui_story"]) then
					arg_241_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1095ui_story"]) and arg_241_1.var_.characterEffect1095ui_story then
				arg_241_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_244_2 = 0
			local var_244_3 = 0.725

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(411081058)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 29 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 29)

				if (29 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 29)) > 0 and var_244_3 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081058", "story_v_out_411081.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081058", "story_v_out_411081.awb") / 1000

					if var_244_8 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_2
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_out_411081", "411081058", "story_v_out_411081.awb")

						arg_241_1:RecordAudio("411081058", var_244_9)
						arg_241_1:RecordAudio("411081058", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_411081", "411081058", "story_v_out_411081.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_411081", "411081058", "story_v_out_411081.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_3, arg_241_1.talkMaxDuration)

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_2) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_2 + var_244_10 and arg_241_1.time_ < var_244_2 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play411081059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 411081059
		arg_245_1.duration_ = 1.7

		local var_245_0 = {
			zh = 1.3,
			ja = 1.7
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
				arg_245_0:Play411081060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.125

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(411081059)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 5 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 5)

				if (5 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 5)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081059", "story_v_out_411081.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081059", "story_v_out_411081.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_411081", "411081059", "story_v_out_411081.awb")

						arg_245_1:RecordAudio("411081059", var_248_6)
						arg_245_1:RecordAudio("411081059", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_411081", "411081059", "story_v_out_411081.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_411081", "411081059", "story_v_out_411081.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play411081060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 411081060
		arg_249_1.duration_ = 1.5

		local var_249_0 = {
			zh = 0.999999999999,
			ja = 1.5
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
				arg_249_0:Play411081061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1095ui_story = arg_249_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).z)
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles = arg_249_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_249_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1095ui_story"].transform.position).z)
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1095ui_story"].transform.localEulerAngles = arg_249_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1095ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1095ui_story == nil then
				arg_249_1.var_.characterEffect1095ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1095ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1095ui_story then
				arg_249_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.1

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(411081060)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 4 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 4)

				if (4 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 4)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081060", "story_v_out_411081.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081060", "story_v_out_411081.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_411081", "411081060", "story_v_out_411081.awb")

						arg_249_1:RecordAudio("411081060", var_252_11)
						arg_249_1:RecordAudio("411081060", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_411081", "411081060", "story_v_out_411081.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_411081", "411081060", "story_v_out_411081.awb")
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

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play411081061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 411081061
		arg_253_1.duration_ = 4.2

		local var_253_0 = {
			zh = 3.2,
			ja = 4.2
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play411081062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1095ui_story"]) and arg_253_1.var_.characterEffect1095ui_story == nil then
				arg_253_1.var_.characterEffect1095ui_story = arg_253_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1095ui_story"]) then
				if arg_253_1.var_.characterEffect1095ui_story and not isNil(arg_253_1.actors_["1095ui_story"]) then
					arg_253_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1095ui_story"]) and arg_253_1.var_.characterEffect1095ui_story then
				arg_253_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.275

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2021")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(411081061)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_6 = 11 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_4) / 11)

				if (11 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_4) / 11)) > 0 and var_256_2 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081061", "story_v_out_411081.awb") ~= 0 then
					local var_256_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081061", "story_v_out_411081.awb") / 1000

					if var_256_7 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_1
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_411081", "411081061", "story_v_out_411081.awb")

						arg_253_1:RecordAudio("411081061", var_256_8)
						arg_253_1:RecordAudio("411081061", var_256_8)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_411081", "411081061", "story_v_out_411081.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_411081", "411081061", "story_v_out_411081.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_9 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_9 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_9

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_9 and arg_253_1.time_ < var_256_1 + var_256_9 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play411081062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 411081062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play411081063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.025

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(411081062).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 41 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 41)

				if (41 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 41)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play411081063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 411081063
		arg_261_1.duration_ = 3.3

		local var_261_0 = {
			zh = 1.4,
			ja = 3.3
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
				arg_261_0:Play411081064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1095ui_story"]) and arg_261_1.var_.characterEffect1095ui_story == nil then
				arg_261_1.var_.characterEffect1095ui_story = arg_261_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1095ui_story"]) then
				if arg_261_1.var_.characterEffect1095ui_story and not isNil(arg_261_1.actors_["1095ui_story"]) then
					arg_261_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1095ui_story"]) and arg_261_1.var_.characterEffect1095ui_story then
				arg_261_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_264_2 = 0
			local var_264_3 = 0.175

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_4 = arg_261_1:GetWordFromCfg(411081063)
				local var_264_5 = arg_261_1:FormatText(var_264_4.content)

				arg_261_1.text_.text = var_264_5

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 7 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 7)

				if (7 <= 0 and var_264_3 or var_264_3 * (utf8.len(var_264_5) / 7)) > 0 and var_264_3 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_2
					end
				end

				arg_261_1.text_.text = var_264_5
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081063", "story_v_out_411081.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081063", "story_v_out_411081.awb") / 1000

					if var_264_8 + var_264_2 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_2
					end

					if var_264_4.prefab_name ~= "" and arg_261_1.actors_[var_264_4.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_4.prefab_name].transform, "story_v_out_411081", "411081063", "story_v_out_411081.awb")

						arg_261_1:RecordAudio("411081063", var_264_9)
						arg_261_1:RecordAudio("411081063", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_411081", "411081063", "story_v_out_411081.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_411081", "411081063", "story_v_out_411081.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_3, arg_261_1.talkMaxDuration)

			if var_264_2 <= arg_261_1.time_ and arg_261_1.time_ < var_264_2 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_2) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_2 + var_264_10 and arg_261_1.time_ < var_264_2 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play411081064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 411081064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play411081065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1095ui_story"]) and arg_265_1.var_.characterEffect1095ui_story == nil then
				arg_265_1.var_.characterEffect1095ui_story = arg_265_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1095ui_story"]) then
				if arg_265_1.var_.characterEffect1095ui_story and not isNil(arg_265_1.actors_["1095ui_story"]) then
					arg_265_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1095ui_story"]) and arg_265_1.var_.characterEffect1095ui_story then
				arg_265_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_268_1 = 0
			local var_268_2 = 1.025

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(411081064).content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 41 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 41)

				if (41 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 41)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_6 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_6 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_6

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_6 and arg_265_1.time_ < var_268_1 + var_268_6 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play411081065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 411081065
		arg_269_1.duration_ = 4.1

		local var_269_0 = {
			zh = 1.999999999999,
			ja = 4.1
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
				arg_269_0:Play411081066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_272_0 = arg_269_1.actors_["1095ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1095ui_story == nil then
				arg_269_1.var_.characterEffect1095ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_1 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 and not isNil(var_272_0) then
				if arg_269_1.var_.characterEffect1095ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1095ui_story then
				arg_269_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_272_3 = 0
			local var_272_4 = 0.2

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_3 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_5 = arg_269_1:GetWordFromCfg(411081065)
				local var_272_6 = arg_269_1:FormatText(var_272_5.content)

				arg_269_1.text_.text = var_272_6

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_8 = 8 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_6) / 8)

				if (8 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_6) / 8)) > 0 and var_272_4 < var_272_8 then
					arg_269_1.talkMaxDuration = var_272_8

					if var_272_8 + var_272_3 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_3
					end
				end

				arg_269_1.text_.text = var_272_6
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081065", "story_v_out_411081.awb") ~= 0 then
					local var_272_9 = manager.audio:GetVoiceLength("story_v_out_411081", "411081065", "story_v_out_411081.awb") / 1000

					if var_272_9 + var_272_3 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_3
					end

					if var_272_5.prefab_name ~= "" and arg_269_1.actors_[var_272_5.prefab_name] ~= nil then
						local var_272_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_5.prefab_name].transform, "story_v_out_411081", "411081065", "story_v_out_411081.awb")

						arg_269_1:RecordAudio("411081065", var_272_10)
						arg_269_1:RecordAudio("411081065", var_272_10)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_411081", "411081065", "story_v_out_411081.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_411081", "411081065", "story_v_out_411081.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_11 = math.max(var_272_4, arg_269_1.talkMaxDuration)

			if var_272_3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_3 + var_272_11 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_3) / var_272_11

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_3 + var_272_11 and arg_269_1.time_ < var_272_3 + var_272_11 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play411081066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 411081066
		arg_273_1.duration_ = 6.83

		local var_273_0 = {
			zh = 3.6,
			ja = 6.833
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
				arg_273_0:Play411081067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.4

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(411081066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 16 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 16)

				if (16 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 16)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081066", "story_v_out_411081.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081066", "story_v_out_411081.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_411081", "411081066", "story_v_out_411081.awb")

						arg_273_1:RecordAudio("411081066", var_276_6)
						arg_273_1:RecordAudio("411081066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_411081", "411081066", "story_v_out_411081.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_411081", "411081066", "story_v_out_411081.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play411081067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 411081067
		arg_277_1.duration_ = 8.77

		local var_277_0 = {
			zh = 6.5,
			ja = 8.766
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
				arg_277_0:Play411081068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.6

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(411081067)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 24 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 24)

				if (24 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 24)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081067", "story_v_out_411081.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081067", "story_v_out_411081.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_411081", "411081067", "story_v_out_411081.awb")

						arg_277_1:RecordAudio("411081067", var_280_6)
						arg_277_1:RecordAudio("411081067", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_411081", "411081067", "story_v_out_411081.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_411081", "411081067", "story_v_out_411081.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play411081068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 411081068
		arg_281_1.duration_ = 4.63

		local var_281_0 = {
			zh = 4.633,
			ja = 4.366
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
				arg_281_0:Play411081069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_284_0 = 0
			local var_284_1 = 0.475

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(411081068)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 19 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 19)

				if (19 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 19)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081068", "story_v_out_411081.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_out_411081", "411081068", "story_v_out_411081.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_out_411081", "411081068", "story_v_out_411081.awb")

						arg_281_1:RecordAudio("411081068", var_284_7)
						arg_281_1:RecordAudio("411081068", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_411081", "411081068", "story_v_out_411081.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_411081", "411081068", "story_v_out_411081.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play411081069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 411081069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play411081070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1095ui_story = arg_285_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1095ui_story"].transform.position).z)
				arg_285_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1095ui_story"].transform.localEulerAngles = arg_285_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1095ui_story"].transform.position).z)
				arg_285_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1095ui_story"].transform.localEulerAngles = arg_285_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_288_1 = 0
			local var_288_2 = 0.875

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(411081069).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 35 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 35)

				if (35 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 35)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play411081070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 411081070
		arg_289_1.duration_ = 3.53

		local var_289_0 = {
			zh = 2.9,
			ja = 3.533
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
				arg_289_0:Play411081071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1095ui_story = arg_289_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1095ui_story"].transform.position).z)
				arg_289_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1095ui_story"].transform.localEulerAngles = arg_289_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_289_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1095ui_story"].transform.position).z)
				arg_289_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1095ui_story"].transform.localEulerAngles = arg_289_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1095ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1095ui_story == nil then
				arg_289_1.var_.characterEffect1095ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1095ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1095ui_story then
				arg_289_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_292_4 = 0
			local var_292_5 = 0.3

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(411081070)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 12 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 12)

				if (12 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 12)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081070", "story_v_out_411081.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081070", "story_v_out_411081.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_411081", "411081070", "story_v_out_411081.awb")

						arg_289_1:RecordAudio("411081070", var_292_11)
						arg_289_1:RecordAudio("411081070", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_411081", "411081070", "story_v_out_411081.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_411081", "411081070", "story_v_out_411081.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411081071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 411081071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play411081072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1095ui_story"]) and arg_293_1.var_.characterEffect1095ui_story == nil then
				arg_293_1.var_.characterEffect1095ui_story = arg_293_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1095ui_story"]) then
				if arg_293_1.var_.characterEffect1095ui_story and not isNil(arg_293_1.actors_["1095ui_story"]) then
					arg_293_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1095ui_story"]) and arg_293_1.var_.characterEffect1095ui_story then
				arg_293_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_296_1 = arg_293_1.actors_["1095ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1095ui_story = var_296_1.localPosition
			end

			local var_296_2 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 then
				var_296_1.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_2)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 then
				var_296_1.localPosition = Vector3.New(0, 100, 0)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			local var_296_3 = 0
			local var_296_4 = 1.175

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_5 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(411081071).content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 47 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_5) / 47)

				if (47 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_5) / 47)) > 0 and var_296_4 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_3 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_3
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_4, arg_293_1.talkMaxDuration)

			if var_296_3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_3 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_3) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_3 + var_296_8 and arg_293_1.time_ < var_296_3 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play411081072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 411081072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play411081073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.85

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(411081072).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 34 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 34)

				if (34 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 34)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play411081073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 411081073
		arg_301_1.duration_ = 2.6

		local var_301_0 = {
			zh = 1.633,
			ja = 2.6
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
				arg_301_0:Play411081074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1095ui_story"]) and arg_301_1.var_.characterEffect1095ui_story == nil then
				arg_301_1.var_.characterEffect1095ui_story = arg_301_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1095ui_story"]) then
				if arg_301_1.var_.characterEffect1095ui_story and not isNil(arg_301_1.actors_["1095ui_story"]) then
					arg_301_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1095ui_story"]) and arg_301_1.var_.characterEffect1095ui_story then
				arg_301_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_304_2 = arg_301_1.actors_["1095ui_story"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1095ui_story = var_304_2.localPosition
			end

			local var_304_3 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 then
				var_304_2.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_301_1.time_ - 0) / var_304_3)
				var_304_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_2.position).x, (manager.ui.mainCamera.transform.position - var_304_2.position).y, (manager.ui.mainCamera.transform.position - var_304_2.position).z)
				var_304_2.localEulerAngles.z = 0
				var_304_2.localEulerAngles.x = 0
				var_304_2.localEulerAngles = var_304_2.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 then
				var_304_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_304_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_2.position).x, (manager.ui.mainCamera.transform.position - var_304_2.position).y, (manager.ui.mainCamera.transform.position - var_304_2.position).z)
				var_304_2.localEulerAngles.z = 0
				var_304_2.localEulerAngles.x = 0
				var_304_2.localEulerAngles = var_304_2.localEulerAngles
			end

			local var_304_4 = 0
			local var_304_5 = 0.2

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(411081073)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 8 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 8)

				if (8 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 8)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081073", "story_v_out_411081.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081073", "story_v_out_411081.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_out_411081", "411081073", "story_v_out_411081.awb")

						arg_301_1:RecordAudio("411081073", var_304_11)
						arg_301_1:RecordAudio("411081073", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_411081", "411081073", "story_v_out_411081.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_411081", "411081073", "story_v_out_411081.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play411081074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 411081074
		arg_305_1.duration_ = 10.13

		local var_305_0 = {
			zh = 9.866,
			ja = 10.133
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
				arg_305_0:Play411081075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if arg_305_1.bgs_.B08d == nil then
				local var_308_0 = Object.Instantiate(arg_305_1.paintGo_)

				var_308_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B08d")
				var_308_0.name = "B08d"
				var_308_0.transform.parent = arg_305_1.stage_.transform
				var_308_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.bgs_.B08d = var_308_0
			end

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				local var_308_1 = arg_305_1.bgs_.B08d

				arg_305_1.bgs_.B08d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_308_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_2 = var_308_1:GetComponent("SpriteRenderer")

				if var_308_2 and var_308_2.sprite then
					local var_308_3 = 2 * (var_308_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_308_1.transform.localScale = Vector3.New(var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "B08d" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_4 = 0

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_5 = 2

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_5 then
				local var_308_6 = Color.New(0, 0, 0)

				var_308_6.a = Mathf.Lerp(0, 1, (arg_305_1.time_ - var_308_4) / var_308_5)
				arg_305_1.mask_.color = var_308_6
			end

			if arg_305_1.time_ >= var_308_4 + var_308_5 and arg_305_1.time_ < var_308_4 + var_308_5 + arg_308_0 then
				local var_308_7 = Color.New(0, 0, 0)

				var_308_7.a = 1
				arg_305_1.mask_.color = var_308_7
			end

			local var_308_8 = 2

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_9 = 2

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_9 then
				local var_308_10 = Color.New(0, 0, 0)

				var_308_10.a = Mathf.Lerp(1, 0, (arg_305_1.time_ - var_308_8) / var_308_9)
				arg_305_1.mask_.color = var_308_10
			end

			if arg_305_1.time_ >= var_308_8 + var_308_9 and arg_305_1.time_ < var_308_8 + var_308_9 + arg_308_0 then
				local var_308_11 = Color.New(0, 0, 0)

				arg_305_1.mask_.enabled = false
				var_308_11.a = 0
				arg_305_1.mask_.color = var_308_11
			end

			local var_308_12 = "10014ui_story"

			if arg_305_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_308_13 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_305_1.stage_.transform)

				var_308_13.name = var_308_12
				var_308_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.actors_[var_308_12] = var_308_13

				local var_308_14 = var_308_13:GetComponentInChildren(typeof(CharacterEffect))

				var_308_14.enabled = true

				local var_308_15 = GameObjectTools.GetOrAddComponent(var_308_13, typeof(DynamicBoneHelper))

				if var_308_15 then
					var_308_15:EnableDynamicBone(false)
				end

				arg_305_1:ShowWeapon(var_308_14.transform, false)

				arg_305_1.var_[var_308_12 .. "Animator"] = var_308_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_305_1.var_[var_308_12 .. "Animator"].applyRootMotion = true
				arg_305_1.var_[var_308_12 .. "LipSync"] = var_308_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_308_16 = arg_305_1.actors_["10014ui_story"].transform

			if 4 < arg_305_1.time_ and arg_305_1.time_ <= 4 + arg_308_0 then
				arg_305_1.var_.moveOldPos10014ui_story = var_308_16.localPosition
			end

			local var_308_17 = 0.001

			if 4 <= arg_305_1.time_ and arg_305_1.time_ < 4 + var_308_17 then
				var_308_16.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_305_1.time_ - 4) / var_308_17)
				var_308_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_16.position).x, (manager.ui.mainCamera.transform.position - var_308_16.position).y, (manager.ui.mainCamera.transform.position - var_308_16.position).z)
				var_308_16.localEulerAngles.z = 0
				var_308_16.localEulerAngles.x = 0
				var_308_16.localEulerAngles = var_308_16.localEulerAngles
			end

			if arg_305_1.time_ >= 4 + var_308_17 and arg_305_1.time_ < 4 + var_308_17 + arg_308_0 then
				var_308_16.localPosition = Vector3.New(0, -1.06, -6.2)
				var_308_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_16.position).x, (manager.ui.mainCamera.transform.position - var_308_16.position).y, (manager.ui.mainCamera.transform.position - var_308_16.position).z)
				var_308_16.localEulerAngles.z = 0
				var_308_16.localEulerAngles.x = 0
				var_308_16.localEulerAngles = var_308_16.localEulerAngles
			end

			local var_308_18 = arg_305_1.actors_["10014ui_story"]

			if 4 < arg_305_1.time_ and arg_305_1.time_ <= 4 + arg_308_0 and not isNil(var_308_18) and arg_305_1.var_.characterEffect10014ui_story == nil then
				arg_305_1.var_.characterEffect10014ui_story = var_308_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_19 = 0.200000002980232

			if 4 <= arg_305_1.time_ and arg_305_1.time_ < 4 + var_308_19 and not isNil(var_308_18) then
				if arg_305_1.var_.characterEffect10014ui_story and not isNil(var_308_18) then
					arg_305_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 4 + var_308_19 and arg_305_1.time_ < 4 + var_308_19 + arg_308_0 and not isNil(var_308_18) and arg_305_1.var_.characterEffect10014ui_story then
				arg_305_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 4 < arg_305_1.time_ and arg_305_1.time_ <= 4 + arg_308_0 then
				arg_305_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 4 < arg_305_1.time_ and arg_305_1.time_ <= 4 + arg_308_0 then
				arg_305_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_308_21 = arg_305_1.actors_["1095ui_story"].transform

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				arg_305_1.var_.moveOldPos1095ui_story = var_308_21.localPosition
			end

			local var_308_22 = 0.001

			if 2 <= arg_305_1.time_ and arg_305_1.time_ < 2 + var_308_22 then
				var_308_21.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 2) / var_308_22)
				var_308_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_21.position).x, (manager.ui.mainCamera.transform.position - var_308_21.position).y, (manager.ui.mainCamera.transform.position - var_308_21.position).z)
				var_308_21.localEulerAngles.z = 0
				var_308_21.localEulerAngles.x = 0
				var_308_21.localEulerAngles = var_308_21.localEulerAngles
			end

			if arg_305_1.time_ >= 2 + var_308_22 and arg_305_1.time_ < 2 + var_308_22 + arg_308_0 then
				var_308_21.localPosition = Vector3.New(0, 100, 0)
				var_308_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_21.position).x, (manager.ui.mainCamera.transform.position - var_308_21.position).y, (manager.ui.mainCamera.transform.position - var_308_21.position).z)
				var_308_21.localEulerAngles.z = 0
				var_308_21.localEulerAngles.x = 0
				var_308_21.localEulerAngles = var_308_21.localEulerAngles
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_23 = 4
			local var_308_24 = 0.5

			if 4 < arg_305_1.time_ and arg_305_1.time_ <= var_308_23 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_25 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_25:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_26 = arg_305_1:GetWordFromCfg(411081074)
				local var_308_27 = arg_305_1:FormatText(var_308_26.content)

				arg_305_1.text_.text = var_308_27

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_29 = 20 <= 0 and var_308_24 or var_308_24 * (utf8.len(var_308_27) / 20)

				if (20 <= 0 and var_308_24 or var_308_24 * (utf8.len(var_308_27) / 20)) > 0 and var_308_24 < var_308_29 then
					arg_305_1.talkMaxDuration = var_308_29
					var_308_23 = var_308_23 + 0.3

					if var_308_29 + var_308_23 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_29 + var_308_23
					end
				end

				arg_305_1.text_.text = var_308_27
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081074", "story_v_out_411081.awb") ~= 0 then
					local var_308_30 = manager.audio:GetVoiceLength("story_v_out_411081", "411081074", "story_v_out_411081.awb") / 1000

					if var_308_30 + var_308_23 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_30 + var_308_23
					end

					if var_308_26.prefab_name ~= "" and arg_305_1.actors_[var_308_26.prefab_name] ~= nil then
						local var_308_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_26.prefab_name].transform, "story_v_out_411081", "411081074", "story_v_out_411081.awb")

						arg_305_1:RecordAudio("411081074", var_308_31)
						arg_305_1:RecordAudio("411081074", var_308_31)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_411081", "411081074", "story_v_out_411081.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_411081", "411081074", "story_v_out_411081.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_32 = var_308_23 + 0.3
			local var_308_33 = math.max(var_308_24, arg_305_1.talkMaxDuration)

			if var_308_23 + 0.3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_32 + var_308_33 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_32) / var_308_33

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_32 + var_308_33 and arg_305_1.time_ < var_308_32 + var_308_33 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play411081075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 411081075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play411081076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["10014ui_story"]) and arg_311_1.var_.characterEffect10014ui_story == nil then
				arg_311_1.var_.characterEffect10014ui_story = arg_311_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["10014ui_story"]) then
				if arg_311_1.var_.characterEffect10014ui_story and not isNil(arg_311_1.actors_["10014ui_story"]) then
					arg_311_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_311_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["10014ui_story"]) and arg_311_1.var_.characterEffect10014ui_story then
				arg_311_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_311_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 1.05

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(411081075).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 42 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 42)

				if (42 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 42)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play411081076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 411081076
		arg_315_1.duration_ = 6.37

		local var_315_0 = {
			zh = 6.366,
			ja = 5.333
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play411081077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.55

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:GetWordFromCfg(411081076)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 22 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 22)

				if (22 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 22)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081076", "story_v_out_411081.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081076", "story_v_out_411081.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_411081", "411081076", "story_v_out_411081.awb")

						arg_315_1:RecordAudio("411081076", var_318_6)
						arg_315_1:RecordAudio("411081076", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_411081", "411081076", "story_v_out_411081.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_411081", "411081076", "story_v_out_411081.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play411081077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 411081077
		arg_319_1.duration_ = 5.63

		local var_319_0 = {
			zh = 5.633,
			ja = 3.5
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play411081078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos10014ui_story = arg_319_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["10014ui_story"].transform.position).z)
				arg_319_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["10014ui_story"].transform.localEulerAngles = arg_319_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_319_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["10014ui_story"].transform.position).z)
				arg_319_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["10014ui_story"].transform.localEulerAngles = arg_319_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["10014ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect10014ui_story == nil then
				arg_319_1.var_.characterEffect10014ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect10014ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect10014ui_story then
				arg_319_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_4 = 0
			local var_322_5 = 0.725

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(411081077)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 29 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 29)

				if (29 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 29)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081077", "story_v_out_411081.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081077", "story_v_out_411081.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_out_411081", "411081077", "story_v_out_411081.awb")

						arg_319_1:RecordAudio("411081077", var_322_11)
						arg_319_1:RecordAudio("411081077", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_411081", "411081077", "story_v_out_411081.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_411081", "411081077", "story_v_out_411081.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play411081078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 411081078
		arg_323_1.duration_ = 6.13

		local var_323_0 = {
			zh = 5.633,
			ja = 6.133
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play411081079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["10014ui_story"]) and arg_323_1.var_.characterEffect10014ui_story == nil then
				arg_323_1.var_.characterEffect10014ui_story = arg_323_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["10014ui_story"]) then
				if arg_323_1.var_.characterEffect10014ui_story and not isNil(arg_323_1.actors_["10014ui_story"]) then
					arg_323_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["10014ui_story"]) and arg_323_1.var_.characterEffect10014ui_story then
				arg_323_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_326_1 = 0
			local var_326_2 = 0.5

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_3 = arg_323_1:GetWordFromCfg(411081078)
				local var_326_4 = arg_323_1:FormatText(var_326_3.content)

				arg_323_1.text_.text = var_326_4

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_6 = 20 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_4) / 20)

				if (20 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_4) / 20)) > 0 and var_326_2 < var_326_6 then
					arg_323_1.talkMaxDuration = var_326_6

					if var_326_6 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_6 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_4
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081078", "story_v_out_411081.awb") ~= 0 then
					local var_326_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081078", "story_v_out_411081.awb") / 1000

					if var_326_7 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_1
					end

					if var_326_3.prefab_name ~= "" and arg_323_1.actors_[var_326_3.prefab_name] ~= nil then
						local var_326_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_3.prefab_name].transform, "story_v_out_411081", "411081078", "story_v_out_411081.awb")

						arg_323_1:RecordAudio("411081078", var_326_8)
						arg_323_1:RecordAudio("411081078", var_326_8)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_411081", "411081078", "story_v_out_411081.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_411081", "411081078", "story_v_out_411081.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_9 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_9 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_9

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_9 and arg_323_1.time_ < var_326_1 + var_326_9 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play411081079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 411081079
		arg_327_1.duration_ = 9.87

		local var_327_0 = {
			zh = 7.833,
			ja = 9.866
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play411081080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.9

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_1 = arg_327_1:GetWordFromCfg(411081079)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 36 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 36)

				if (36 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 36)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081079", "story_v_out_411081.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081079", "story_v_out_411081.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_411081", "411081079", "story_v_out_411081.awb")

						arg_327_1:RecordAudio("411081079", var_330_6)
						arg_327_1:RecordAudio("411081079", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_411081", "411081079", "story_v_out_411081.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_411081", "411081079", "story_v_out_411081.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play411081080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 411081080
		arg_331_1.duration_ = 5.37

		local var_331_0 = {
			zh = 3.666,
			ja = 5.366
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play411081081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10014ui_story"]) and arg_331_1.var_.characterEffect10014ui_story == nil then
				arg_331_1.var_.characterEffect10014ui_story = arg_331_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["10014ui_story"]) then
				if arg_331_1.var_.characterEffect10014ui_story and not isNil(arg_331_1.actors_["10014ui_story"]) then
					arg_331_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["10014ui_story"]) and arg_331_1.var_.characterEffect10014ui_story then
				arg_331_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_334_2 = 0
			local var_334_3 = 0.45

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_2 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_4 = arg_331_1:GetWordFromCfg(411081080)
				local var_334_5 = arg_331_1:FormatText(var_334_4.content)

				arg_331_1.text_.text = var_334_5

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_7 = 18 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 18)

				if (18 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 18)) > 0 and var_334_3 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_2
					end
				end

				arg_331_1.text_.text = var_334_5
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081080", "story_v_out_411081.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081080", "story_v_out_411081.awb") / 1000

					if var_334_8 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_2
					end

					if var_334_4.prefab_name ~= "" and arg_331_1.actors_[var_334_4.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_4.prefab_name].transform, "story_v_out_411081", "411081080", "story_v_out_411081.awb")

						arg_331_1:RecordAudio("411081080", var_334_9)
						arg_331_1:RecordAudio("411081080", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_411081", "411081080", "story_v_out_411081.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_411081", "411081080", "story_v_out_411081.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_3, arg_331_1.talkMaxDuration)

			if var_334_2 <= arg_331_1.time_ and arg_331_1.time_ < var_334_2 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_2) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_2 + var_334_10 and arg_331_1.time_ < var_334_2 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play411081081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 411081081
		arg_335_1.duration_ = 9.77

		local var_335_0 = {
			zh = 9.6,
			ja = 9.766
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
				arg_335_0:Play411081082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["10014ui_story"]) and arg_335_1.var_.characterEffect10014ui_story == nil then
				arg_335_1.var_.characterEffect10014ui_story = arg_335_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["10014ui_story"]) then
				if arg_335_1.var_.characterEffect10014ui_story and not isNil(arg_335_1.actors_["10014ui_story"]) then
					arg_335_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["10014ui_story"]) and arg_335_1.var_.characterEffect10014ui_story then
				arg_335_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_338_2 = 0
			local var_338_3 = 1.125

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_2 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_4 = arg_335_1:GetWordFromCfg(411081081)
				local var_338_5 = arg_335_1:FormatText(var_338_4.content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 45 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 45)

				if (45 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 45)) > 0 and var_338_3 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_2
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081081", "story_v_out_411081.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081081", "story_v_out_411081.awb") / 1000

					if var_338_8 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_2
					end

					if var_338_4.prefab_name ~= "" and arg_335_1.actors_[var_338_4.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_4.prefab_name].transform, "story_v_out_411081", "411081081", "story_v_out_411081.awb")

						arg_335_1:RecordAudio("411081081", var_338_9)
						arg_335_1:RecordAudio("411081081", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_411081", "411081081", "story_v_out_411081.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_411081", "411081081", "story_v_out_411081.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_3, arg_335_1.talkMaxDuration)

			if var_338_2 <= arg_335_1.time_ and arg_335_1.time_ < var_338_2 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_2) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_2 + var_338_10 and arg_335_1.time_ < var_338_2 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play411081082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 411081082
		arg_339_1.duration_ = 5.07

		local var_339_0 = {
			zh = 4.066,
			ja = 5.066
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
				arg_339_0:Play411081083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10014ui_story = arg_339_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10014ui_story"].transform.position).z)
				arg_339_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["10014ui_story"].transform.localEulerAngles = arg_339_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_339_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10014ui_story"].transform.position).z)
				arg_339_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["10014ui_story"].transform.localEulerAngles = arg_339_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["10014ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect10014ui_story == nil then
				arg_339_1.var_.characterEffect10014ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect10014ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect10014ui_story then
				arg_339_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_2")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_342_4 = 0
			local var_342_5 = 0.425

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(411081082)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 17 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 17)

				if (17 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 17)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081082", "story_v_out_411081.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081082", "story_v_out_411081.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_411081", "411081082", "story_v_out_411081.awb")

						arg_339_1:RecordAudio("411081082", var_342_11)
						arg_339_1:RecordAudio("411081082", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_411081", "411081082", "story_v_out_411081.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_411081", "411081082", "story_v_out_411081.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play411081083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 411081083
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play411081084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["10014ui_story"]) and arg_343_1.var_.characterEffect10014ui_story == nil then
				arg_343_1.var_.characterEffect10014ui_story = arg_343_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["10014ui_story"]) then
				if arg_343_1.var_.characterEffect10014ui_story and not isNil(arg_343_1.actors_["10014ui_story"]) then
					arg_343_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_343_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["10014ui_story"]) and arg_343_1.var_.characterEffect10014ui_story then
				arg_343_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_343_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.825

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(411081083).content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 33 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 33)

				if (33 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 33)) > 0 and var_346_2 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_6 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_6 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_6

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_6 and arg_343_1.time_ < var_346_1 + var_346_6 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play411081084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 411081084
		arg_347_1.duration_ = 2.87

		local var_347_0 = {
			zh = 1.6,
			ja = 2.866
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
				arg_347_0:Play411081085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.15

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:GetWordFromCfg(411081084)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 6 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 6)

				if (6 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 6)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081084", "story_v_out_411081.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081084", "story_v_out_411081.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_411081", "411081084", "story_v_out_411081.awb")

						arg_347_1:RecordAudio("411081084", var_350_6)
						arg_347_1:RecordAudio("411081084", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_411081", "411081084", "story_v_out_411081.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_411081", "411081084", "story_v_out_411081.awb")
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
	Play411081085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 411081085
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play411081086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.8

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(411081085).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 32 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 32)

				if (32 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 32)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play411081086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 411081086
		arg_355_1.duration_ = 14.2

		local var_355_0 = {
			zh = 11.6,
			ja = 14.2
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play411081087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.25

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:GetWordFromCfg(411081086)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 50 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 50)

				if (50 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 50)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081086", "story_v_out_411081.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081086", "story_v_out_411081.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_411081", "411081086", "story_v_out_411081.awb")

						arg_355_1:RecordAudio("411081086", var_358_6)
						arg_355_1:RecordAudio("411081086", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_411081", "411081086", "story_v_out_411081.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_411081", "411081086", "story_v_out_411081.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play411081087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 411081087
		arg_359_1.duration_ = 10.7

		local var_359_0 = {
			zh = 9.166,
			ja = 10.7
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
				arg_359_0:Play411081088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.95

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:GetWordFromCfg(411081087)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 38 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 38)

				if (38 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 38)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081087", "story_v_out_411081.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081087", "story_v_out_411081.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_411081", "411081087", "story_v_out_411081.awb")

						arg_359_1:RecordAudio("411081087", var_362_6)
						arg_359_1:RecordAudio("411081087", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_411081", "411081087", "story_v_out_411081.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_411081", "411081087", "story_v_out_411081.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play411081088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 411081088
		arg_363_1.duration_ = 7.1

		local var_363_0 = {
			zh = 7.1,
			ja = 5.566
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
				arg_363_0:Play411081089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos10014ui_story = arg_363_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10014ui_story"].transform.position).z)
				arg_363_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["10014ui_story"].transform.localEulerAngles = arg_363_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_363_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10014ui_story"].transform.position).z)
				arg_363_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["10014ui_story"].transform.localEulerAngles = arg_363_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["10014ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect10014ui_story == nil then
				arg_363_1.var_.characterEffect10014ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect10014ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect10014ui_story then
				arg_363_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_366_4 = 0
			local var_366_5 = 0.55

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(411081088)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 22 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 22)

				if (22 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 22)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081088", "story_v_out_411081.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081088", "story_v_out_411081.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_out_411081", "411081088", "story_v_out_411081.awb")

						arg_363_1:RecordAudio("411081088", var_366_11)
						arg_363_1:RecordAudio("411081088", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_411081", "411081088", "story_v_out_411081.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_411081", "411081088", "story_v_out_411081.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_12 = math.max(var_366_5, arg_363_1.talkMaxDuration)

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_12 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_4) / var_366_12

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_4 + var_366_12 and arg_363_1.time_ < var_366_4 + var_366_12 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play411081089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 411081089
		arg_367_1.duration_ = 6.03

		local var_367_0 = {
			zh = 5.1,
			ja = 6.033
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
				arg_367_0:Play411081090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.65

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:GetWordFromCfg(411081089)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 26 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 26)

				if (26 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 26)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081089", "story_v_out_411081.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081089", "story_v_out_411081.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_out_411081", "411081089", "story_v_out_411081.awb")

						arg_367_1:RecordAudio("411081089", var_370_6)
						arg_367_1:RecordAudio("411081089", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_411081", "411081089", "story_v_out_411081.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_411081", "411081089", "story_v_out_411081.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play411081090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 411081090
		arg_371_1.duration_ = 5.73

		local var_371_0 = {
			zh = 5.733,
			ja = 4.066
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
				arg_371_0:Play411081091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["10014ui_story"]) and arg_371_1.var_.characterEffect10014ui_story == nil then
				arg_371_1.var_.characterEffect10014ui_story = arg_371_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["10014ui_story"]) then
				if arg_371_1.var_.characterEffect10014ui_story and not isNil(arg_371_1.actors_["10014ui_story"]) then
					arg_371_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_371_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["10014ui_story"]) and arg_371_1.var_.characterEffect10014ui_story then
				arg_371_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_371_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0
			local var_374_2 = 0.425

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:GetWordFromCfg(411081090)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_6 = 17 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_4) / 17)

				if (17 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_4) / 17)) > 0 and var_374_2 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081090", "story_v_out_411081.awb") ~= 0 then
					local var_374_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081090", "story_v_out_411081.awb") / 1000

					if var_374_7 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_1
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_out_411081", "411081090", "story_v_out_411081.awb")

						arg_371_1:RecordAudio("411081090", var_374_8)
						arg_371_1:RecordAudio("411081090", var_374_8)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_411081", "411081090", "story_v_out_411081.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_411081", "411081090", "story_v_out_411081.awb")
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
	Play411081091 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 411081091
		arg_375_1.duration_ = 3.27

		local var_375_0 = {
			zh = 1.2,
			ja = 3.266
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play411081092(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.1

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_1 = arg_375_1:GetWordFromCfg(411081091)
				local var_378_2 = arg_375_1:FormatText(var_378_1.content)

				arg_375_1.text_.text = var_378_2

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 4 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 4)

				if (4 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 4)) > 0 and var_378_0 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end

				arg_375_1.text_.text = var_378_2
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081091", "story_v_out_411081.awb") ~= 0 then
					local var_378_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081091", "story_v_out_411081.awb") / 1000

					if var_378_5 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + 0
					end

					if var_378_1.prefab_name ~= "" and arg_375_1.actors_[var_378_1.prefab_name] ~= nil then
						local var_378_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_1.prefab_name].transform, "story_v_out_411081", "411081091", "story_v_out_411081.awb")

						arg_375_1:RecordAudio("411081091", var_378_6)
						arg_375_1:RecordAudio("411081091", var_378_6)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_411081", "411081091", "story_v_out_411081.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_411081", "411081091", "story_v_out_411081.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play411081092 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 411081092
		arg_379_1.duration_ = 5

		local var_379_0 = {
			zh = 3.366,
			ja = 5
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
				arg_379_0:Play411081093(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["10014ui_story"]) and arg_379_1.var_.characterEffect10014ui_story == nil then
				arg_379_1.var_.characterEffect10014ui_story = arg_379_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["10014ui_story"]) then
				if arg_379_1.var_.characterEffect10014ui_story and not isNil(arg_379_1.actors_["10014ui_story"]) then
					arg_379_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["10014ui_story"]) and arg_379_1.var_.characterEffect10014ui_story then
				arg_379_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_382_2 = 0
			local var_382_3 = 0.3

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_2 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_4 = arg_379_1:GetWordFromCfg(411081092)
				local var_382_5 = arg_379_1:FormatText(var_382_4.content)

				arg_379_1.text_.text = var_382_5

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_7 = 12 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 12)

				if (12 <= 0 and var_382_3 or var_382_3 * (utf8.len(var_382_5) / 12)) > 0 and var_382_3 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_2
					end
				end

				arg_379_1.text_.text = var_382_5
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081092", "story_v_out_411081.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_out_411081", "411081092", "story_v_out_411081.awb") / 1000

					if var_382_8 + var_382_2 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_2
					end

					if var_382_4.prefab_name ~= "" and arg_379_1.actors_[var_382_4.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_4.prefab_name].transform, "story_v_out_411081", "411081092", "story_v_out_411081.awb")

						arg_379_1:RecordAudio("411081092", var_382_9)
						arg_379_1:RecordAudio("411081092", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_411081", "411081092", "story_v_out_411081.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_411081", "411081092", "story_v_out_411081.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_3, arg_379_1.talkMaxDuration)

			if var_382_2 <= arg_379_1.time_ and arg_379_1.time_ < var_382_2 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_2) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_2 + var_382_10 and arg_379_1.time_ < var_382_2 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play411081093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 411081093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play411081094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos10014ui_story = arg_383_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["10014ui_story"].transform.position).z)
				arg_383_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["10014ui_story"].transform.localEulerAngles = arg_383_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["10014ui_story"].transform.position).z)
				arg_383_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["10014ui_story"].transform.localEulerAngles = arg_383_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_386_1 = 0
			local var_386_2 = 1.125

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(411081093).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 45 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 45)

				if (45 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 45)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play411081094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 411081094
		arg_387_1.duration_ = 6.4

		local var_387_0 = {
			zh = 6.4,
			ja = 4.533
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
				arg_387_0:Play411081095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.7

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_1 = arg_387_1:GetWordFromCfg(411081094)
				local var_390_2 = arg_387_1:FormatText(var_390_1.content)

				arg_387_1.text_.text = var_390_2

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 28 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 28)

				if (28 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 28)) > 0 and var_390_0 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end

				arg_387_1.text_.text = var_390_2
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081094", "story_v_out_411081.awb") ~= 0 then
					local var_390_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081094", "story_v_out_411081.awb") / 1000

					if var_390_5 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + 0
					end

					if var_390_1.prefab_name ~= "" and arg_387_1.actors_[var_390_1.prefab_name] ~= nil then
						local var_390_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_1.prefab_name].transform, "story_v_out_411081", "411081094", "story_v_out_411081.awb")

						arg_387_1:RecordAudio("411081094", var_390_6)
						arg_387_1:RecordAudio("411081094", var_390_6)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_411081", "411081094", "story_v_out_411081.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_411081", "411081094", "story_v_out_411081.awb")
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
	Play411081095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 411081095
		arg_391_1.duration_ = 12.2

		local var_391_0 = {
			zh = 12.2,
			ja = 10.066
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play411081096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 1.175

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_1 = arg_391_1:GetWordFromCfg(411081095)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 47 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 47)

				if (47 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 47)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081095", "story_v_out_411081.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081095", "story_v_out_411081.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_411081", "411081095", "story_v_out_411081.awb")

						arg_391_1:RecordAudio("411081095", var_394_6)
						arg_391_1:RecordAudio("411081095", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_411081", "411081095", "story_v_out_411081.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_411081", "411081095", "story_v_out_411081.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play411081096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 411081096
		arg_395_1.duration_ = 7.77

		local var_395_0 = {
			zh = 7.766,
			ja = 2.566
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
				arg_395_0:Play411081097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.725

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_1 = arg_395_1:GetWordFromCfg(411081096)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 29 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 29)

				if (29 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 29)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081096", "story_v_out_411081.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081096", "story_v_out_411081.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_out_411081", "411081096", "story_v_out_411081.awb")

						arg_395_1:RecordAudio("411081096", var_398_6)
						arg_395_1:RecordAudio("411081096", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_411081", "411081096", "story_v_out_411081.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_411081", "411081096", "story_v_out_411081.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play411081097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 411081097
		arg_399_1.duration_ = 2

		local var_399_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_399_0:Play411081098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos10014ui_story = arg_399_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["10014ui_story"].transform.position).z)
				arg_399_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["10014ui_story"].transform.localEulerAngles = arg_399_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_399_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["10014ui_story"].transform.position).z)
				arg_399_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["10014ui_story"].transform.localEulerAngles = arg_399_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_402_1 = arg_399_1.actors_["10014ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect10014ui_story == nil then
				arg_399_1.var_.characterEffect10014ui_story = var_402_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_2 and not isNil(var_402_1) then
				if arg_399_1.var_.characterEffect10014ui_story and not isNil(var_402_1) then
					arg_399_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_2 and arg_399_1.time_ < 0 + var_402_2 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect10014ui_story then
				arg_399_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014actionlink/10014action446")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_4 = 0
			local var_402_5 = 0.15

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_6 = arg_399_1:GetWordFromCfg(411081097)
				local var_402_7 = arg_399_1:FormatText(var_402_6.content)

				arg_399_1.text_.text = var_402_7

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_9 = 6 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 6)

				if (6 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 6)) > 0 and var_402_5 < var_402_9 then
					arg_399_1.talkMaxDuration = var_402_9

					if var_402_9 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_9 + var_402_4
					end
				end

				arg_399_1.text_.text = var_402_7
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081097", "story_v_out_411081.awb") ~= 0 then
					local var_402_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081097", "story_v_out_411081.awb") / 1000

					if var_402_10 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_4
					end

					if var_402_6.prefab_name ~= "" and arg_399_1.actors_[var_402_6.prefab_name] ~= nil then
						local var_402_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_6.prefab_name].transform, "story_v_out_411081", "411081097", "story_v_out_411081.awb")

						arg_399_1:RecordAudio("411081097", var_402_11)
						arg_399_1:RecordAudio("411081097", var_402_11)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_411081", "411081097", "story_v_out_411081.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_411081", "411081097", "story_v_out_411081.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_12 = math.max(var_402_5, arg_399_1.talkMaxDuration)

			if var_402_4 <= arg_399_1.time_ and arg_399_1.time_ < var_402_4 + var_402_12 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_4) / var_402_12

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_4 + var_402_12 and arg_399_1.time_ < var_402_4 + var_402_12 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play411081098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 411081098
		arg_403_1.duration_ = 5

		local var_403_0 = {
			zh = 5,
			ja = 2.5
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
				arg_403_0:Play411081099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.625

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:GetWordFromCfg(411081098)
				local var_406_2 = arg_403_1:FormatText(var_406_1.content)

				arg_403_1.text_.text = var_406_2

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_4 = 25 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_2) / 25)

				if (25 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_2) / 25)) > 0 and var_406_0 < var_406_4 then
					arg_403_1.talkMaxDuration = var_406_4

					if var_406_4 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_4 + 0
					end
				end

				arg_403_1.text_.text = var_406_2
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081098", "story_v_out_411081.awb") ~= 0 then
					local var_406_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081098", "story_v_out_411081.awb") / 1000

					if var_406_5 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + 0
					end

					if var_406_1.prefab_name ~= "" and arg_403_1.actors_[var_406_1.prefab_name] ~= nil then
						local var_406_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_1.prefab_name].transform, "story_v_out_411081", "411081098", "story_v_out_411081.awb")

						arg_403_1:RecordAudio("411081098", var_406_6)
						arg_403_1:RecordAudio("411081098", var_406_6)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_411081", "411081098", "story_v_out_411081.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_411081", "411081098", "story_v_out_411081.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_7 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_7 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_7

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_7 and arg_403_1.time_ < 0 + var_406_7 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play411081099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 411081099
		arg_407_1.duration_ = 5.97

		local var_407_0 = {
			zh = 5.966,
			ja = 4.2
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
				arg_407_0:Play411081100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.7

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:GetWordFromCfg(411081099)
				local var_410_2 = arg_407_1:FormatText(var_410_1.content)

				arg_407_1.text_.text = var_410_2

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 28 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 28)

				if (28 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 28)) > 0 and var_410_0 < var_410_4 then
					arg_407_1.talkMaxDuration = var_410_4

					if var_410_4 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_4 + 0
					end
				end

				arg_407_1.text_.text = var_410_2
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081099", "story_v_out_411081.awb") ~= 0 then
					local var_410_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081099", "story_v_out_411081.awb") / 1000

					if var_410_5 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + 0
					end

					if var_410_1.prefab_name ~= "" and arg_407_1.actors_[var_410_1.prefab_name] ~= nil then
						local var_410_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_1.prefab_name].transform, "story_v_out_411081", "411081099", "story_v_out_411081.awb")

						arg_407_1:RecordAudio("411081099", var_410_6)
						arg_407_1:RecordAudio("411081099", var_410_6)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_411081", "411081099", "story_v_out_411081.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_411081", "411081099", "story_v_out_411081.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_7 and arg_407_1.time_ < 0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play411081100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 411081100
		arg_411_1.duration_ = 4.97

		local var_411_0 = {
			zh = 4.366,
			ja = 4.966
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play411081101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.425

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_1 = arg_411_1:GetWordFromCfg(411081100)
				local var_414_2 = arg_411_1:FormatText(var_414_1.content)

				arg_411_1.text_.text = var_414_2

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 17 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 17)

				if (17 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 17)) > 0 and var_414_0 < var_414_4 then
					arg_411_1.talkMaxDuration = var_414_4

					if var_414_4 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_4 + 0
					end
				end

				arg_411_1.text_.text = var_414_2
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081100", "story_v_out_411081.awb") ~= 0 then
					local var_414_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081100", "story_v_out_411081.awb") / 1000

					if var_414_5 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + 0
					end

					if var_414_1.prefab_name ~= "" and arg_411_1.actors_[var_414_1.prefab_name] ~= nil then
						local var_414_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_1.prefab_name].transform, "story_v_out_411081", "411081100", "story_v_out_411081.awb")

						arg_411_1:RecordAudio("411081100", var_414_6)
						arg_411_1:RecordAudio("411081100", var_414_6)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_411081", "411081100", "story_v_out_411081.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_411081", "411081100", "story_v_out_411081.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_7 and arg_411_1.time_ < 0 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play411081101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 411081101
		arg_415_1.duration_ = 5.23

		local var_415_0 = {
			zh = 3.166,
			ja = 5.233
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play411081102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["10014ui_story"]) and arg_415_1.var_.characterEffect10014ui_story == nil then
				arg_415_1.var_.characterEffect10014ui_story = arg_415_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["10014ui_story"]) then
				if arg_415_1.var_.characterEffect10014ui_story and not isNil(arg_415_1.actors_["10014ui_story"]) then
					arg_415_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_415_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["10014ui_story"]) and arg_415_1.var_.characterEffect10014ui_story then
				arg_415_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_415_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_418_1 = 0
			local var_418_2 = 0.25

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:GetWordFromCfg(411081101)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_6 = 10 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_4) / 10)

				if (10 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_4) / 10)) > 0 and var_418_2 < var_418_6 then
					arg_415_1.talkMaxDuration = var_418_6

					if var_418_6 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081101", "story_v_out_411081.awb") ~= 0 then
					local var_418_7 = manager.audio:GetVoiceLength("story_v_out_411081", "411081101", "story_v_out_411081.awb") / 1000

					if var_418_7 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_1
					end

					if var_418_3.prefab_name ~= "" and arg_415_1.actors_[var_418_3.prefab_name] ~= nil then
						local var_418_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_3.prefab_name].transform, "story_v_out_411081", "411081101", "story_v_out_411081.awb")

						arg_415_1:RecordAudio("411081101", var_418_8)
						arg_415_1:RecordAudio("411081101", var_418_8)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_411081", "411081101", "story_v_out_411081.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_411081", "411081101", "story_v_out_411081.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_9 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_9 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_9

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_9 and arg_415_1.time_ < var_418_1 + var_418_9 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play411081102 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 411081102
		arg_419_1.duration_ = 9.6

		local var_419_0 = {
			zh = 9.6,
			ja = 7.9
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play411081103(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.675

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_1 = arg_419_1:GetWordFromCfg(411081102)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 27 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 27)

				if (27 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 27)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081102", "story_v_out_411081.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081102", "story_v_out_411081.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_411081", "411081102", "story_v_out_411081.awb")

						arg_419_1:RecordAudio("411081102", var_422_6)
						arg_419_1:RecordAudio("411081102", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_411081", "411081102", "story_v_out_411081.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_411081", "411081102", "story_v_out_411081.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play411081103 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 411081103
		arg_423_1.duration_ = 4.63

		local var_423_0 = {
			zh = 3.166,
			ja = 4.633
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play411081104(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.475

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[679].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:GetWordFromCfg(411081103)
				local var_426_2 = arg_423_1:FormatText(var_426_1.content)

				arg_423_1.text_.text = var_426_2

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 19 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 19)

				if (19 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_2) / 19)) > 0 and var_426_0 < var_426_4 then
					arg_423_1.talkMaxDuration = var_426_4

					if var_426_4 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_4 + 0
					end
				end

				arg_423_1.text_.text = var_426_2
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081103", "story_v_out_411081.awb") ~= 0 then
					local var_426_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081103", "story_v_out_411081.awb") / 1000

					if var_426_5 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + 0
					end

					if var_426_1.prefab_name ~= "" and arg_423_1.actors_[var_426_1.prefab_name] ~= nil then
						local var_426_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_1.prefab_name].transform, "story_v_out_411081", "411081103", "story_v_out_411081.awb")

						arg_423_1:RecordAudio("411081103", var_426_6)
						arg_423_1:RecordAudio("411081103", var_426_6)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_411081", "411081103", "story_v_out_411081.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_411081", "411081103", "story_v_out_411081.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_7 and arg_423_1.time_ < 0 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play411081104 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 411081104
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play411081105(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos10014ui_story = arg_427_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["10014ui_story"].transform.position).z)
				arg_427_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["10014ui_story"].transform.localEulerAngles = arg_427_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_427_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["10014ui_story"].transform.position).z)
				arg_427_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["10014ui_story"].transform.localEulerAngles = arg_427_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_430_1 = 0
			local var_430_2 = 0.725

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_3 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(411081104).content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 29 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 29)

				if (29 <= 0 and var_430_2 or var_430_2 * (utf8.len(var_430_3) / 29)) > 0 and var_430_2 < var_430_5 then
					arg_427_1.talkMaxDuration = var_430_5

					if var_430_5 + var_430_1 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + var_430_1
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_6 = math.max(var_430_2, arg_427_1.talkMaxDuration)

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_6 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_1) / var_430_6

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_1 + var_430_6 and arg_427_1.time_ < var_430_1 + var_430_6 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play411081105 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 411081105
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play411081106(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.15

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(411081105).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 46 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 46)

				if (46 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 46)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play411081106 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 411081106
		arg_435_1.duration_ = 7.63

		local var_435_0 = {
			zh = 6.266,
			ja = 7.633
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play411081107(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.6

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_1 = arg_435_1:GetWordFromCfg(411081106)
				local var_438_2 = arg_435_1:FormatText(var_438_1.content)

				arg_435_1.text_.text = var_438_2

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_4 = 24 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 24)

				if (24 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_2) / 24)) > 0 and var_438_0 < var_438_4 then
					arg_435_1.talkMaxDuration = var_438_4

					if var_438_4 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_4 + 0
					end
				end

				arg_435_1.text_.text = var_438_2
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081106", "story_v_out_411081.awb") ~= 0 then
					local var_438_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081106", "story_v_out_411081.awb") / 1000

					if var_438_5 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + 0
					end

					if var_438_1.prefab_name ~= "" and arg_435_1.actors_[var_438_1.prefab_name] ~= nil then
						local var_438_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_1.prefab_name].transform, "story_v_out_411081", "411081106", "story_v_out_411081.awb")

						arg_435_1:RecordAudio("411081106", var_438_6)
						arg_435_1:RecordAudio("411081106", var_438_6)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_411081", "411081106", "story_v_out_411081.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_411081", "411081106", "story_v_out_411081.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_7 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_7 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_7

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_7 and arg_435_1.time_ < 0 + var_438_7 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play411081107 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 411081107
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play411081108(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.65

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_1 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(411081107).content)

				arg_439_1.text_.text = var_442_1

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_3 = 26 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 26)

				if (26 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_1) / 26)) > 0 and var_442_0 < var_442_3 then
					arg_439_1.talkMaxDuration = var_442_3

					if var_442_3 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_3 + 0
					end
				end

				arg_439_1.text_.text = var_442_1
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_4 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_4

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play411081108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 411081108
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play411081109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_gun", "")
			end

			local var_446_1 = 0
			local var_446_2 = 1.625

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_3 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(411081108).content)

				arg_443_1.text_.text = var_446_3

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 65 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 65)

				if (65 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 65)) > 0 and var_446_2 < var_446_5 then
					arg_443_1.talkMaxDuration = var_446_5

					if var_446_5 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_5 + var_446_1
					end
				end

				arg_443_1.text_.text = var_446_3
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_6 = math.max(var_446_2, arg_443_1.talkMaxDuration)

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_6 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_1) / var_446_6

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_1 + var_446_6 and arg_443_1.time_ < var_446_1 + var_446_6 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play411081109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 411081109
		arg_447_1.duration_ = 5.07

		local var_447_0 = {
			zh = 5.066,
			ja = 4.066
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play411081110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.525

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[678].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_1 = arg_447_1:GetWordFromCfg(411081109)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.text_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 21 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 21)

				if (21 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 21)) > 0 and var_450_0 < var_450_4 then
					arg_447_1.talkMaxDuration = var_450_4

					if var_450_4 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_4 + 0
					end
				end

				arg_447_1.text_.text = var_450_2
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081109", "story_v_out_411081.awb") ~= 0 then
					local var_450_5 = manager.audio:GetVoiceLength("story_v_out_411081", "411081109", "story_v_out_411081.awb") / 1000

					if var_450_5 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + 0
					end

					if var_450_1.prefab_name ~= "" and arg_447_1.actors_[var_450_1.prefab_name] ~= nil then
						local var_450_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_1.prefab_name].transform, "story_v_out_411081", "411081109", "story_v_out_411081.awb")

						arg_447_1:RecordAudio("411081109", var_450_6)
						arg_447_1:RecordAudio("411081109", var_450_6)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_411081", "411081109", "story_v_out_411081.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_411081", "411081109", "story_v_out_411081.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_7 and arg_447_1.time_ < 0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play411081110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 411081110
		arg_451_1.duration_ = 5.83

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play411081111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_9000

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				local var_454_0 = arg_451_1.var_.effect12345

				if not arg_451_1.var_.effect12345 then
					var_454_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_454_0.name = "12345"
					arg_451_1.var_.effect12345 = var_454_0
				else
					var_454_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_454_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_454_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_451_1.time_ and arg_451_1.time_ <= 0.2 + arg_454_0 then
				local var_454_2 = arg_451_1.var_.effect1123

				if not arg_451_1.var_.effect1123 then
					var_454_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), manager.ui.mainCamera.transform)
					var_454_2.name = "1123"
					arg_451_1.var_.effect1123 = var_454_2
				else
					var_454_2.transform:SetParent(var_454_9000)
				end

				var_454_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_454_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_noise", "")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			local var_454_6 = 0.833333333333333
			local var_454_7 = 1.6

			if 0.833333333333333 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_8 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(411081110).content)

				arg_451_1.text_.text = var_454_8

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_10 = 64 <= 0 and var_454_7 or var_454_7 * (utf8.len(var_454_8) / 64)

				if (64 <= 0 and var_454_7 or var_454_7 * (utf8.len(var_454_8) / 64)) > 0 and var_454_7 < var_454_10 then
					arg_451_1.talkMaxDuration = var_454_10

					if var_454_10 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_10 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_8
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_11 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_11 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_11

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_11 and arg_451_1.time_ < var_454_6 + var_454_11 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play411081111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 411081111
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play411081112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_458_0 = 0.5

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 then
				local var_458_1, var_458_2 = math.modf((arg_455_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_458_2 * 0.13, var_458_2 * 0.13, var_458_2 * 0.13) + arg_455_1.var_.shakeOldPos
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 then
				manager.ui.mainCamera.transform.localPosition = arg_455_1.var_.shakeOldPos
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				if arg_455_1.var_.effect12345 then
					Object.Destroy(arg_455_1.var_.effect12345)

					arg_455_1.var_.effect12345 = nil
				end
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				if arg_455_1.var_.effect1123 then
					Object.Destroy(arg_455_1.var_.effect1123)

					arg_455_1.var_.effect1123 = nil
				end
			end

			local var_458_5 = 0
			local var_458_6 = 1.125

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_5 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_7 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(411081111).content)

				arg_455_1.text_.text = var_458_7

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_9 = 45 <= 0 and var_458_6 or var_458_6 * (utf8.len(var_458_7) / 45)

				if (45 <= 0 and var_458_6 or var_458_6 * (utf8.len(var_458_7) / 45)) > 0 and var_458_6 < var_458_9 then
					arg_455_1.talkMaxDuration = var_458_9

					if var_458_9 + var_458_5 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_9 + var_458_5
					end
				end

				arg_455_1.text_.text = var_458_7
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_10 = math.max(var_458_6, arg_455_1.talkMaxDuration)

			if var_458_5 <= arg_455_1.time_ and arg_455_1.time_ < var_458_5 + var_458_10 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_5) / var_458_10

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_5 + var_458_10 and arg_455_1.time_ < var_458_5 + var_458_10 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play411081112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 411081112
		arg_459_1.duration_ = 6.47

		local var_459_0 = {
			zh = 6.466,
			ja = 2.833
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play411081113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.var_.moveOldPos10014ui_story = arg_459_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_462_0 = 0.001

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 then
				arg_459_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_459_1.time_ - 0) / var_462_0)
				arg_459_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["10014ui_story"].transform.position).z)
				arg_459_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["10014ui_story"].transform.localEulerAngles = arg_459_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 then
				arg_459_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_459_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["10014ui_story"].transform.position).z)
				arg_459_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["10014ui_story"].transform.localEulerAngles = arg_459_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_462_1 = arg_459_1.actors_["10014ui_story"]

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(var_462_1) and arg_459_1.var_.characterEffect10014ui_story == nil then
				arg_459_1.var_.characterEffect10014ui_story = var_462_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_2 and not isNil(var_462_1) then
				if arg_459_1.var_.characterEffect10014ui_story and not isNil(var_462_1) then
					arg_459_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= 0 + var_462_2 and arg_459_1.time_ < 0 + var_462_2 + arg_462_0 and not isNil(var_462_1) and arg_459_1.var_.characterEffect10014ui_story then
				arg_459_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_462_4 = 0
			local var_462_5 = 0.425

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_6 = arg_459_1:GetWordFromCfg(411081112)
				local var_462_7 = arg_459_1:FormatText(var_462_6.content)

				arg_459_1.text_.text = var_462_7

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_9 = 17 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 17)

				if (17 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 17)) > 0 and var_462_5 < var_462_9 then
					arg_459_1.talkMaxDuration = var_462_9

					if var_462_9 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_9 + var_462_4
					end
				end

				arg_459_1.text_.text = var_462_7
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411081", "411081112", "story_v_out_411081.awb") ~= 0 then
					local var_462_10 = manager.audio:GetVoiceLength("story_v_out_411081", "411081112", "story_v_out_411081.awb") / 1000

					if var_462_10 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_10 + var_462_4
					end

					if var_462_6.prefab_name ~= "" and arg_459_1.actors_[var_462_6.prefab_name] ~= nil then
						local var_462_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_6.prefab_name].transform, "story_v_out_411081", "411081112", "story_v_out_411081.awb")

						arg_459_1:RecordAudio("411081112", var_462_11)
						arg_459_1:RecordAudio("411081112", var_462_11)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_411081", "411081112", "story_v_out_411081.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_411081", "411081112", "story_v_out_411081.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_12 = math.max(var_462_5, arg_459_1.talkMaxDuration)

			if var_462_4 <= arg_459_1.time_ and arg_459_1.time_ < var_462_4 + var_462_12 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_4) / var_462_12

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_4 + var_462_12 and arg_459_1.time_ < var_462_4 + var_462_12 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play411081113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 411081113
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
			arg_463_1.auto_ = false
		end

		function arg_463_1.playNext_(arg_465_0)
			arg_463_1.onStoryFinished_()
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["10014ui_story"]) and arg_463_1.var_.characterEffect10014ui_story == nil then
				arg_463_1.var_.characterEffect10014ui_story = arg_463_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["10014ui_story"]) then
				if arg_463_1.var_.characterEffect10014ui_story and not isNil(arg_463_1.actors_["10014ui_story"]) then
					arg_463_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_463_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_463_1.time_ - 0) / var_466_0)
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["10014ui_story"]) and arg_463_1.var_.characterEffect10014ui_story then
				arg_463_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_463_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_gun", "")
			end

			local var_466_2 = 0
			local var_466_3 = 0.6

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_2 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_4 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(411081113).content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_6 = 24 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_4) / 24)

				if (24 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_4) / 24)) > 0 and var_466_3 < var_466_6 then
					arg_463_1.talkMaxDuration = var_466_6

					if var_466_6 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_6 + var_466_2
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_7 = math.max(var_466_3, arg_463_1.talkMaxDuration)

			if var_466_2 <= arg_463_1.time_ and arg_463_1.time_ < var_466_2 + var_466_7 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_2) / var_466_7

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_2 + var_466_7 and arg_463_1.time_ < var_466_2 + var_466_7 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02d",
		"TextureConfig/Background/B06a",
		"TextureConfig/Background/B08d"
	},
	voices = {
		"story_v_out_411081.awb"
	}
}
