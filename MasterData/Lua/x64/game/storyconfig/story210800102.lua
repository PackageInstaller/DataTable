return {
	Play108002001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108002001
		arg_1_1.duration_ = 4.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play108002002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST07a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07a")
				var_4_0.name = "ST07a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST07a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST07a

				arg_1_1.bgs_.ST07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_14 + 2.96666666666667 and arg_1_1.time_ < var_4_14 + 2.96666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(108002001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 8 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 8)

				if (8 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 8)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002001", "story_v_side_old_108002.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002001", "story_v_side_old_108002.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_side_old_108002", "108002001", "story_v_side_old_108002.awb")

						arg_1_1:RecordAudio("108002001", var_4_23)
						arg_1_1:RecordAudio("108002001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002001", "story_v_side_old_108002.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002001", "story_v_side_old_108002.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play108002002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 108002002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play108002003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_door", "")
			end

			local var_12_1 = 0
			local var_12_2 = 0.9

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(108002002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 36 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 36)

				if (36 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 36)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play108002003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 108002003
		arg_13_1.duration_ = 6

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play108002004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1080ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1080ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1080ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1080ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1080ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1080ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.01, -6.05)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1080ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1080ui_story == nil then
				arg_13_1.var_.characterEffect1080ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1080ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1080ui_story then
				arg_13_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_16_8 = 0
			local var_16_9 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(108002003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 20 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 20)

				if (20 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 20)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002003", "story_v_side_old_108002.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002003", "story_v_side_old_108002.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_side_old_108002", "108002003", "story_v_side_old_108002.awb")

						arg_13_1:RecordAudio("108002003", var_16_15)
						arg_13_1:RecordAudio("108002003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002003", "story_v_side_old_108002.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002003", "story_v_side_old_108002.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play108002004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 108002004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play108002005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1080ui_story = arg_17_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1080ui_story"].transform.position).z)
				arg_17_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1080ui_story"].transform.localEulerAngles = arg_17_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1080ui_story"].transform.position).z)
				arg_17_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1080ui_story"].transform.localEulerAngles = arg_17_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_20_1 = 0
			local var_20_2 = 0.55

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(108002004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 22 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 22)

				if (22 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 22)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play108002005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 108002005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play108002006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.725

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(108002005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 29 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 29)

				if (29 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 29)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play108002006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 108002006
		arg_25_1.duration_ = 4.83

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play108002007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1080ui_story = arg_25_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1080ui_story"].transform.position).z)
				arg_25_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1080ui_story"].transform.localEulerAngles = arg_25_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_25_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1080ui_story"].transform.position).z)
				arg_25_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1080ui_story"].transform.localEulerAngles = arg_25_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1080ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1080ui_story == nil then
				arg_25_1.var_.characterEffect1080ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1080ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1080ui_story then
				arg_25_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_4 = 0
			local var_28_5 = 0.375

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(108002006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 15 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 15)

				if (15 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 15)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002006", "story_v_side_old_108002.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002006", "story_v_side_old_108002.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_side_old_108002", "108002006", "story_v_side_old_108002.awb")

						arg_25_1:RecordAudio("108002006", var_28_11)
						arg_25_1:RecordAudio("108002006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002006", "story_v_side_old_108002.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002006", "story_v_side_old_108002.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play108002007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 108002007
		arg_29_1.duration_ = 3.5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play108002008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_32_0 = 0
			local var_32_1 = 0.375

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(108002007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 15 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 15)

				if (15 <= 0 and var_32_1 or var_32_1 * (utf8.len(var_32_3) / 15)) > 0 and var_32_1 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002007", "story_v_side_old_108002.awb") ~= 0 then
					local var_32_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002007", "story_v_side_old_108002.awb") / 1000

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end

					if var_32_2.prefab_name ~= "" and arg_29_1.actors_[var_32_2.prefab_name] ~= nil then
						local var_32_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_2.prefab_name].transform, "story_v_side_old_108002", "108002007", "story_v_side_old_108002.awb")

						arg_29_1:RecordAudio("108002007", var_32_7)
						arg_29_1:RecordAudio("108002007", var_32_7)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002007", "story_v_side_old_108002.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002007", "story_v_side_old_108002.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play108002008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 108002008
		arg_33_1.duration_ = 6.4

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play108002009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action4_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_36_0 = 0
			local var_36_1 = 0.375

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(108002008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 15 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 15)

				if (15 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 15)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002008", "story_v_side_old_108002.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002008", "story_v_side_old_108002.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_side_old_108002", "108002008", "story_v_side_old_108002.awb")

						arg_33_1:RecordAudio("108002008", var_36_7)
						arg_33_1:RecordAudio("108002008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002008", "story_v_side_old_108002.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002008", "story_v_side_old_108002.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play108002009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 108002009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play108002010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1080ui_story"]) and arg_37_1.var_.characterEffect1080ui_story == nil then
				arg_37_1.var_.characterEffect1080ui_story = arg_37_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1080ui_story"]) then
				if arg_37_1.var_.characterEffect1080ui_story and not isNil(arg_37_1.actors_["1080ui_story"]) then
					arg_37_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1080ui_story"]) and arg_37_1.var_.characterEffect1080ui_story then
				arg_37_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.3

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(108002009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 12 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 12)

				if (12 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 12)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play108002010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 108002010
		arg_41_1.duration_ = 3.2

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play108002011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1080ui_story"]) and arg_41_1.var_.characterEffect1080ui_story == nil then
				arg_41_1.var_.characterEffect1080ui_story = arg_41_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1080ui_story"]) then
				if arg_41_1.var_.characterEffect1080ui_story and not isNil(arg_41_1.actors_["1080ui_story"]) then
					arg_41_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1080ui_story"]) and arg_41_1.var_.characterEffect1080ui_story then
				arg_41_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_44_2 = 0
			local var_44_3 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(108002010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 13 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 13)

				if (13 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 13)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002010", "story_v_side_old_108002.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002010", "story_v_side_old_108002.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_old_108002", "108002010", "story_v_side_old_108002.awb")

						arg_41_1:RecordAudio("108002010", var_44_9)
						arg_41_1:RecordAudio("108002010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002010", "story_v_side_old_108002.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002010", "story_v_side_old_108002.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play108002011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 108002011
		arg_45_1.duration_ = 6.7

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play108002012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action446")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_0 = 0
			local var_48_1 = 0.525

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(108002011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 21 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 21)

				if (21 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 21)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002011", "story_v_side_old_108002.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002011", "story_v_side_old_108002.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_side_old_108002", "108002011", "story_v_side_old_108002.awb")

						arg_45_1:RecordAudio("108002011", var_48_7)
						arg_45_1:RecordAudio("108002011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002011", "story_v_side_old_108002.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002011", "story_v_side_old_108002.awb")
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
	Play108002012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 108002012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play108002013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1080ui_story"]) and arg_49_1.var_.characterEffect1080ui_story == nil then
				arg_49_1.var_.characterEffect1080ui_story = arg_49_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1080ui_story"]) then
				if arg_49_1.var_.characterEffect1080ui_story and not isNil(arg_49_1.actors_["1080ui_story"]) then
					arg_49_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1080ui_story"]) and arg_49_1.var_.characterEffect1080ui_story then
				arg_49_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.55

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(108002012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 22 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 22)

				if (22 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 22)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play108002013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 108002013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play108002014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1080ui_story"]) and arg_53_1.var_.characterEffect1080ui_story == nil then
				arg_53_1.var_.characterEffect1080ui_story = arg_53_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1080ui_story"]) then
				if arg_53_1.var_.characterEffect1080ui_story and not isNil(arg_53_1.actors_["1080ui_story"]) then
					arg_53_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1080ui_story"]) and arg_53_1.var_.characterEffect1080ui_story then
				arg_53_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_56_2 = 0
			local var_56_3 = 0.15

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(108002013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 6 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 6)

				if (6 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 6)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002013", "story_v_side_old_108002.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002013", "story_v_side_old_108002.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_side_old_108002", "108002013", "story_v_side_old_108002.awb")

						arg_53_1:RecordAudio("108002013", var_56_9)
						arg_53_1:RecordAudio("108002013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002013", "story_v_side_old_108002.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002013", "story_v_side_old_108002.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play108002014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 108002014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play108002015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1080ui_story"]) and arg_57_1.var_.characterEffect1080ui_story == nil then
				arg_57_1.var_.characterEffect1080ui_story = arg_57_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1080ui_story"]) then
				if arg_57_1.var_.characterEffect1080ui_story and not isNil(arg_57_1.actors_["1080ui_story"]) then
					arg_57_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1080ui_story"]) and arg_57_1.var_.characterEffect1080ui_story then
				arg_57_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(108002014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 23 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 23)

				if (23 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 23)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play108002015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 108002015
		arg_61_1.duration_ = 4.5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play108002016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1080ui_story"]) and arg_61_1.var_.characterEffect1080ui_story == nil then
				arg_61_1.var_.characterEffect1080ui_story = arg_61_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1080ui_story"]) then
				if arg_61_1.var_.characterEffect1080ui_story and not isNil(arg_61_1.actors_["1080ui_story"]) then
					arg_61_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1080ui_story"]) and arg_61_1.var_.characterEffect1080ui_story then
				arg_61_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_64_2 = 0
			local var_64_3 = 0.325

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(108002015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 13 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 13)

				if (13 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 13)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002015", "story_v_side_old_108002.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002015", "story_v_side_old_108002.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_side_old_108002", "108002015", "story_v_side_old_108002.awb")

						arg_61_1:RecordAudio("108002015", var_64_9)
						arg_61_1:RecordAudio("108002015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002015", "story_v_side_old_108002.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002015", "story_v_side_old_108002.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play108002016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 108002016
		arg_65_1.duration_ = 4.87

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play108002017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action4_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_0 = 0
			local var_68_1 = 0.5

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(108002016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 20 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 20)

				if (20 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 20)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002016", "story_v_side_old_108002.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002016", "story_v_side_old_108002.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_side_old_108002", "108002016", "story_v_side_old_108002.awb")

						arg_65_1:RecordAudio("108002016", var_68_7)
						arg_65_1:RecordAudio("108002016", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002016", "story_v_side_old_108002.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002016", "story_v_side_old_108002.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play108002017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 108002017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play108002018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1080ui_story = arg_69_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1080ui_story"].transform.position).z)
				arg_69_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1080ui_story"].transform.localEulerAngles = arg_69_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1080ui_story"].transform.position).z)
				arg_69_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1080ui_story"].transform.localEulerAngles = arg_69_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_72_1 = 0
			local var_72_2 = 0.375

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

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(108002017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 15 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 15)

				if (15 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 15)) > 0 and var_72_2 < var_72_5 then
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

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play108002018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 108002018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play108002019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.65

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(108002018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 26 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 26)

				if (26 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 26)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play108002019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 108002019
		arg_77_1.duration_ = 5.53

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play108002020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1080ui_story = arg_77_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1080ui_story"].transform.position).z)
				arg_77_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1080ui_story"].transform.localEulerAngles = arg_77_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_77_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1080ui_story"].transform.position).z)
				arg_77_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1080ui_story"].transform.localEulerAngles = arg_77_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1080ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1080ui_story == nil then
				arg_77_1.var_.characterEffect1080ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1080ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1080ui_story then
				arg_77_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.35

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(108002019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 14 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 14)

				if (14 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 14)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002019", "story_v_side_old_108002.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002019", "story_v_side_old_108002.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_side_old_108002", "108002019", "story_v_side_old_108002.awb")

						arg_77_1:RecordAudio("108002019", var_80_11)
						arg_77_1:RecordAudio("108002019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002019", "story_v_side_old_108002.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002019", "story_v_side_old_108002.awb")
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

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play108002020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 108002020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play108002021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1080ui_story"]) and arg_81_1.var_.characterEffect1080ui_story == nil then
				arg_81_1.var_.characterEffect1080ui_story = arg_81_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1080ui_story"]) then
				if arg_81_1.var_.characterEffect1080ui_story and not isNil(arg_81_1.actors_["1080ui_story"]) then
					arg_81_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1080ui_story"]) and arg_81_1.var_.characterEffect1080ui_story then
				arg_81_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.625

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(108002020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 25 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 25)

				if (25 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 25)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play108002021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 108002021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play108002022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.75

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(108002021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 30 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 30)

				if (30 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 30)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play108002022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 108002022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play108002023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(108002022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 3 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 3)

				if (3 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 3)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play108002023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 108002023
		arg_93_1.duration_ = 2.63

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play108002024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1080ui_story"]) and arg_93_1.var_.characterEffect1080ui_story == nil then
				arg_93_1.var_.characterEffect1080ui_story = arg_93_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1080ui_story"]) then
				if arg_93_1.var_.characterEffect1080ui_story and not isNil(arg_93_1.actors_["1080ui_story"]) then
					arg_93_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1080ui_story"]) and arg_93_1.var_.characterEffect1080ui_story then
				arg_93_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_2")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_96_2 = 0
			local var_96_3 = 0.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(108002023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 12 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 12)

				if (12 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 12)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002023", "story_v_side_old_108002.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002023", "story_v_side_old_108002.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_side_old_108002", "108002023", "story_v_side_old_108002.awb")

						arg_93_1:RecordAudio("108002023", var_96_9)
						arg_93_1:RecordAudio("108002023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002023", "story_v_side_old_108002.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002023", "story_v_side_old_108002.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play108002024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 108002024
		arg_97_1.duration_ = 3.7

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play108002025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_100_0 = 0
			local var_100_1 = 0.375

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(108002024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 15 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 15)

				if (15 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 15)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002024", "story_v_side_old_108002.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002024", "story_v_side_old_108002.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_side_old_108002", "108002024", "story_v_side_old_108002.awb")

						arg_97_1:RecordAudio("108002024", var_100_7)
						arg_97_1:RecordAudio("108002024", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002024", "story_v_side_old_108002.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002024", "story_v_side_old_108002.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play108002025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 108002025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play108002026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1080ui_story"]) and arg_101_1.var_.characterEffect1080ui_story == nil then
				arg_101_1.var_.characterEffect1080ui_story = arg_101_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1080ui_story"]) then
				if arg_101_1.var_.characterEffect1080ui_story and not isNil(arg_101_1.actors_["1080ui_story"]) then
					arg_101_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1080ui_story"]) and arg_101_1.var_.characterEffect1080ui_story then
				arg_101_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.575

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(108002025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 23 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 23)

				if (23 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 23)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play108002026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 108002026
		arg_105_1.duration_ = 5.63

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play108002027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1080ui_story"]) and arg_105_1.var_.characterEffect1080ui_story == nil then
				arg_105_1.var_.characterEffect1080ui_story = arg_105_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1080ui_story"]) then
				if arg_105_1.var_.characterEffect1080ui_story and not isNil(arg_105_1.actors_["1080ui_story"]) then
					arg_105_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1080ui_story"]) and arg_105_1.var_.characterEffect1080ui_story then
				arg_105_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_108_2 = 0
			local var_108_3 = 0.425

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(108002026)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 17 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 17)

				if (17 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 17)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002026", "story_v_side_old_108002.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002026", "story_v_side_old_108002.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_old_108002", "108002026", "story_v_side_old_108002.awb")

						arg_105_1:RecordAudio("108002026", var_108_9)
						arg_105_1:RecordAudio("108002026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002026", "story_v_side_old_108002.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002026", "story_v_side_old_108002.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play108002027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 108002027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play108002028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1080ui_story"]) and arg_109_1.var_.characterEffect1080ui_story == nil then
				arg_109_1.var_.characterEffect1080ui_story = arg_109_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1080ui_story"]) then
				if arg_109_1.var_.characterEffect1080ui_story and not isNil(arg_109_1.actors_["1080ui_story"]) then
					arg_109_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1080ui_story"]) and arg_109_1.var_.characterEffect1080ui_story then
				arg_109_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.525

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(108002027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 21 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 21)

				if (21 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 21)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play108002028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 108002028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play108002029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1080ui_story = arg_113_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).z)
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles = arg_113_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).z)
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles = arg_113_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_116_1 = 0
			local var_116_2 = 0.575

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(108002028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 23 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 23)

				if (23 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 23)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play108002029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 108002029
		arg_117_1.duration_ = 8.23

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play108002030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1080ui_story = arg_117_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).z)
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles = arg_117_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_117_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).z)
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles = arg_117_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1080ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1080ui_story == nil then
				arg_117_1.var_.characterEffect1080ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1080ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1080ui_story then
				arg_117_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_120_4 = 0
			local var_120_5 = 0.675

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(108002029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 27 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 27)

				if (27 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 27)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002029", "story_v_side_old_108002.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002029", "story_v_side_old_108002.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_side_old_108002", "108002029", "story_v_side_old_108002.awb")

						arg_117_1:RecordAudio("108002029", var_120_11)
						arg_117_1:RecordAudio("108002029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002029", "story_v_side_old_108002.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002029", "story_v_side_old_108002.awb")
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

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play108002030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 108002030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play108002031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1080ui_story"]) and arg_121_1.var_.characterEffect1080ui_story == nil then
				arg_121_1.var_.characterEffect1080ui_story = arg_121_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1080ui_story"]) then
				if arg_121_1.var_.characterEffect1080ui_story and not isNil(arg_121_1.actors_["1080ui_story"]) then
					arg_121_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1080ui_story"]) and arg_121_1.var_.characterEffect1080ui_story then
				arg_121_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_124_1 = 0
			local var_124_2 = 0.475

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

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(108002030).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 19 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 19)

				if (19 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 19)) > 0 and var_124_2 < var_124_5 then
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

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play108002031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 108002031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play108002032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_knock", "")
			end

			local var_128_1 = 0
			local var_128_2 = 0.55

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(108002031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 22 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 22)

				if (22 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 22)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play108002032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 108002032
		arg_129_1.duration_ = 4.47

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play108002033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1080ui_story"]) and arg_129_1.var_.characterEffect1080ui_story == nil then
				arg_129_1.var_.characterEffect1080ui_story = arg_129_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1080ui_story"]) then
				if arg_129_1.var_.characterEffect1080ui_story and not isNil(arg_129_1.actors_["1080ui_story"]) then
					arg_129_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1080ui_story"]) and arg_129_1.var_.characterEffect1080ui_story then
				arg_129_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_2 = 0
			local var_132_3 = 0.25

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(108002032)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 10 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 10)

				if (10 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 10)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002032", "story_v_side_old_108002.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002032", "story_v_side_old_108002.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_side_old_108002", "108002032", "story_v_side_old_108002.awb")

						arg_129_1:RecordAudio("108002032", var_132_9)
						arg_129_1:RecordAudio("108002032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002032", "story_v_side_old_108002.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002032", "story_v_side_old_108002.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play108002033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 108002033
		arg_133_1.duration_ = 2.6

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play108002034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1080ui_story = arg_133_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1080ui_story"].transform.position).z)
				arg_133_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1080ui_story"].transform.localEulerAngles = arg_133_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_133_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1080ui_story"].transform.position).z)
				arg_133_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1080ui_story"].transform.localEulerAngles = arg_133_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_136_1 = "1039ui_story"

			if arg_133_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_136_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_133_1.stage_.transform)

				var_136_2.name = var_136_1
				var_136_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_[var_136_1] = var_136_2

				local var_136_3 = var_136_2:GetComponentInChildren(typeof(CharacterEffect))

				var_136_3.enabled = true

				local var_136_4 = GameObjectTools.GetOrAddComponent(var_136_2, typeof(DynamicBoneHelper))

				if var_136_4 then
					var_136_4:EnableDynamicBone(false)
				end

				arg_133_1:ShowWeapon(var_136_3.transform, false)

				arg_133_1.var_[var_136_1 .. "Animator"] = var_136_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_133_1.var_[var_136_1 .. "Animator"].applyRootMotion = true
				arg_133_1.var_[var_136_1 .. "LipSync"] = var_136_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_136_5 = arg_133_1.actors_["1039ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1039ui_story = var_136_5.localPosition
			end

			local var_136_6 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 then
				var_136_5.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_133_1.time_ - 0) / var_136_6)
				var_136_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_5.position).x, (manager.ui.mainCamera.transform.position - var_136_5.position).y, (manager.ui.mainCamera.transform.position - var_136_5.position).z)
				var_136_5.localEulerAngles.z = 0
				var_136_5.localEulerAngles.x = 0
				var_136_5.localEulerAngles = var_136_5.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 then
				var_136_5.localPosition = Vector3.New(0.7, -1.01, -5.9)
				var_136_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_5.position).x, (manager.ui.mainCamera.transform.position - var_136_5.position).y, (manager.ui.mainCamera.transform.position - var_136_5.position).z)
				var_136_5.localEulerAngles.z = 0
				var_136_5.localEulerAngles.x = 0
				var_136_5.localEulerAngles = var_136_5.localEulerAngles
			end

			local var_136_7 = arg_133_1.actors_["1080ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.characterEffect1080ui_story == nil then
				arg_133_1.var_.characterEffect1080ui_story = var_136_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_8 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_8 and not isNil(var_136_7) then
				if arg_133_1.var_.characterEffect1080ui_story and not isNil(var_136_7) then
					arg_133_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_8)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_8 and arg_133_1.time_ < 0 + var_136_8 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.characterEffect1080ui_story then
				arg_133_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_136_9 = arg_133_1.actors_["1039ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1039ui_story == nil then
				arg_133_1.var_.characterEffect1039ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_10 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_10 and not isNil(var_136_9) then
				if arg_133_1.var_.characterEffect1039ui_story and not isNil(var_136_9) then
					arg_133_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_10 and arg_133_1.time_ < 0 + var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1039ui_story then
				arg_133_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_136_12 = 0
			local var_136_13 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_14 = arg_133_1:GetWordFromCfg(108002033)
				local var_136_15 = arg_133_1:FormatText(var_136_14.content)

				arg_133_1.text_.text = var_136_15

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 10 <= 0 and var_136_13 or var_136_13 * (utf8.len(var_136_15) / 10)

				if (10 <= 0 and var_136_13 or var_136_13 * (utf8.len(var_136_15) / 10)) > 0 and var_136_13 < var_136_17 then
					arg_133_1.talkMaxDuration = var_136_17

					if var_136_17 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_17 + var_136_12
					end
				end

				arg_133_1.text_.text = var_136_15
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002033", "story_v_side_old_108002.awb") ~= 0 then
					local var_136_18 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002033", "story_v_side_old_108002.awb") / 1000

					if var_136_18 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_18 + var_136_12
					end

					if var_136_14.prefab_name ~= "" and arg_133_1.actors_[var_136_14.prefab_name] ~= nil then
						local var_136_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_14.prefab_name].transform, "story_v_side_old_108002", "108002033", "story_v_side_old_108002.awb")

						arg_133_1:RecordAudio("108002033", var_136_19)
						arg_133_1:RecordAudio("108002033", var_136_19)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002033", "story_v_side_old_108002.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002033", "story_v_side_old_108002.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_20 = math.max(var_136_13, arg_133_1.talkMaxDuration)

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_20 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_20

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_20 and arg_133_1.time_ < var_136_12 + var_136_20 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play108002034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 108002034
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play108002035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1080ui_story"]) and arg_137_1.var_.characterEffect1080ui_story == nil then
				arg_137_1.var_.characterEffect1080ui_story = arg_137_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1080ui_story"]) then
				if arg_137_1.var_.characterEffect1080ui_story and not isNil(arg_137_1.actors_["1080ui_story"]) then
					arg_137_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1080ui_story"]) and arg_137_1.var_.characterEffect1080ui_story then
				arg_137_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_140_2 = arg_137_1.actors_["1039ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1039ui_story == nil then
				arg_137_1.var_.characterEffect1039ui_story = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.characterEffect1039ui_story and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_3)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect1039ui_story then
				arg_137_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_2")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_4 = 0
			local var_140_5 = 0.225

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(108002034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 9 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 9)

				if (9 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 9)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002034", "story_v_side_old_108002.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002034", "story_v_side_old_108002.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_side_old_108002", "108002034", "story_v_side_old_108002.awb")

						arg_137_1:RecordAudio("108002034", var_140_11)
						arg_137_1:RecordAudio("108002034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002034", "story_v_side_old_108002.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002034", "story_v_side_old_108002.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play108002035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 108002035
		arg_141_1.duration_ = 5.6

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play108002036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1080ui_story"]) and arg_141_1.var_.characterEffect1080ui_story == nil then
				arg_141_1.var_.characterEffect1080ui_story = arg_141_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1080ui_story"]) then
				if arg_141_1.var_.characterEffect1080ui_story and not isNil(arg_141_1.actors_["1080ui_story"]) then
					arg_141_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1080ui_story"]) and arg_141_1.var_.characterEffect1080ui_story then
				arg_141_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_144_1 = arg_141_1.actors_["1039ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1039ui_story == nil then
				arg_141_1.var_.characterEffect1039ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1039ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1039ui_story then
				arg_141_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_144_4 = 0
			local var_144_5 = 0.625

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(108002035)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 25 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 25)

				if (25 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 25)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002035", "story_v_side_old_108002.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002035", "story_v_side_old_108002.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_side_old_108002", "108002035", "story_v_side_old_108002.awb")

						arg_141_1:RecordAudio("108002035", var_144_11)
						arg_141_1:RecordAudio("108002035", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002035", "story_v_side_old_108002.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002035", "story_v_side_old_108002.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play108002036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 108002036
		arg_145_1.duration_ = 9.1

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play108002037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_148_0 = 0
			local var_148_1 = 1.15

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(108002036)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 46 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 46)

				if (46 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 46)) > 0 and var_148_1 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002036", "story_v_side_old_108002.awb") ~= 0 then
					local var_148_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002036", "story_v_side_old_108002.awb") / 1000

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end

					if var_148_2.prefab_name ~= "" and arg_145_1.actors_[var_148_2.prefab_name] ~= nil then
						local var_148_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_2.prefab_name].transform, "story_v_side_old_108002", "108002036", "story_v_side_old_108002.awb")

						arg_145_1:RecordAudio("108002036", var_148_7)
						arg_145_1:RecordAudio("108002036", var_148_7)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002036", "story_v_side_old_108002.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002036", "story_v_side_old_108002.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_8 and arg_145_1.time_ < var_148_0 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play108002037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 108002037
		arg_149_1.duration_ = 6.87

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play108002038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1080ui_story"]) and arg_149_1.var_.characterEffect1080ui_story == nil then
				arg_149_1.var_.characterEffect1080ui_story = arg_149_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1080ui_story"]) then
				if arg_149_1.var_.characterEffect1080ui_story and not isNil(arg_149_1.actors_["1080ui_story"]) then
					arg_149_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1080ui_story"]) and arg_149_1.var_.characterEffect1080ui_story then
				arg_149_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["1039ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1039ui_story == nil then
				arg_149_1.var_.characterEffect1039ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1039ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1039ui_story then
				arg_149_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_4 = 0
			local var_152_5 = 0.375

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(108002037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 15 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 15)

				if (15 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 15)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002037", "story_v_side_old_108002.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002037", "story_v_side_old_108002.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_side_old_108002", "108002037", "story_v_side_old_108002.awb")

						arg_149_1:RecordAudio("108002037", var_152_11)
						arg_149_1:RecordAudio("108002037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002037", "story_v_side_old_108002.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002037", "story_v_side_old_108002.awb")
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
	Play108002038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 108002038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play108002039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1080ui_story"]) and arg_153_1.var_.characterEffect1080ui_story == nil then
				arg_153_1.var_.characterEffect1080ui_story = arg_153_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1080ui_story"]) then
				if arg_153_1.var_.characterEffect1080ui_story and not isNil(arg_153_1.actors_["1080ui_story"]) then
					arg_153_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1080ui_story"]) and arg_153_1.var_.characterEffect1080ui_story then
				arg_153_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.8

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(108002038).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 32 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 32)

				if (32 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 32)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play108002039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 108002039
		arg_157_1.duration_ = 9.97

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play108002040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) and arg_157_1.var_.characterEffect1039ui_story == nil then
				arg_157_1.var_.characterEffect1039ui_story = arg_157_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) then
				if arg_157_1.var_.characterEffect1039ui_story and not isNil(arg_157_1.actors_["1039ui_story"]) then
					arg_157_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1039ui_story"]) and arg_157_1.var_.characterEffect1039ui_story then
				arg_157_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_160_2 = 0
			local var_160_3 = 0.6

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(108002039)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 24 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 24)

				if (24 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 24)) > 0 and var_160_3 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002039", "story_v_side_old_108002.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002039", "story_v_side_old_108002.awb") / 1000

					if var_160_8 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_2
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_side_old_108002", "108002039", "story_v_side_old_108002.awb")

						arg_157_1:RecordAudio("108002039", var_160_9)
						arg_157_1:RecordAudio("108002039", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002039", "story_v_side_old_108002.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002039", "story_v_side_old_108002.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_10 and arg_157_1.time_ < var_160_2 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play108002040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 108002040
		arg_161_1.duration_ = 2

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play108002041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["1080ui_story"]) and arg_161_1.var_.characterEffect1080ui_story == nil then
				arg_161_1.var_.characterEffect1080ui_story = arg_161_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_0 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["1080ui_story"]) then
				if arg_161_1.var_.characterEffect1080ui_story and not isNil(arg_161_1.actors_["1080ui_story"]) then
					arg_161_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["1080ui_story"]) and arg_161_1.var_.characterEffect1080ui_story then
				arg_161_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_164_2 = arg_161_1.actors_["1039ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1039ui_story == nil then
				arg_161_1.var_.characterEffect1039ui_story = var_164_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_3 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_3 and not isNil(var_164_2) then
				if arg_161_1.var_.characterEffect1039ui_story and not isNil(var_164_2) then
					arg_161_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_3)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_3 and arg_161_1.time_ < 0 + var_164_3 + arg_164_0 and not isNil(var_164_2) and arg_161_1.var_.characterEffect1039ui_story then
				arg_161_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = 0
			local var_164_5 = 0.175

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(108002040)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 7 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 7)

				if (7 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 7)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002040", "story_v_side_old_108002.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002040", "story_v_side_old_108002.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_side_old_108002", "108002040", "story_v_side_old_108002.awb")

						arg_161_1:RecordAudio("108002040", var_164_11)
						arg_161_1:RecordAudio("108002040", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002040", "story_v_side_old_108002.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002040", "story_v_side_old_108002.awb")
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
	Play108002041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 108002041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play108002042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1080ui_story"]) and arg_165_1.var_.characterEffect1080ui_story == nil then
				arg_165_1.var_.characterEffect1080ui_story = arg_165_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1080ui_story"]) then
				if arg_165_1.var_.characterEffect1080ui_story and not isNil(arg_165_1.actors_["1080ui_story"]) then
					arg_165_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1080ui_story"]) and arg_165_1.var_.characterEffect1080ui_story then
				arg_165_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.5

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(108002041).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 20 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 20)

				if (20 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 20)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play108002042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 108002042
		arg_169_1.duration_ = 3.77

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play108002043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1039ui_story"]) and arg_169_1.var_.characterEffect1039ui_story == nil then
				arg_169_1.var_.characterEffect1039ui_story = arg_169_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1039ui_story"]) then
				if arg_169_1.var_.characterEffect1039ui_story and not isNil(arg_169_1.actors_["1039ui_story"]) then
					arg_169_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1039ui_story"]) and arg_169_1.var_.characterEffect1039ui_story then
				arg_169_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_172_2 = 0
			local var_172_3 = 0.425

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(108002042)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 17 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 17)

				if (17 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 17)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002042", "story_v_side_old_108002.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002042", "story_v_side_old_108002.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_side_old_108002", "108002042", "story_v_side_old_108002.awb")

						arg_169_1:RecordAudio("108002042", var_172_9)
						arg_169_1:RecordAudio("108002042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002042", "story_v_side_old_108002.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002042", "story_v_side_old_108002.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play108002043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 108002043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play108002044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1039ui_story"]) and arg_173_1.var_.characterEffect1039ui_story == nil then
				arg_173_1.var_.characterEffect1039ui_story = arg_173_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1039ui_story"]) then
				if arg_173_1.var_.characterEffect1039ui_story and not isNil(arg_173_1.actors_["1039ui_story"]) then
					arg_173_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1039ui_story"]) and arg_173_1.var_.characterEffect1039ui_story then
				arg_173_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.175

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(108002043).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 7 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 7)

				if (7 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 7)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play108002044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 108002044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play108002045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.3

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(108002044).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 12 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 12)

				if (12 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 12)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play108002045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 108002045
		arg_181_1.duration_ = 5.53

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play108002046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) and arg_181_1.var_.characterEffect1039ui_story == nil then
				arg_181_1.var_.characterEffect1039ui_story = arg_181_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) then
				if arg_181_1.var_.characterEffect1039ui_story and not isNil(arg_181_1.actors_["1039ui_story"]) then
					arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1039ui_story"]) and arg_181_1.var_.characterEffect1039ui_story then
				arg_181_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_184_2 = 0
			local var_184_3 = 0.5

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(108002045)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 20 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 20)

				if (20 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 20)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002045", "story_v_side_old_108002.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002045", "story_v_side_old_108002.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_side_old_108002", "108002045", "story_v_side_old_108002.awb")

						arg_181_1:RecordAudio("108002045", var_184_9)
						arg_181_1:RecordAudio("108002045", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002045", "story_v_side_old_108002.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002045", "story_v_side_old_108002.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play108002046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 108002046
		arg_185_1.duration_ = 1

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"

			SetActive(arg_185_1.choicesGo_, true)

			for iter_186_0, iter_186_1 in ipairs(arg_185_1.choices_) do
				SetActive(iter_186_1.go, iter_186_0 <= 2)
			end

			arg_185_1.choices_[1].txt.text = arg_185_1:FormatText(StoryChoiceCfg[314].name)
			arg_185_1.choices_[2].txt.text = arg_185_1:FormatText(StoryChoiceCfg[315].name)
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play108002048(arg_185_1)
			end

			if arg_187_0 == 2 then
				arg_185_0:Play108002047(arg_185_1)
			end

			arg_185_1:RecordChoiceLog(108002046, 314, 315)
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1039ui_story"]) and arg_185_1.var_.characterEffect1039ui_story == nil then
				arg_185_1.var_.characterEffect1039ui_story = arg_185_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1039ui_story"]) then
				if arg_185_1.var_.characterEffect1039ui_story and not isNil(arg_185_1.actors_["1039ui_story"]) then
					arg_185_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1039ui_story"]) and arg_185_1.var_.characterEffect1039ui_story then
				arg_185_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play108002048 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 108002048
		arg_189_1.duration_ = 8.2

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play108002049(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1039ui_story"]) and arg_189_1.var_.characterEffect1039ui_story == nil then
				arg_189_1.var_.characterEffect1039ui_story = arg_189_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1039ui_story"]) then
				if arg_189_1.var_.characterEffect1039ui_story and not isNil(arg_189_1.actors_["1039ui_story"]) then
					arg_189_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1039ui_story"]) and arg_189_1.var_.characterEffect1039ui_story then
				arg_189_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_192_2 = 0
			local var_192_3 = 1.15

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_4 = arg_189_1:GetWordFromCfg(108002048)
				local var_192_5 = arg_189_1:FormatText(var_192_4.content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 46 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 46)

				if (46 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 46)) > 0 and var_192_3 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002048", "story_v_side_old_108002.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002048", "story_v_side_old_108002.awb") / 1000

					if var_192_8 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_2
					end

					if var_192_4.prefab_name ~= "" and arg_189_1.actors_[var_192_4.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_4.prefab_name].transform, "story_v_side_old_108002", "108002048", "story_v_side_old_108002.awb")

						arg_189_1:RecordAudio("108002048", var_192_9)
						arg_189_1:RecordAudio("108002048", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002048", "story_v_side_old_108002.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002048", "story_v_side_old_108002.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_10 and arg_189_1.time_ < var_192_2 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play108002049 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 108002049
		arg_193_1.duration_ = 2

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play108002050(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1080ui_story"]) and arg_193_1.var_.characterEffect1080ui_story == nil then
				arg_193_1.var_.characterEffect1080ui_story = arg_193_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1080ui_story"]) then
				if arg_193_1.var_.characterEffect1080ui_story and not isNil(arg_193_1.actors_["1080ui_story"]) then
					arg_193_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1080ui_story"]) and arg_193_1.var_.characterEffect1080ui_story then
				arg_193_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_2")
			end

			local var_196_2 = arg_193_1.actors_["1039ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1039ui_story == nil then
				arg_193_1.var_.characterEffect1039ui_story = var_196_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_3 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.characterEffect1039ui_story and not isNil(var_196_2) then
					arg_193_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_3)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.characterEffect1039ui_story then
				arg_193_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_196_4 = 0
			local var_196_5 = 0.15

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(108002049)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 6 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 6)

				if (6 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 6)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002049", "story_v_side_old_108002.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002049", "story_v_side_old_108002.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_side_old_108002", "108002049", "story_v_side_old_108002.awb")

						arg_193_1:RecordAudio("108002049", var_196_11)
						arg_193_1:RecordAudio("108002049", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002049", "story_v_side_old_108002.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002049", "story_v_side_old_108002.awb")
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
	Play108002050 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 108002050
		arg_197_1.duration_ = 9.73

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play108002051(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1039ui_story"]) and arg_197_1.var_.characterEffect1039ui_story == nil then
				arg_197_1.var_.characterEffect1039ui_story = arg_197_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1039ui_story"]) then
				if arg_197_1.var_.characterEffect1039ui_story and not isNil(arg_197_1.actors_["1039ui_story"]) then
					arg_197_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1039ui_story"]) and arg_197_1.var_.characterEffect1039ui_story then
				arg_197_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			local var_200_2 = arg_197_1.actors_["1080ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect1080ui_story == nil then
				arg_197_1.var_.characterEffect1080ui_story = var_200_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.characterEffect1080ui_story and not isNil(var_200_2) then
					arg_197_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_3)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect1080ui_story then
				arg_197_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_200_4 = 0
			local var_200_5 = 0.75

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:GetWordFromCfg(108002050)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.text_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_9 = 30 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 30)

				if (30 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_7) / 30)) > 0 and var_200_5 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_7
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002050", "story_v_side_old_108002.awb") ~= 0 then
					local var_200_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002050", "story_v_side_old_108002.awb") / 1000

					if var_200_10 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_4
					end

					if var_200_6.prefab_name ~= "" and arg_197_1.actors_[var_200_6.prefab_name] ~= nil then
						local var_200_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_6.prefab_name].transform, "story_v_side_old_108002", "108002050", "story_v_side_old_108002.awb")

						arg_197_1:RecordAudio("108002050", var_200_11)
						arg_197_1:RecordAudio("108002050", var_200_11)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002050", "story_v_side_old_108002.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002050", "story_v_side_old_108002.awb")
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
	Play108002051 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 108002051
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play108002052(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1039ui_story"]) and arg_201_1.var_.characterEffect1039ui_story == nil then
				arg_201_1.var_.characterEffect1039ui_story = arg_201_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1039ui_story"]) then
				if arg_201_1.var_.characterEffect1039ui_story and not isNil(arg_201_1.actors_["1039ui_story"]) then
					arg_201_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1039ui_story"]) and arg_201_1.var_.characterEffect1039ui_story then
				arg_201_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.475

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(108002051).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 16 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 16)

				if (16 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 16)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play108002052 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 108002052
		arg_205_1.duration_ = 2.4

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play108002053(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1080ui_story"]) and arg_205_1.var_.characterEffect1080ui_story == nil then
				arg_205_1.var_.characterEffect1080ui_story = arg_205_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1080ui_story"]) then
				if arg_205_1.var_.characterEffect1080ui_story and not isNil(arg_205_1.actors_["1080ui_story"]) then
					arg_205_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1080ui_story"]) and arg_205_1.var_.characterEffect1080ui_story then
				arg_205_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_208_2 = 0
			local var_208_3 = 0.125

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:GetWordFromCfg(108002052)
				local var_208_5 = arg_205_1:FormatText(var_208_4.content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 5 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 5)

				if (5 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_5) / 5)) > 0 and var_208_3 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002052", "story_v_side_old_108002.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002052", "story_v_side_old_108002.awb") / 1000

					if var_208_8 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_2
					end

					if var_208_4.prefab_name ~= "" and arg_205_1.actors_[var_208_4.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_4.prefab_name].transform, "story_v_side_old_108002", "108002052", "story_v_side_old_108002.awb")

						arg_205_1:RecordAudio("108002052", var_208_9)
						arg_205_1:RecordAudio("108002052", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002052", "story_v_side_old_108002.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002052", "story_v_side_old_108002.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_10 and arg_205_1.time_ < var_208_2 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play108002053 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 108002053
		arg_209_1.duration_ = 3.8

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play108002054(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.225

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(108002053)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 9 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 9)

				if (9 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 9)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002053", "story_v_side_old_108002.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002053", "story_v_side_old_108002.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_side_old_108002", "108002053", "story_v_side_old_108002.awb")

						arg_209_1:RecordAudio("108002053", var_212_6)
						arg_209_1:RecordAudio("108002053", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002053", "story_v_side_old_108002.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002053", "story_v_side_old_108002.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play108002054 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 108002054
		arg_213_1.duration_ = 2.3

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play108002055(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.05

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(108002054)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 2 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 2)

				if (2 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 2)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002054", "story_v_side_old_108002.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002054", "story_v_side_old_108002.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_side_old_108002", "108002054", "story_v_side_old_108002.awb")

						arg_213_1:RecordAudio("108002054", var_216_6)
						arg_213_1:RecordAudio("108002054", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002054", "story_v_side_old_108002.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002054", "story_v_side_old_108002.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play108002055 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 108002055
		arg_217_1.duration_ = 2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play108002056(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			local var_220_0 = 0
			local var_220_1 = 0.3

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(108002055)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 12 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 12)

				if (12 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 12)) > 0 and var_220_1 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002055", "story_v_side_old_108002.awb") ~= 0 then
					local var_220_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002055", "story_v_side_old_108002.awb") / 1000

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end

					if var_220_2.prefab_name ~= "" and arg_217_1.actors_[var_220_2.prefab_name] ~= nil then
						local var_220_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_2.prefab_name].transform, "story_v_side_old_108002", "108002055", "story_v_side_old_108002.awb")

						arg_217_1:RecordAudio("108002055", var_220_7)
						arg_217_1:RecordAudio("108002055", var_220_7)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002055", "story_v_side_old_108002.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002055", "story_v_side_old_108002.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play108002056 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 108002056
		arg_221_1.duration_ = 4.17

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play108002057(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1039ui_story"]) and arg_221_1.var_.characterEffect1039ui_story == nil then
				arg_221_1.var_.characterEffect1039ui_story = arg_221_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1039ui_story"]) then
				if arg_221_1.var_.characterEffect1039ui_story and not isNil(arg_221_1.actors_["1039ui_story"]) then
					arg_221_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1039ui_story"]) and arg_221_1.var_.characterEffect1039ui_story then
				arg_221_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action442")
			end

			local var_224_2 = arg_221_1.actors_["1080ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect1080ui_story == nil then
				arg_221_1.var_.characterEffect1080ui_story = var_224_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_3 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.characterEffect1080ui_story and not isNil(var_224_2) then
					arg_221_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_3)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.characterEffect1080ui_story then
				arg_221_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_224_4 = 0
			local var_224_5 = 0.55

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(108002056)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 22 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 22)

				if (22 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 22)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002056", "story_v_side_old_108002.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002056", "story_v_side_old_108002.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_side_old_108002", "108002056", "story_v_side_old_108002.awb")

						arg_221_1:RecordAudio("108002056", var_224_11)
						arg_221_1:RecordAudio("108002056", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002056", "story_v_side_old_108002.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002056", "story_v_side_old_108002.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play108002057 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 108002057
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play108002058(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1039ui_story"]) and arg_225_1.var_.characterEffect1039ui_story == nil then
				arg_225_1.var_.characterEffect1039ui_story = arg_225_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1039ui_story"]) then
				if arg_225_1.var_.characterEffect1039ui_story and not isNil(arg_225_1.actors_["1039ui_story"]) then
					arg_225_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1039ui_story"]) and arg_225_1.var_.characterEffect1039ui_story then
				arg_225_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_228_1 = 0
			local var_228_2 = 0.175

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(108002057).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 7 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 7)

				if (7 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 7)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play108002058 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 108002058
		arg_229_1.duration_ = 8.47

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play108002059(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1039ui_story"]) and arg_229_1.var_.characterEffect1039ui_story == nil then
				arg_229_1.var_.characterEffect1039ui_story = arg_229_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1039ui_story"]) then
				if arg_229_1.var_.characterEffect1039ui_story and not isNil(arg_229_1.actors_["1039ui_story"]) then
					arg_229_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1039ui_story"]) and arg_229_1.var_.characterEffect1039ui_story then
				arg_229_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			local var_232_2 = 0
			local var_232_3 = 1.125

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(108002058)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 45 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 45)

				if (45 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 45)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002058", "story_v_side_old_108002.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002058", "story_v_side_old_108002.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_side_old_108002", "108002058", "story_v_side_old_108002.awb")

						arg_229_1:RecordAudio("108002058", var_232_9)
						arg_229_1:RecordAudio("108002058", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002058", "story_v_side_old_108002.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002058", "story_v_side_old_108002.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_10 and arg_229_1.time_ < var_232_2 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play108002059 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 108002059
		arg_233_1.duration_ = 2.67

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play108002060(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1080ui_story"]) and arg_233_1.var_.characterEffect1080ui_story == nil then
				arg_233_1.var_.characterEffect1080ui_story = arg_233_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1080ui_story"]) then
				if arg_233_1.var_.characterEffect1080ui_story and not isNil(arg_233_1.actors_["1080ui_story"]) then
					arg_233_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1080ui_story"]) and arg_233_1.var_.characterEffect1080ui_story then
				arg_233_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_236_2 = arg_233_1.actors_["1039ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1039ui_story == nil then
				arg_233_1.var_.characterEffect1039ui_story = var_236_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_3 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.characterEffect1039ui_story and not isNil(var_236_2) then
					arg_233_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_3)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1039ui_story then
				arg_233_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			local var_236_4 = 0
			local var_236_5 = 0.225

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(108002059)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 9 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 9)

				if (9 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 9)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002059", "story_v_side_old_108002.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002059", "story_v_side_old_108002.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_side_old_108002", "108002059", "story_v_side_old_108002.awb")

						arg_233_1:RecordAudio("108002059", var_236_11)
						arg_233_1:RecordAudio("108002059", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002059", "story_v_side_old_108002.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002059", "story_v_side_old_108002.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play108002060 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 108002060
		arg_237_1.duration_ = 12.9

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play108002061(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1080ui_story"]) and arg_237_1.var_.characterEffect1080ui_story == nil then
				arg_237_1.var_.characterEffect1080ui_story = arg_237_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1080ui_story"]) then
				if arg_237_1.var_.characterEffect1080ui_story and not isNil(arg_237_1.actors_["1080ui_story"]) then
					arg_237_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1080ui_story"]) and arg_237_1.var_.characterEffect1080ui_story then
				arg_237_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_240_1 = arg_237_1.actors_["1039ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1039ui_story == nil then
				arg_237_1.var_.characterEffect1039ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1039ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1039ui_story then
				arg_237_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_240_4 = 0
			local var_240_5 = 0.975

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(108002060)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 39 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 39)

				if (39 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 39)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002060", "story_v_side_old_108002.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002060", "story_v_side_old_108002.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_side_old_108002", "108002060", "story_v_side_old_108002.awb")

						arg_237_1:RecordAudio("108002060", var_240_11)
						arg_237_1:RecordAudio("108002060", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002060", "story_v_side_old_108002.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002060", "story_v_side_old_108002.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play108002061 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 108002061
		arg_241_1.duration_ = 6.37

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play108002062(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1080ui_story"]) and arg_241_1.var_.characterEffect1080ui_story == nil then
				arg_241_1.var_.characterEffect1080ui_story = arg_241_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1080ui_story"]) then
				if arg_241_1.var_.characterEffect1080ui_story and not isNil(arg_241_1.actors_["1080ui_story"]) then
					arg_241_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1080ui_story"]) and arg_241_1.var_.characterEffect1080ui_story then
				arg_241_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_244_2 = arg_241_1.actors_["1039ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1039ui_story == nil then
				arg_241_1.var_.characterEffect1039ui_story = var_244_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_3 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.characterEffect1039ui_story and not isNil(var_244_2) then
					arg_241_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_3)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect1039ui_story then
				arg_241_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action4_1")
			end

			local var_244_4 = 0
			local var_244_5 = 0.575

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(108002061)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 23 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 23)

				if (23 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 23)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002061", "story_v_side_old_108002.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002061", "story_v_side_old_108002.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_side_old_108002", "108002061", "story_v_side_old_108002.awb")

						arg_241_1:RecordAudio("108002061", var_244_11)
						arg_241_1:RecordAudio("108002061", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002061", "story_v_side_old_108002.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002061", "story_v_side_old_108002.awb")
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
	Play108002062 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 108002062
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play108002063(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1080ui_story"]) and arg_245_1.var_.characterEffect1080ui_story == nil then
				arg_245_1.var_.characterEffect1080ui_story = arg_245_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1080ui_story"]) then
				if arg_245_1.var_.characterEffect1080ui_story and not isNil(arg_245_1.actors_["1080ui_story"]) then
					arg_245_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1080ui_story"]) and arg_245_1.var_.characterEffect1080ui_story then
				arg_245_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.375

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(108002062).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 15 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 15)

				if (15 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 15)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play108002063 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 108002063
		arg_249_1.duration_ = 4.57

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play108002064(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1080ui_story"]) and arg_249_1.var_.characterEffect1080ui_story == nil then
				arg_249_1.var_.characterEffect1080ui_story = arg_249_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1080ui_story"]) then
				if arg_249_1.var_.characterEffect1080ui_story and not isNil(arg_249_1.actors_["1080ui_story"]) then
					arg_249_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1080ui_story"]) and arg_249_1.var_.characterEffect1080ui_story then
				arg_249_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_252_2 = 0
			local var_252_3 = 0.3

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(108002063)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 12 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 12)

				if (12 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 12)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002063", "story_v_side_old_108002.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002063", "story_v_side_old_108002.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_side_old_108002", "108002063", "story_v_side_old_108002.awb")

						arg_249_1:RecordAudio("108002063", var_252_9)
						arg_249_1:RecordAudio("108002063", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002063", "story_v_side_old_108002.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002063", "story_v_side_old_108002.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play108002064 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 108002064
		arg_253_1.duration_ = 5.37

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play108002065(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1080ui_story"]) and arg_253_1.var_.characterEffect1080ui_story == nil then
				arg_253_1.var_.characterEffect1080ui_story = arg_253_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1080ui_story"]) then
				if arg_253_1.var_.characterEffect1080ui_story and not isNil(arg_253_1.actors_["1080ui_story"]) then
					arg_253_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1080ui_story"]) and arg_253_1.var_.characterEffect1080ui_story then
				arg_253_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_256_1 = arg_253_1.actors_["1039ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1039ui_story == nil then
				arg_253_1.var_.characterEffect1039ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1039ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1039ui_story then
				arg_253_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			local var_256_4 = 0
			local var_256_5 = 0.4

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(108002064)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 16 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 16)

				if (16 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 16)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002064", "story_v_side_old_108002.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002064", "story_v_side_old_108002.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_side_old_108002", "108002064", "story_v_side_old_108002.awb")

						arg_253_1:RecordAudio("108002064", var_256_11)
						arg_253_1:RecordAudio("108002064", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002064", "story_v_side_old_108002.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002064", "story_v_side_old_108002.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play108002065 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 108002065
		arg_257_1.duration_ = 2

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play108002066(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1080ui_story"]) and arg_257_1.var_.characterEffect1080ui_story == nil then
				arg_257_1.var_.characterEffect1080ui_story = arg_257_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1080ui_story"]) then
				if arg_257_1.var_.characterEffect1080ui_story and not isNil(arg_257_1.actors_["1080ui_story"]) then
					arg_257_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1080ui_story"]) and arg_257_1.var_.characterEffect1080ui_story then
				arg_257_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_260_2 = arg_257_1.actors_["1039ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1039ui_story == nil then
				arg_257_1.var_.characterEffect1039ui_story = var_260_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_3 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.characterEffect1039ui_story and not isNil(var_260_2) then
					arg_257_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_3)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1039ui_story then
				arg_257_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action446")
			end

			local var_260_4 = 0
			local var_260_5 = 0.175

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(108002065)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 7 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 7)

				if (7 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 7)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002065", "story_v_side_old_108002.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002065", "story_v_side_old_108002.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_side_old_108002", "108002065", "story_v_side_old_108002.awb")

						arg_257_1:RecordAudio("108002065", var_260_11)
						arg_257_1:RecordAudio("108002065", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002065", "story_v_side_old_108002.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002065", "story_v_side_old_108002.awb")
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
	Play108002066 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 108002066
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play108002067(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1080ui_story"]) and arg_261_1.var_.characterEffect1080ui_story == nil then
				arg_261_1.var_.characterEffect1080ui_story = arg_261_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1080ui_story"]) then
				if arg_261_1.var_.characterEffect1080ui_story and not isNil(arg_261_1.actors_["1080ui_story"]) then
					arg_261_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1080ui_story"]) and arg_261_1.var_.characterEffect1080ui_story then
				arg_261_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 1.05

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(108002066).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 42 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 42)

				if (42 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 42)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play108002067 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 108002067
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play108002068(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.4

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(108002067).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 16 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 16)

				if (16 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 16)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play108002068 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 108002068
		arg_269_1.duration_ = 2.87

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play108002069(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1039ui_story"]) and arg_269_1.var_.characterEffect1039ui_story == nil then
				arg_269_1.var_.characterEffect1039ui_story = arg_269_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1039ui_story"]) then
				if arg_269_1.var_.characterEffect1039ui_story and not isNil(arg_269_1.actors_["1039ui_story"]) then
					arg_269_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1039ui_story"]) and arg_269_1.var_.characterEffect1039ui_story then
				arg_269_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action452")
			end

			local var_272_2 = 0
			local var_272_3 = 0.225

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_4 = arg_269_1:GetWordFromCfg(108002068)
				local var_272_5 = arg_269_1:FormatText(var_272_4.content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 9 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 9)

				if (9 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 9)) > 0 and var_272_3 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002068", "story_v_side_old_108002.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002068", "story_v_side_old_108002.awb") / 1000

					if var_272_8 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_2
					end

					if var_272_4.prefab_name ~= "" and arg_269_1.actors_[var_272_4.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_4.prefab_name].transform, "story_v_side_old_108002", "108002068", "story_v_side_old_108002.awb")

						arg_269_1:RecordAudio("108002068", var_272_9)
						arg_269_1:RecordAudio("108002068", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002068", "story_v_side_old_108002.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002068", "story_v_side_old_108002.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_10 and arg_269_1.time_ < var_272_2 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play108002069 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 108002069
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play108002070(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1039ui_story"]) and arg_273_1.var_.characterEffect1039ui_story == nil then
				arg_273_1.var_.characterEffect1039ui_story = arg_273_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1039ui_story"]) then
				if arg_273_1.var_.characterEffect1039ui_story and not isNil(arg_273_1.actors_["1039ui_story"]) then
					arg_273_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1039ui_story"]) and arg_273_1.var_.characterEffect1039ui_story then
				arg_273_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.5

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(108002069).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 20 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 20)

				if (20 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 20)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play108002070 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 108002070
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play108002071(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.9

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(108002070).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 36 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 36)

				if (36 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 36)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play108002071 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 108002071
		arg_281_1.duration_ = 5.7

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play108002072(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1080ui_story"]) and arg_281_1.var_.characterEffect1080ui_story == nil then
				arg_281_1.var_.characterEffect1080ui_story = arg_281_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1080ui_story"]) then
				if arg_281_1.var_.characterEffect1080ui_story and not isNil(arg_281_1.actors_["1080ui_story"]) then
					arg_281_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1080ui_story"]) and arg_281_1.var_.characterEffect1080ui_story then
				arg_281_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action462")
			end

			local var_284_2 = 0
			local var_284_3 = 0.425

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_4 = arg_281_1:GetWordFromCfg(108002071)
				local var_284_5 = arg_281_1:FormatText(var_284_4.content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 17 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 17)

				if (17 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 17)) > 0 and var_284_3 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002071", "story_v_side_old_108002.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002071", "story_v_side_old_108002.awb") / 1000

					if var_284_8 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_2
					end

					if var_284_4.prefab_name ~= "" and arg_281_1.actors_[var_284_4.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_4.prefab_name].transform, "story_v_side_old_108002", "108002071", "story_v_side_old_108002.awb")

						arg_281_1:RecordAudio("108002071", var_284_9)
						arg_281_1:RecordAudio("108002071", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002071", "story_v_side_old_108002.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002071", "story_v_side_old_108002.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_10 and arg_281_1.time_ < var_284_2 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play108002072 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 108002072
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play108002073(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1080ui_story"]) and arg_285_1.var_.characterEffect1080ui_story == nil then
				arg_285_1.var_.characterEffect1080ui_story = arg_285_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1080ui_story"]) then
				if arg_285_1.var_.characterEffect1080ui_story and not isNil(arg_285_1.actors_["1080ui_story"]) then
					arg_285_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1080ui_story"]) and arg_285_1.var_.characterEffect1080ui_story then
				arg_285_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.325

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(108002072).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 13 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 13)

				if (13 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 13)) > 0 and var_288_2 < var_288_5 then
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

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play108002073 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 108002073
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play108002074(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.825

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(108002073).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 33 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 33)

				if (33 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 33)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play108002074 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 108002074
		arg_293_1.duration_ = 15.07

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play108002075(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1039ui_story"]) and arg_293_1.var_.characterEffect1039ui_story == nil then
				arg_293_1.var_.characterEffect1039ui_story = arg_293_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1039ui_story"]) then
				if arg_293_1.var_.characterEffect1039ui_story and not isNil(arg_293_1.actors_["1039ui_story"]) then
					arg_293_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1039ui_story"]) and arg_293_1.var_.characterEffect1039ui_story then
				arg_293_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			local var_296_2 = 0
			local var_296_3 = 1.15

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(108002074)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 46 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 46)

				if (46 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 46)) > 0 and var_296_3 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002074", "story_v_side_old_108002.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002074", "story_v_side_old_108002.awb") / 1000

					if var_296_8 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_2
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_side_old_108002", "108002074", "story_v_side_old_108002.awb")

						arg_293_1:RecordAudio("108002074", var_296_9)
						arg_293_1:RecordAudio("108002074", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002074", "story_v_side_old_108002.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002074", "story_v_side_old_108002.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_10 and arg_293_1.time_ < var_296_2 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play108002075 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 108002075
		arg_297_1.duration_ = 9

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play108002076(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if arg_297_1.bgs_.ST14 == nil then
				local var_300_0 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST14")
				var_300_0.name = "ST14"
				var_300_0.transform.parent = arg_297_1.stage_.transform
				var_300_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_.ST14 = var_300_0
			end

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= 2 + arg_300_0 then
				local var_300_1 = arg_297_1.bgs_.ST14

				arg_297_1.bgs_.ST14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_2 = var_300_1:GetComponent("SpriteRenderer")

				if var_300_2 and var_300_2.sprite then
					local var_300_3 = 2 * (var_300_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_1.transform.localScale = Vector3.New(var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "ST14" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_4 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = false

				arg_297_1:SetGaussion(false)
			end

			local var_300_5 = 2

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_5 then
				local var_300_6 = Color.New(0, 0, 0)

				var_300_6.a = Mathf.Lerp(0, 1, (arg_297_1.time_ - var_300_4) / var_300_5)
				arg_297_1.mask_.color = var_300_6
			end

			if arg_297_1.time_ >= var_300_4 + var_300_5 and arg_297_1.time_ < var_300_4 + var_300_5 + arg_300_0 then
				local var_300_7 = Color.New(0, 0, 0)

				var_300_7.a = 1
				arg_297_1.mask_.color = var_300_7
			end

			local var_300_8 = 2

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = false

				arg_297_1:SetGaussion(false)
			end

			local var_300_9 = 2

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 then
				local var_300_10 = Color.New(0, 0, 0)

				var_300_10.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_8) / var_300_9)
				arg_297_1.mask_.color = var_300_10
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 then
				local var_300_11 = Color.New(0, 0, 0)

				arg_297_1.mask_.enabled = false
				var_300_11.a = 0
				arg_297_1.mask_.color = var_300_11
			end

			local var_300_12 = arg_297_1.actors_["1080ui_story"].transform

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= 2 + arg_300_0 then
				arg_297_1.var_.moveOldPos1080ui_story = var_300_12.localPosition
			end

			local var_300_13 = 0.001

			if 2 <= arg_297_1.time_ and arg_297_1.time_ < 2 + var_300_13 then
				var_300_12.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 2) / var_300_13)
				var_300_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_12.position).x, (manager.ui.mainCamera.transform.position - var_300_12.position).y, (manager.ui.mainCamera.transform.position - var_300_12.position).z)
				var_300_12.localEulerAngles.z = 0
				var_300_12.localEulerAngles.x = 0
				var_300_12.localEulerAngles = var_300_12.localEulerAngles
			end

			if arg_297_1.time_ >= 2 + var_300_13 and arg_297_1.time_ < 2 + var_300_13 + arg_300_0 then
				var_300_12.localPosition = Vector3.New(0, 100, 0)
				var_300_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_12.position).x, (manager.ui.mainCamera.transform.position - var_300_12.position).y, (manager.ui.mainCamera.transform.position - var_300_12.position).z)
				var_300_12.localEulerAngles.z = 0
				var_300_12.localEulerAngles.x = 0
				var_300_12.localEulerAngles = var_300_12.localEulerAngles
			end

			local var_300_14 = arg_297_1.actors_["1039ui_story"].transform

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= 2 + arg_300_0 then
				arg_297_1.var_.moveOldPos1039ui_story = var_300_14.localPosition
			end

			local var_300_15 = 0.001

			if 2 <= arg_297_1.time_ and arg_297_1.time_ < 2 + var_300_15 then
				var_300_14.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 2) / var_300_15)
				var_300_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_14.position).x, (manager.ui.mainCamera.transform.position - var_300_14.position).y, (manager.ui.mainCamera.transform.position - var_300_14.position).z)
				var_300_14.localEulerAngles.z = 0
				var_300_14.localEulerAngles.x = 0
				var_300_14.localEulerAngles = var_300_14.localEulerAngles
			end

			if arg_297_1.time_ >= 2 + var_300_15 and arg_297_1.time_ < 2 + var_300_15 + arg_300_0 then
				var_300_14.localPosition = Vector3.New(0, 100, 0)
				var_300_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_14.position).x, (manager.ui.mainCamera.transform.position - var_300_14.position).y, (manager.ui.mainCamera.transform.position - var_300_14.position).z)
				var_300_14.localEulerAngles.z = 0
				var_300_14.localEulerAngles.x = 0
				var_300_14.localEulerAngles = var_300_14.localEulerAngles
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_16 = 4
			local var_300_17 = 1

			if 4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_18 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_18:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_19 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(108002075).content)

				arg_297_1.text_.text = var_300_19

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_21 = 40 <= 0 and var_300_17 or var_300_17 * (utf8.len(var_300_19) / 40)

				if (40 <= 0 and var_300_17 or var_300_17 * (utf8.len(var_300_19) / 40)) > 0 and var_300_17 < var_300_21 then
					arg_297_1.talkMaxDuration = var_300_21
					var_300_16 = var_300_16 + 0.3

					if var_300_21 + var_300_16 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_21 + var_300_16
					end
				end

				arg_297_1.text_.text = var_300_19
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_22 = var_300_16 + 0.3
			local var_300_23 = math.max(var_300_17, arg_297_1.talkMaxDuration)

			if var_300_16 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_22 + var_300_23 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_22) / var_300_23

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_22 + var_300_23 and arg_297_1.time_ < var_300_22 + var_300_23 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play108002076 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 108002076
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play108002077(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(108002076).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 40 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 40)

				if (40 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 40)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play108002077 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 108002077
		arg_307_1.duration_ = 2.47

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play108002078(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1080ui_story = arg_307_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1080ui_story"].transform.position).z)
				arg_307_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1080ui_story"].transform.localEulerAngles = arg_307_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_307_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1080ui_story"].transform.position).z)
				arg_307_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1080ui_story"].transform.localEulerAngles = arg_307_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1080ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1080ui_story == nil then
				arg_307_1.var_.characterEffect1080ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect1080ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1080ui_story then
				arg_307_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_310_4 = 0
			local var_310_5 = 0.25

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(108002077)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 10 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 10)

				if (10 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 10)) > 0 and var_310_5 < var_310_9 then
					arg_307_1.talkMaxDuration = var_310_9

					if var_310_9 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002077", "story_v_side_old_108002.awb") ~= 0 then
					local var_310_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002077", "story_v_side_old_108002.awb") / 1000

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end

					if var_310_6.prefab_name ~= "" and arg_307_1.actors_[var_310_6.prefab_name] ~= nil then
						local var_310_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_6.prefab_name].transform, "story_v_side_old_108002", "108002077", "story_v_side_old_108002.awb")

						arg_307_1:RecordAudio("108002077", var_310_11)
						arg_307_1:RecordAudio("108002077", var_310_11)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002077", "story_v_side_old_108002.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002077", "story_v_side_old_108002.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_12 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_12 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_12

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_12 and arg_307_1.time_ < var_310_4 + var_310_12 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play108002078 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 108002078
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play108002079(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1080ui_story"]) and arg_311_1.var_.characterEffect1080ui_story == nil then
				arg_311_1.var_.characterEffect1080ui_story = arg_311_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1080ui_story"]) then
				if arg_311_1.var_.characterEffect1080ui_story and not isNil(arg_311_1.actors_["1080ui_story"]) then
					arg_311_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1080ui_story"]) and arg_311_1.var_.characterEffect1080ui_story then
				arg_311_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.225

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(108002078).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 9 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 9)

				if (9 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 9)) > 0 and var_314_2 < var_314_5 then
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
	Play108002079 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 108002079
		arg_315_1.duration_ = 7.53

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play108002080(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1080ui_story"]) and arg_315_1.var_.characterEffect1080ui_story == nil then
				arg_315_1.var_.characterEffect1080ui_story = arg_315_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1080ui_story"]) then
				if arg_315_1.var_.characterEffect1080ui_story and not isNil(arg_315_1.actors_["1080ui_story"]) then
					arg_315_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1080ui_story"]) and arg_315_1.var_.characterEffect1080ui_story then
				arg_315_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_318_2 = 0
			local var_318_3 = 0.625

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(108002079)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 25 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 25)

				if (25 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 25)) > 0 and var_318_3 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002079", "story_v_side_old_108002.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002079", "story_v_side_old_108002.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_side_old_108002", "108002079", "story_v_side_old_108002.awb")

						arg_315_1:RecordAudio("108002079", var_318_9)
						arg_315_1:RecordAudio("108002079", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002079", "story_v_side_old_108002.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002079", "story_v_side_old_108002.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_3, arg_315_1.talkMaxDuration)

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_2) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_2 + var_318_10 and arg_315_1.time_ < var_318_2 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play108002080 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 108002080
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play108002081(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1080ui_story"]) and arg_319_1.var_.characterEffect1080ui_story == nil then
				arg_319_1.var_.characterEffect1080ui_story = arg_319_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1080ui_story"]) then
				if arg_319_1.var_.characterEffect1080ui_story and not isNil(arg_319_1.actors_["1080ui_story"]) then
					arg_319_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1080ui_story"]) and arg_319_1.var_.characterEffect1080ui_story then
				arg_319_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 0.725

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(108002080).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 29 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 29)

				if (29 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 29)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play108002081 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 108002081
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play108002082(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_326_0 = 0
			local var_326_1 = 0.55

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_2 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(108002081).content)

				arg_323_1.text_.text = var_326_2

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_4 = 22 <= 0 and var_326_1 or var_326_1 * (utf8.len(var_326_2) / 22)

				if (22 <= 0 and var_326_1 or var_326_1 * (utf8.len(var_326_2) / 22)) > 0 and var_326_1 < var_326_4 then
					arg_323_1.talkMaxDuration = var_326_4

					if var_326_4 + var_326_0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_4 + var_326_0
					end
				end

				arg_323_1.text_.text = var_326_2
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_5 = math.max(var_326_1, arg_323_1.talkMaxDuration)

			if var_326_0 <= arg_323_1.time_ and arg_323_1.time_ < var_326_0 + var_326_5 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_0) / var_326_5

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_0 + var_326_5 and arg_323_1.time_ < var_326_0 + var_326_5 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play108002082 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 108002082
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play108002083(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.45

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_1 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(108002082).content)

				arg_327_1.text_.text = var_330_1

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_3 = 18 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 18)

				if (18 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 18)) > 0 and var_330_0 < var_330_3 then
					arg_327_1.talkMaxDuration = var_330_3

					if var_330_3 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_3 + 0
					end
				end

				arg_327_1.text_.text = var_330_1
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_4 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_4

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play108002083 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 108002083
		arg_331_1.duration_ = 4.27

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play108002084(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1080ui_story"]) and arg_331_1.var_.characterEffect1080ui_story == nil then
				arg_331_1.var_.characterEffect1080ui_story = arg_331_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1080ui_story"]) then
				if arg_331_1.var_.characterEffect1080ui_story and not isNil(arg_331_1.actors_["1080ui_story"]) then
					arg_331_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1080ui_story"]) and arg_331_1.var_.characterEffect1080ui_story then
				arg_331_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_334_2 = 0
			local var_334_3 = 0.325

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_2 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_4 = arg_331_1:GetWordFromCfg(108002083)
				local var_334_5 = arg_331_1:FormatText(var_334_4.content)

				arg_331_1.text_.text = var_334_5

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_7 = 13 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 13)

				if (13 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 13)) > 0 and var_334_3 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_2
					end
				end

				arg_331_1.text_.text = var_334_5
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002083", "story_v_side_old_108002.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002083", "story_v_side_old_108002.awb") / 1000

					if var_334_8 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_2
					end

					if var_334_4.prefab_name ~= "" and arg_331_1.actors_[var_334_4.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_4.prefab_name].transform, "story_v_side_old_108002", "108002083", "story_v_side_old_108002.awb")

						arg_331_1:RecordAudio("108002083", var_334_9)
						arg_331_1:RecordAudio("108002083", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002083", "story_v_side_old_108002.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002083", "story_v_side_old_108002.awb")
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
	Play108002084 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 108002084
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play108002085(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1080ui_story"]) and arg_335_1.var_.characterEffect1080ui_story == nil then
				arg_335_1.var_.characterEffect1080ui_story = arg_335_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1080ui_story"]) then
				if arg_335_1.var_.characterEffect1080ui_story and not isNil(arg_335_1.actors_["1080ui_story"]) then
					arg_335_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1080ui_story"]) and arg_335_1.var_.characterEffect1080ui_story then
				arg_335_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0
			local var_338_2 = 0.775

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(108002084).content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 31 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 31)

				if (31 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 31)) > 0 and var_338_2 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_1
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_6 = math.max(var_338_2, arg_335_1.talkMaxDuration)

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_6 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_1) / var_338_6

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_1 + var_338_6 and arg_335_1.time_ < var_338_1 + var_338_6 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play108002085 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 108002085
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play108002086(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.8

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(108002085).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 32 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 32)

				if (32 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 32)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play108002086 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 108002086
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play108002087(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.475

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(108002086).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 19 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 19)

				if (19 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 19)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play108002087 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 108002087
		arg_347_1.duration_ = 4.83

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play108002088(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1080ui_story"]) and arg_347_1.var_.characterEffect1080ui_story == nil then
				arg_347_1.var_.characterEffect1080ui_story = arg_347_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1080ui_story"]) then
				if arg_347_1.var_.characterEffect1080ui_story and not isNil(arg_347_1.actors_["1080ui_story"]) then
					arg_347_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1080ui_story"]) and arg_347_1.var_.characterEffect1080ui_story then
				arg_347_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action462")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_350_2 = 0
			local var_350_3 = 0.375

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:GetWordFromCfg(108002087)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_7 = 15 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 15)

				if (15 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 15)) > 0 and var_350_3 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002087", "story_v_side_old_108002.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002087", "story_v_side_old_108002.awb") / 1000

					if var_350_8 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_2
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_side_old_108002", "108002087", "story_v_side_old_108002.awb")

						arg_347_1:RecordAudio("108002087", var_350_9)
						arg_347_1:RecordAudio("108002087", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002087", "story_v_side_old_108002.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002087", "story_v_side_old_108002.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_3, arg_347_1.talkMaxDuration)

			if var_350_2 <= arg_347_1.time_ and arg_347_1.time_ < var_350_2 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_2) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_2 + var_350_10 and arg_347_1.time_ < var_350_2 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play108002088 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 108002088
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play108002089(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1080ui_story"]) and arg_351_1.var_.characterEffect1080ui_story == nil then
				arg_351_1.var_.characterEffect1080ui_story = arg_351_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1080ui_story"]) then
				if arg_351_1.var_.characterEffect1080ui_story and not isNil(arg_351_1.actors_["1080ui_story"]) then
					arg_351_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1080ui_story"]) and arg_351_1.var_.characterEffect1080ui_story then
				arg_351_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.475

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(108002088).content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 19 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 19)

				if (19 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 19)) > 0 and var_354_2 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_6 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_6 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_6

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_6 and arg_351_1.time_ < var_354_1 + var_354_6 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play108002089 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 108002089
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play108002090(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1080ui_story = arg_355_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1080ui_story"].transform.position).z)
				arg_355_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1080ui_story"].transform.localEulerAngles = arg_355_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_355_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1080ui_story"].transform.position).z)
				arg_355_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1080ui_story"].transform.localEulerAngles = arg_355_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_358_1 = 0
			local var_358_2 = 0.525

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(108002089).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 21 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 21)

				if (21 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 21)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play108002090 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 108002090
		arg_359_1.duration_ = 4.67

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play108002091(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.625

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:GetWordFromCfg(108002090)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 25 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 25)

				if (25 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 25)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002090", "story_v_side_old_108002.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002090", "story_v_side_old_108002.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_side_old_108002", "108002090", "story_v_side_old_108002.awb")

						arg_359_1:RecordAudio("108002090", var_362_6)
						arg_359_1:RecordAudio("108002090", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002090", "story_v_side_old_108002.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002090", "story_v_side_old_108002.awb")
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
	Play108002091 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 108002091
		arg_363_1.duration_ = 2

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play108002092(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1080ui_story = arg_363_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1080ui_story"].transform.position).z)
				arg_363_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1080ui_story"].transform.localEulerAngles = arg_363_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_363_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1080ui_story"].transform.position).z)
				arg_363_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1080ui_story"].transform.localEulerAngles = arg_363_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["1080ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1080ui_story == nil then
				arg_363_1.var_.characterEffect1080ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect1080ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1080ui_story then
				arg_363_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_366_4 = 0
			local var_366_5 = 0.05

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(108002091)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 2 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 2)

				if (2 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 2)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002091", "story_v_side_old_108002.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002091", "story_v_side_old_108002.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_side_old_108002", "108002091", "story_v_side_old_108002.awb")

						arg_363_1:RecordAudio("108002091", var_366_11)
						arg_363_1:RecordAudio("108002091", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002091", "story_v_side_old_108002.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002091", "story_v_side_old_108002.awb")
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
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play108002092 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 108002092
		arg_367_1.duration_ = 5.6

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play108002093(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1080ui_story"]) and arg_367_1.var_.characterEffect1080ui_story == nil then
				arg_367_1.var_.characterEffect1080ui_story = arg_367_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1080ui_story"]) then
				if arg_367_1.var_.characterEffect1080ui_story and not isNil(arg_367_1.actors_["1080ui_story"]) then
					arg_367_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_0)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1080ui_story"]) and arg_367_1.var_.characterEffect1080ui_story then
				arg_367_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_370_1 = 0
			local var_370_2 = 0.575

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_3 = arg_367_1:GetWordFromCfg(108002092)
				local var_370_4 = arg_367_1:FormatText(var_370_3.content)

				arg_367_1.text_.text = var_370_4

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_6 = 23 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_4) / 23)

				if (23 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_4) / 23)) > 0 and var_370_2 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_4
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002092", "story_v_side_old_108002.awb") ~= 0 then
					local var_370_7 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002092", "story_v_side_old_108002.awb") / 1000

					if var_370_7 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_1
					end

					if var_370_3.prefab_name ~= "" and arg_367_1.actors_[var_370_3.prefab_name] ~= nil then
						local var_370_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_3.prefab_name].transform, "story_v_side_old_108002", "108002092", "story_v_side_old_108002.awb")

						arg_367_1:RecordAudio("108002092", var_370_8)
						arg_367_1:RecordAudio("108002092", var_370_8)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002092", "story_v_side_old_108002.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002092", "story_v_side_old_108002.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_9 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_9 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_9

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_9 and arg_367_1.time_ < var_370_1 + var_370_9 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play108002093 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 108002093
		arg_371_1.duration_ = 5.77

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play108002094(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.825

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:GetWordFromCfg(108002093)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 33 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 33)

				if (33 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 33)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002093", "story_v_side_old_108002.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002093", "story_v_side_old_108002.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_side_old_108002", "108002093", "story_v_side_old_108002.awb")

						arg_371_1:RecordAudio("108002093", var_374_6)
						arg_371_1:RecordAudio("108002093", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002093", "story_v_side_old_108002.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002093", "story_v_side_old_108002.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play108002094 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 108002094
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play108002095(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1080ui_story = arg_375_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1080ui_story"].transform.position).z)
				arg_375_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1080ui_story"].transform.localEulerAngles = arg_375_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_375_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1080ui_story"].transform.position).z)
				arg_375_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1080ui_story"].transform.localEulerAngles = arg_375_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_378_1 = 0
			local var_378_2 = 0.7

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_3 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(108002094).content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 28 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 28)

				if (28 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 28)) > 0 and var_378_2 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_1
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_6 = math.max(var_378_2, arg_375_1.talkMaxDuration)

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_6 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_1) / var_378_6

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_1 + var_378_6 and arg_375_1.time_ < var_378_1 + var_378_6 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play108002095 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 108002095
		arg_379_1.duration_ = 8.77

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play108002096(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 1

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:GetWordFromCfg(108002095)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 40 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 40)

				if (40 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 40)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002095", "story_v_side_old_108002.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002095", "story_v_side_old_108002.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_side_old_108002", "108002095", "story_v_side_old_108002.awb")

						arg_379_1:RecordAudio("108002095", var_382_6)
						arg_379_1:RecordAudio("108002095", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002095", "story_v_side_old_108002.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002095", "story_v_side_old_108002.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play108002096 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 108002096
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play108002097(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.7

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(108002096).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 28 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 28)

				if (28 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 28)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play108002097 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 108002097
		arg_387_1.duration_ = 4.57

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play108002098(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1080ui_story = arg_387_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1080ui_story"].transform.position).z)
				arg_387_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1080ui_story"].transform.localEulerAngles = arg_387_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_387_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1080ui_story"].transform.position).z)
				arg_387_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1080ui_story"].transform.localEulerAngles = arg_387_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_390_1 = arg_387_1.actors_["1080ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1080ui_story == nil then
				arg_387_1.var_.characterEffect1080ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect1080ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1080ui_story then
				arg_387_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_390_4 = 0
			local var_390_5 = 0.625

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_4 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_6 = arg_387_1:GetWordFromCfg(108002097)
				local var_390_7 = arg_387_1:FormatText(var_390_6.content)

				arg_387_1.text_.text = var_390_7

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_9 = 25 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 25)

				if (25 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 25)) > 0 and var_390_5 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_4
					end
				end

				arg_387_1.text_.text = var_390_7
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002097", "story_v_side_old_108002.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002097", "story_v_side_old_108002.awb") / 1000

					if var_390_10 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_4
					end

					if var_390_6.prefab_name ~= "" and arg_387_1.actors_[var_390_6.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_6.prefab_name].transform, "story_v_side_old_108002", "108002097", "story_v_side_old_108002.awb")

						arg_387_1:RecordAudio("108002097", var_390_11)
						arg_387_1:RecordAudio("108002097", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002097", "story_v_side_old_108002.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002097", "story_v_side_old_108002.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_12 = math.max(var_390_5, arg_387_1.talkMaxDuration)

			if var_390_4 <= arg_387_1.time_ and arg_387_1.time_ < var_390_4 + var_390_12 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_4) / var_390_12

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_4 + var_390_12 and arg_387_1.time_ < var_390_4 + var_390_12 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play108002098 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 108002098
		arg_391_1.duration_ = 1

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play108002099(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1080ui_story"]) and arg_391_1.var_.characterEffect1080ui_story == nil then
				arg_391_1.var_.characterEffect1080ui_story = arg_391_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1080ui_story"]) then
				if arg_391_1.var_.characterEffect1080ui_story and not isNil(arg_391_1.actors_["1080ui_story"]) then
					arg_391_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1080ui_story"]) and arg_391_1.var_.characterEffect1080ui_story then
				arg_391_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_394_1 = 0
			local var_394_2 = 0.075

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:GetWordFromCfg(108002098)
				local var_394_4 = arg_391_1:FormatText(var_394_3.content)

				arg_391_1.text_.text = var_394_4

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_6 = 3 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_4) / 3)

				if (3 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_4) / 3)) > 0 and var_394_2 < var_394_6 then
					arg_391_1.talkMaxDuration = var_394_6

					if var_394_6 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_6 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_4
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002098", "story_v_side_old_108002.awb") ~= 0 then
					local var_394_7 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002098", "story_v_side_old_108002.awb") / 1000

					if var_394_7 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_1
					end

					if var_394_3.prefab_name ~= "" and arg_391_1.actors_[var_394_3.prefab_name] ~= nil then
						local var_394_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_3.prefab_name].transform, "story_v_side_old_108002", "108002098", "story_v_side_old_108002.awb")

						arg_391_1:RecordAudio("108002098", var_394_8)
						arg_391_1:RecordAudio("108002098", var_394_8)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002098", "story_v_side_old_108002.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002098", "story_v_side_old_108002.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_9 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_9 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_9

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_9 and arg_391_1.time_ < var_394_1 + var_394_9 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play108002099 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 108002099
		arg_395_1.duration_ = 6.73

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play108002100(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1080ui_story"]) and arg_395_1.var_.characterEffect1080ui_story == nil then
				arg_395_1.var_.characterEffect1080ui_story = arg_395_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1080ui_story"]) then
				if arg_395_1.var_.characterEffect1080ui_story and not isNil(arg_395_1.actors_["1080ui_story"]) then
					arg_395_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1080ui_story"]) and arg_395_1.var_.characterEffect1080ui_story then
				arg_395_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_398_2 = 0
			local var_398_3 = 0.4

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_4 = arg_395_1:GetWordFromCfg(108002099)
				local var_398_5 = arg_395_1:FormatText(var_398_4.content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 16 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 16)

				if (16 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 16)) > 0 and var_398_3 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_2
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002099", "story_v_side_old_108002.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002099", "story_v_side_old_108002.awb") / 1000

					if var_398_8 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_2
					end

					if var_398_4.prefab_name ~= "" and arg_395_1.actors_[var_398_4.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_4.prefab_name].transform, "story_v_side_old_108002", "108002099", "story_v_side_old_108002.awb")

						arg_395_1:RecordAudio("108002099", var_398_9)
						arg_395_1:RecordAudio("108002099", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002099", "story_v_side_old_108002.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002099", "story_v_side_old_108002.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_3, arg_395_1.talkMaxDuration)

			if var_398_2 <= arg_395_1.time_ and arg_395_1.time_ < var_398_2 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_2) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_2 + var_398_10 and arg_395_1.time_ < var_398_2 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play108002100 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 108002100
		arg_399_1.duration_ = 6.67

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play108002101(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action462")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_402_0 = 0
			local var_402_1 = 0.25

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_2 = arg_399_1:GetWordFromCfg(108002100)
				local var_402_3 = arg_399_1:FormatText(var_402_2.content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 10 <= 0 and var_402_1 or var_402_1 * (utf8.len(var_402_3) / 10)

				if (10 <= 0 and var_402_1 or var_402_1 * (utf8.len(var_402_3) / 10)) > 0 and var_402_1 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002100", "story_v_side_old_108002.awb") ~= 0 then
					local var_402_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002100", "story_v_side_old_108002.awb") / 1000

					if var_402_6 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_6 + var_402_0
					end

					if var_402_2.prefab_name ~= "" and arg_399_1.actors_[var_402_2.prefab_name] ~= nil then
						local var_402_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_2.prefab_name].transform, "story_v_side_old_108002", "108002100", "story_v_side_old_108002.awb")

						arg_399_1:RecordAudio("108002100", var_402_7)
						arg_399_1:RecordAudio("108002100", var_402_7)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002100", "story_v_side_old_108002.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002100", "story_v_side_old_108002.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_8 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_8 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_8

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_8 and arg_399_1.time_ < var_402_0 + var_402_8 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play108002101 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 108002101
		arg_403_1.duration_ = 1.93

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play108002102(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1080ui_story"]) and arg_403_1.var_.characterEffect1080ui_story == nil then
				arg_403_1.var_.characterEffect1080ui_story = arg_403_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1080ui_story"]) then
				if arg_403_1.var_.characterEffect1080ui_story and not isNil(arg_403_1.actors_["1080ui_story"]) then
					arg_403_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_0)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1080ui_story"]) and arg_403_1.var_.characterEffect1080ui_story then
				arg_403_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_406_1 = 0
			local var_406_2 = 0.1

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_boffinm")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:GetWordFromCfg(108002101)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_6 = 4 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_4) / 4)

				if (4 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_4) / 4)) > 0 and var_406_2 < var_406_6 then
					arg_403_1.talkMaxDuration = var_406_6

					if var_406_6 + var_406_1 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_6 + var_406_1
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002101", "story_v_side_old_108002.awb") ~= 0 then
					local var_406_7 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002101", "story_v_side_old_108002.awb") / 1000

					if var_406_7 + var_406_1 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_1
					end

					if var_406_3.prefab_name ~= "" and arg_403_1.actors_[var_406_3.prefab_name] ~= nil then
						local var_406_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_3.prefab_name].transform, "story_v_side_old_108002", "108002101", "story_v_side_old_108002.awb")

						arg_403_1:RecordAudio("108002101", var_406_8)
						arg_403_1:RecordAudio("108002101", var_406_8)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002101", "story_v_side_old_108002.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002101", "story_v_side_old_108002.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_9 = math.max(var_406_2, arg_403_1.talkMaxDuration)

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_9 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_1) / var_406_9

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_1 + var_406_9 and arg_403_1.time_ < var_406_1 + var_406_9 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play108002102 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 108002102
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play108002103(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.725

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(108002102).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 29 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 29)

				if (29 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 29)) > 0 and var_410_0 < var_410_3 then
					arg_407_1.talkMaxDuration = var_410_3

					if var_410_3 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_3 + 0
					end
				end

				arg_407_1.text_.text = var_410_1
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_4 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_4

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play108002103 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 108002103
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play108002104(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.625

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(108002103).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 25 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 25)

				if (25 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 25)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play108002104 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 108002104
		arg_415_1.duration_ = 4.3

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play108002105(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1080ui_story"]) and arg_415_1.var_.characterEffect1080ui_story == nil then
				arg_415_1.var_.characterEffect1080ui_story = arg_415_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1080ui_story"]) then
				if arg_415_1.var_.characterEffect1080ui_story and not isNil(arg_415_1.actors_["1080ui_story"]) then
					arg_415_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1080ui_story"]) and arg_415_1.var_.characterEffect1080ui_story then
				arg_415_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_418_2 = 0
			local var_418_3 = 0.3

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_2 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_4 = arg_415_1:GetWordFromCfg(108002104)
				local var_418_5 = arg_415_1:FormatText(var_418_4.content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_7 = 12 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_5) / 12)

				if (12 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_5) / 12)) > 0 and var_418_3 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_2
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002104", "story_v_side_old_108002.awb") ~= 0 then
					local var_418_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002104", "story_v_side_old_108002.awb") / 1000

					if var_418_8 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_2
					end

					if var_418_4.prefab_name ~= "" and arg_415_1.actors_[var_418_4.prefab_name] ~= nil then
						local var_418_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_4.prefab_name].transform, "story_v_side_old_108002", "108002104", "story_v_side_old_108002.awb")

						arg_415_1:RecordAudio("108002104", var_418_9)
						arg_415_1:RecordAudio("108002104", var_418_9)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002104", "story_v_side_old_108002.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002104", "story_v_side_old_108002.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_10 = math.max(var_418_3, arg_415_1.talkMaxDuration)

			if var_418_2 <= arg_415_1.time_ and arg_415_1.time_ < var_418_2 + var_418_10 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_2) / var_418_10

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_2 + var_418_10 and arg_415_1.time_ < var_418_2 + var_418_10 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play108002105 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 108002105
		arg_419_1.duration_ = 2.9

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play108002106(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_422_0 = 0
			local var_422_1 = 0.525

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_2 = arg_419_1:GetWordFromCfg(108002105)
				local var_422_3 = arg_419_1:FormatText(var_422_2.content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 21 <= 0 and var_422_1 or var_422_1 * (utf8.len(var_422_3) / 21)

				if (21 <= 0 and var_422_1 or var_422_1 * (utf8.len(var_422_3) / 21)) > 0 and var_422_1 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002105", "story_v_side_old_108002.awb") ~= 0 then
					local var_422_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002105", "story_v_side_old_108002.awb") / 1000

					if var_422_6 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_0
					end

					if var_422_2.prefab_name ~= "" and arg_419_1.actors_[var_422_2.prefab_name] ~= nil then
						local var_422_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_2.prefab_name].transform, "story_v_side_old_108002", "108002105", "story_v_side_old_108002.awb")

						arg_419_1:RecordAudio("108002105", var_422_7)
						arg_419_1:RecordAudio("108002105", var_422_7)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002105", "story_v_side_old_108002.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002105", "story_v_side_old_108002.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_8 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_8 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_8

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_8 and arg_419_1.time_ < var_422_0 + var_422_8 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play108002106 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 108002106
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play108002107(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1080ui_story"]) and arg_423_1.var_.characterEffect1080ui_story == nil then
				arg_423_1.var_.characterEffect1080ui_story = arg_423_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1080ui_story"]) then
				if arg_423_1.var_.characterEffect1080ui_story and not isNil(arg_423_1.actors_["1080ui_story"]) then
					arg_423_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1080ui_story"]) and arg_423_1.var_.characterEffect1080ui_story then
				arg_423_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_426_1 = 0
			local var_426_2 = 0.85

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_3 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(108002106).content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 34 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 34)

				if (34 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 34)) > 0 and var_426_2 < var_426_5 then
					arg_423_1.talkMaxDuration = var_426_5

					if var_426_5 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_6 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_6 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_6

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_6 and arg_423_1.time_ < var_426_1 + var_426_6 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play108002107 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 108002107
		arg_427_1.duration_ = 3.3

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play108002108(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) and arg_427_1.var_.characterEffect1080ui_story == nil then
				arg_427_1.var_.characterEffect1080ui_story = arg_427_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) then
				if arg_427_1.var_.characterEffect1080ui_story and not isNil(arg_427_1.actors_["1080ui_story"]) then
					arg_427_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["1080ui_story"]) and arg_427_1.var_.characterEffect1080ui_story then
				arg_427_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action4_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_2 = 0
			local var_430_3 = 0.3

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_2 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_4 = arg_427_1:GetWordFromCfg(108002107)
				local var_430_5 = arg_427_1:FormatText(var_430_4.content)

				arg_427_1.text_.text = var_430_5

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_7 = 12 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 12)

				if (12 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 12)) > 0 and var_430_3 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_2
					end
				end

				arg_427_1.text_.text = var_430_5
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002107", "story_v_side_old_108002.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002107", "story_v_side_old_108002.awb") / 1000

					if var_430_8 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_2
					end

					if var_430_4.prefab_name ~= "" and arg_427_1.actors_[var_430_4.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_4.prefab_name].transform, "story_v_side_old_108002", "108002107", "story_v_side_old_108002.awb")

						arg_427_1:RecordAudio("108002107", var_430_9)
						arg_427_1:RecordAudio("108002107", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002107", "story_v_side_old_108002.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002107", "story_v_side_old_108002.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_3, arg_427_1.talkMaxDuration)

			if var_430_2 <= arg_427_1.time_ and arg_427_1.time_ < var_430_2 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_2) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_2 + var_430_10 and arg_427_1.time_ < var_430_2 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play108002108 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 108002108
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play108002109(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1080ui_story"]) and arg_431_1.var_.characterEffect1080ui_story == nil then
				arg_431_1.var_.characterEffect1080ui_story = arg_431_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1080ui_story"]) then
				if arg_431_1.var_.characterEffect1080ui_story and not isNil(arg_431_1.actors_["1080ui_story"]) then
					arg_431_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1080ui_story"]) and arg_431_1.var_.characterEffect1080ui_story then
				arg_431_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_434_1 = 0
			local var_434_2 = 0.2

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(108002108).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 8 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 8)

				if (8 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 8)) > 0 and var_434_2 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_6 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_6 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_6

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_6 and arg_431_1.time_ < var_434_1 + var_434_6 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play108002109 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 108002109
		arg_435_1.duration_ = 5.97

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play108002110(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1080ui_story"]) and arg_435_1.var_.characterEffect1080ui_story == nil then
				arg_435_1.var_.characterEffect1080ui_story = arg_435_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1080ui_story"]) then
				if arg_435_1.var_.characterEffect1080ui_story and not isNil(arg_435_1.actors_["1080ui_story"]) then
					arg_435_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1080ui_story"]) and arg_435_1.var_.characterEffect1080ui_story then
				arg_435_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_438_2 = 0
			local var_438_3 = 0.35

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_2 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_4 = arg_435_1:GetWordFromCfg(108002109)
				local var_438_5 = arg_435_1:FormatText(var_438_4.content)

				arg_435_1.text_.text = var_438_5

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_7 = 14 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 14)

				if (14 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 14)) > 0 and var_438_3 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_2
					end
				end

				arg_435_1.text_.text = var_438_5
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002109", "story_v_side_old_108002.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002109", "story_v_side_old_108002.awb") / 1000

					if var_438_8 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_2
					end

					if var_438_4.prefab_name ~= "" and arg_435_1.actors_[var_438_4.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_4.prefab_name].transform, "story_v_side_old_108002", "108002109", "story_v_side_old_108002.awb")

						arg_435_1:RecordAudio("108002109", var_438_9)
						arg_435_1:RecordAudio("108002109", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002109", "story_v_side_old_108002.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002109", "story_v_side_old_108002.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_3, arg_435_1.talkMaxDuration)

			if var_438_2 <= arg_435_1.time_ and arg_435_1.time_ < var_438_2 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_2) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_2 + var_438_10 and arg_435_1.time_ < var_438_2 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play108002110 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 108002110
		arg_439_1.duration_ = 11.13

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play108002111(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_442_0 = 0
			local var_442_1 = 0.525

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(108002110)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 21 <= 0 and var_442_1 or var_442_1 * (utf8.len(var_442_3) / 21)

				if (21 <= 0 and var_442_1 or var_442_1 * (utf8.len(var_442_3) / 21)) > 0 and var_442_1 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002110", "story_v_side_old_108002.awb") ~= 0 then
					local var_442_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002110", "story_v_side_old_108002.awb") / 1000

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end

					if var_442_2.prefab_name ~= "" and arg_439_1.actors_[var_442_2.prefab_name] ~= nil then
						local var_442_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_2.prefab_name].transform, "story_v_side_old_108002", "108002110", "story_v_side_old_108002.awb")

						arg_439_1:RecordAudio("108002110", var_442_7)
						arg_439_1:RecordAudio("108002110", var_442_7)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002110", "story_v_side_old_108002.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002110", "story_v_side_old_108002.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_8 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_8 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_8

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_8 and arg_439_1.time_ < var_442_0 + var_442_8 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play108002111 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 108002111
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play108002112(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1080ui_story = arg_443_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1080ui_story"].transform.position).z)
				arg_443_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1080ui_story"].transform.localEulerAngles = arg_443_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_443_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1080ui_story"].transform.position).z)
				arg_443_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1080ui_story"].transform.localEulerAngles = arg_443_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_446_1 = 0
			local var_446_2 = 0.675

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

				local var_446_3 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(108002111).content)

				arg_443_1.text_.text = var_446_3

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 27 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 27)

				if (27 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_3) / 27)) > 0 and var_446_2 < var_446_5 then
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

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play108002112 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 108002112
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play108002113(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.975

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(108002112).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 39 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 39)

				if (39 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 39)) > 0 and var_450_0 < var_450_3 then
					arg_447_1.talkMaxDuration = var_450_3

					if var_450_3 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_3 + 0
					end
				end

				arg_447_1.text_.text = var_450_1
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_4 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_4

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play108002113 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 108002113
		arg_451_1.duration_ = 3.6

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play108002114(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1080ui_story = arg_451_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_454_0 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 then
				arg_451_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_451_1.time_ - 0) / var_454_0)
				arg_451_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1080ui_story"].transform.position).z)
				arg_451_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1080ui_story"].transform.localEulerAngles = arg_451_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 then
				arg_451_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_451_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1080ui_story"].transform.position).z)
				arg_451_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1080ui_story"].transform.localEulerAngles = arg_451_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_454_1 = arg_451_1.actors_["1080ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1080ui_story == nil then
				arg_451_1.var_.characterEffect1080ui_story = var_454_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.2

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_2 and not isNil(var_454_1) then
				if arg_451_1.var_.characterEffect1080ui_story and not isNil(var_454_1) then
					arg_451_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_2 and arg_451_1.time_ < 0 + var_454_2 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1080ui_story then
				arg_451_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_454_4 = 0
			local var_454_5 = 0.25

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_6 = arg_451_1:GetWordFromCfg(108002113)
				local var_454_7 = arg_451_1:FormatText(var_454_6.content)

				arg_451_1.text_.text = var_454_7

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_9 = 10 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 10)

				if (10 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 10)) > 0 and var_454_5 < var_454_9 then
					arg_451_1.talkMaxDuration = var_454_9

					if var_454_9 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_9 + var_454_4
					end
				end

				arg_451_1.text_.text = var_454_7
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002113", "story_v_side_old_108002.awb") ~= 0 then
					local var_454_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002113", "story_v_side_old_108002.awb") / 1000

					if var_454_10 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_10 + var_454_4
					end

					if var_454_6.prefab_name ~= "" and arg_451_1.actors_[var_454_6.prefab_name] ~= nil then
						local var_454_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_6.prefab_name].transform, "story_v_side_old_108002", "108002113", "story_v_side_old_108002.awb")

						arg_451_1:RecordAudio("108002113", var_454_11)
						arg_451_1:RecordAudio("108002113", var_454_11)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002113", "story_v_side_old_108002.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002113", "story_v_side_old_108002.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_12 = math.max(var_454_5, arg_451_1.talkMaxDuration)

			if var_454_4 <= arg_451_1.time_ and arg_451_1.time_ < var_454_4 + var_454_12 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_4) / var_454_12

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_4 + var_454_12 and arg_451_1.time_ < var_454_4 + var_454_12 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play108002114 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 108002114
		arg_455_1.duration_ = 8.7

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play108002115(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_458_0 = 0
			local var_458_1 = 0.375

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_2 = arg_455_1:GetWordFromCfg(108002114)
				local var_458_3 = arg_455_1:FormatText(var_458_2.content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 15 <= 0 and var_458_1 or var_458_1 * (utf8.len(var_458_3) / 15)

				if (15 <= 0 and var_458_1 or var_458_1 * (utf8.len(var_458_3) / 15)) > 0 and var_458_1 < var_458_5 then
					arg_455_1.talkMaxDuration = var_458_5

					if var_458_5 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + var_458_0
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002114", "story_v_side_old_108002.awb") ~= 0 then
					local var_458_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002114", "story_v_side_old_108002.awb") / 1000

					if var_458_6 + var_458_0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_6 + var_458_0
					end

					if var_458_2.prefab_name ~= "" and arg_455_1.actors_[var_458_2.prefab_name] ~= nil then
						local var_458_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_2.prefab_name].transform, "story_v_side_old_108002", "108002114", "story_v_side_old_108002.awb")

						arg_455_1:RecordAudio("108002114", var_458_7)
						arg_455_1:RecordAudio("108002114", var_458_7)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002114", "story_v_side_old_108002.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002114", "story_v_side_old_108002.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_8 = math.max(var_458_1, arg_455_1.talkMaxDuration)

			if var_458_0 <= arg_455_1.time_ and arg_455_1.time_ < var_458_0 + var_458_8 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_0) / var_458_8

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_0 + var_458_8 and arg_455_1.time_ < var_458_0 + var_458_8 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play108002115 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 108002115
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play108002116(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["1080ui_story"]) and arg_459_1.var_.characterEffect1080ui_story == nil then
				arg_459_1.var_.characterEffect1080ui_story = arg_459_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_0 = 0.2

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["1080ui_story"]) then
				if arg_459_1.var_.characterEffect1080ui_story and not isNil(arg_459_1.actors_["1080ui_story"]) then
					arg_459_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_459_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_459_1.time_ - 0) / var_462_0)
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["1080ui_story"]) and arg_459_1.var_.characterEffect1080ui_story then
				arg_459_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_459_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_462_1 = 0
			local var_462_2 = 0.775

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_3 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(108002115).content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 31 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 31)

				if (31 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 31)) > 0 and var_462_2 < var_462_5 then
					arg_459_1.talkMaxDuration = var_462_5

					if var_462_5 + var_462_1 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + var_462_1
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_6 = math.max(var_462_2, arg_459_1.talkMaxDuration)

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_6 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_1) / var_462_6

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_1 + var_462_6 and arg_459_1.time_ < var_462_1 + var_462_6 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play108002116 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 108002116
		arg_463_1.duration_ = 5.93

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play108002117(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["1080ui_story"]) and arg_463_1.var_.characterEffect1080ui_story == nil then
				arg_463_1.var_.characterEffect1080ui_story = arg_463_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["1080ui_story"]) then
				if arg_463_1.var_.characterEffect1080ui_story and not isNil(arg_463_1.actors_["1080ui_story"]) then
					arg_463_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["1080ui_story"]) and arg_463_1.var_.characterEffect1080ui_story then
				arg_463_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_466_2 = 0
			local var_466_3 = 0.275

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_2 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_4 = arg_463_1:GetWordFromCfg(108002116)
				local var_466_5 = arg_463_1:FormatText(var_466_4.content)

				arg_463_1.text_.text = var_466_5

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_7 = 11 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_5) / 11)

				if (11 <= 0 and var_466_3 or var_466_3 * (utf8.len(var_466_5) / 11)) > 0 and var_466_3 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_2
					end
				end

				arg_463_1.text_.text = var_466_5
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002116", "story_v_side_old_108002.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002116", "story_v_side_old_108002.awb") / 1000

					if var_466_8 + var_466_2 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_2
					end

					if var_466_4.prefab_name ~= "" and arg_463_1.actors_[var_466_4.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_4.prefab_name].transform, "story_v_side_old_108002", "108002116", "story_v_side_old_108002.awb")

						arg_463_1:RecordAudio("108002116", var_466_9)
						arg_463_1:RecordAudio("108002116", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002116", "story_v_side_old_108002.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002116", "story_v_side_old_108002.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_3, arg_463_1.talkMaxDuration)

			if var_466_2 <= arg_463_1.time_ and arg_463_1.time_ < var_466_2 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_2) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_2 + var_466_10 and arg_463_1.time_ < var_466_2 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play108002117 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 108002117
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play108002118(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["1080ui_story"]) and arg_467_1.var_.characterEffect1080ui_story == nil then
				arg_467_1.var_.characterEffect1080ui_story = arg_467_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["1080ui_story"]) then
				if arg_467_1.var_.characterEffect1080ui_story and not isNil(arg_467_1.actors_["1080ui_story"]) then
					arg_467_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_467_1.time_ - 0) / var_470_0)
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["1080ui_story"]) and arg_467_1.var_.characterEffect1080ui_story then
				arg_467_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_470_1 = 0
			local var_470_2 = 0.275

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_3 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(108002117).content)

				arg_467_1.text_.text = var_470_3

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 11 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 11)

				if (11 <= 0 and var_470_2 or var_470_2 * (utf8.len(var_470_3) / 11)) > 0 and var_470_2 < var_470_5 then
					arg_467_1.talkMaxDuration = var_470_5

					if var_470_5 + var_470_1 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_5 + var_470_1
					end
				end

				arg_467_1.text_.text = var_470_3
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_6 = math.max(var_470_2, arg_467_1.talkMaxDuration)

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_6 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_1) / var_470_6

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_1 + var_470_6 and arg_467_1.time_ < var_470_1 + var_470_6 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play108002118 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 108002118
		arg_471_1.duration_ = 2

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play108002119(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(arg_471_1.actors_["1080ui_story"]) and arg_471_1.var_.characterEffect1080ui_story == nil then
				arg_471_1.var_.characterEffect1080ui_story = arg_471_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_0 = 0.2

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 and not isNil(arg_471_1.actors_["1080ui_story"]) then
				if arg_471_1.var_.characterEffect1080ui_story and not isNil(arg_471_1.actors_["1080ui_story"]) then
					arg_471_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 and not isNil(arg_471_1.actors_["1080ui_story"]) and arg_471_1.var_.characterEffect1080ui_story then
				arg_471_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_474_2 = 0
			local var_474_3 = 0.45

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_2 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_4 = arg_471_1:GetWordFromCfg(108002118)
				local var_474_5 = arg_471_1:FormatText(var_474_4.content)

				arg_471_1.text_.text = var_474_5

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_7 = 18 <= 0 and var_474_3 or var_474_3 * (utf8.len(var_474_5) / 18)

				if (18 <= 0 and var_474_3 or var_474_3 * (utf8.len(var_474_5) / 18)) > 0 and var_474_3 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_2 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_2
					end
				end

				arg_471_1.text_.text = var_474_5
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002118", "story_v_side_old_108002.awb") ~= 0 then
					local var_474_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002118", "story_v_side_old_108002.awb") / 1000

					if var_474_8 + var_474_2 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_8 + var_474_2
					end

					if var_474_4.prefab_name ~= "" and arg_471_1.actors_[var_474_4.prefab_name] ~= nil then
						local var_474_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_4.prefab_name].transform, "story_v_side_old_108002", "108002118", "story_v_side_old_108002.awb")

						arg_471_1:RecordAudio("108002118", var_474_9)
						arg_471_1:RecordAudio("108002118", var_474_9)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002118", "story_v_side_old_108002.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002118", "story_v_side_old_108002.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_10 = math.max(var_474_3, arg_471_1.talkMaxDuration)

			if var_474_2 <= arg_471_1.time_ and arg_471_1.time_ < var_474_2 + var_474_10 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_2) / var_474_10

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_2 + var_474_10 and arg_471_1.time_ < var_474_2 + var_474_10 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play108002119 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 108002119
		arg_475_1.duration_ = 4.37

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play108002120(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_478_0 = 0
			local var_478_1 = 0.2

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_2 = arg_475_1:GetWordFromCfg(108002119)
				local var_478_3 = arg_475_1:FormatText(var_478_2.content)

				arg_475_1.text_.text = var_478_3

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 8 <= 0 and var_478_1 or var_478_1 * (utf8.len(var_478_3) / 8)

				if (8 <= 0 and var_478_1 or var_478_1 * (utf8.len(var_478_3) / 8)) > 0 and var_478_1 < var_478_5 then
					arg_475_1.talkMaxDuration = var_478_5

					if var_478_5 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_5 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_3
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002119", "story_v_side_old_108002.awb") ~= 0 then
					local var_478_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002119", "story_v_side_old_108002.awb") / 1000

					if var_478_6 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_6 + var_478_0
					end

					if var_478_2.prefab_name ~= "" and arg_475_1.actors_[var_478_2.prefab_name] ~= nil then
						local var_478_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_2.prefab_name].transform, "story_v_side_old_108002", "108002119", "story_v_side_old_108002.awb")

						arg_475_1:RecordAudio("108002119", var_478_7)
						arg_475_1:RecordAudio("108002119", var_478_7)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002119", "story_v_side_old_108002.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002119", "story_v_side_old_108002.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_8 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_8 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_8

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_8 and arg_475_1.time_ < var_478_0 + var_478_8 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play108002120 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 108002120
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play108002121(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["1080ui_story"]) and arg_479_1.var_.characterEffect1080ui_story == nil then
				arg_479_1.var_.characterEffect1080ui_story = arg_479_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_0 = 0.2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["1080ui_story"]) then
				if arg_479_1.var_.characterEffect1080ui_story and not isNil(arg_479_1.actors_["1080ui_story"]) then
					arg_479_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_479_1.time_ - 0) / var_482_0)
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["1080ui_story"]) and arg_479_1.var_.characterEffect1080ui_story then
				arg_479_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_482_1 = 0
			local var_482_2 = 0.075

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_3 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(108002120).content)

				arg_479_1.text_.text = var_482_3

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 3 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 3)

				if (3 <= 0 and var_482_2 or var_482_2 * (utf8.len(var_482_3) / 3)) > 0 and var_482_2 < var_482_5 then
					arg_479_1.talkMaxDuration = var_482_5

					if var_482_5 + var_482_1 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + var_482_1
					end
				end

				arg_479_1.text_.text = var_482_3
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_6 = math.max(var_482_2, arg_479_1.talkMaxDuration)

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_6 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_1) / var_482_6

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_1 + var_482_6 and arg_479_1.time_ < var_482_1 + var_482_6 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play108002121 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 108002121
		arg_483_1.duration_ = 4.83

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play108002122(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1080ui_story"]) and arg_483_1.var_.characterEffect1080ui_story == nil then
				arg_483_1.var_.characterEffect1080ui_story = arg_483_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_0 = 0.2

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1080ui_story"]) then
				if arg_483_1.var_.characterEffect1080ui_story and not isNil(arg_483_1.actors_["1080ui_story"]) then
					arg_483_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1080ui_story"]) and arg_483_1.var_.characterEffect1080ui_story then
				arg_483_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_486_2 = 0
			local var_486_3 = 0.475

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_2 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_4 = arg_483_1:GetWordFromCfg(108002121)
				local var_486_5 = arg_483_1:FormatText(var_486_4.content)

				arg_483_1.text_.text = var_486_5

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_7 = 19 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 19)

				if (19 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_5) / 19)) > 0 and var_486_3 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_2
					end
				end

				arg_483_1.text_.text = var_486_5
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002121", "story_v_side_old_108002.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002121", "story_v_side_old_108002.awb") / 1000

					if var_486_8 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_2
					end

					if var_486_4.prefab_name ~= "" and arg_483_1.actors_[var_486_4.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_4.prefab_name].transform, "story_v_side_old_108002", "108002121", "story_v_side_old_108002.awb")

						arg_483_1:RecordAudio("108002121", var_486_9)
						arg_483_1:RecordAudio("108002121", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002121", "story_v_side_old_108002.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002121", "story_v_side_old_108002.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_3, arg_483_1.talkMaxDuration)

			if var_486_2 <= arg_483_1.time_ and arg_483_1.time_ < var_486_2 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_2) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_2 + var_486_10 and arg_483_1.time_ < var_486_2 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play108002122 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 108002122
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play108002123(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1080ui_story"]) and arg_487_1.var_.characterEffect1080ui_story == nil then
				arg_487_1.var_.characterEffect1080ui_story = arg_487_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.2

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1080ui_story"]) then
				if arg_487_1.var_.characterEffect1080ui_story and not isNil(arg_487_1.actors_["1080ui_story"]) then
					arg_487_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_0)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1080ui_story"]) and arg_487_1.var_.characterEffect1080ui_story then
				arg_487_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_490_1 = 0
			local var_490_2 = 0.65

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(108002122).content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 26 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 26)

				if (26 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 26)) > 0 and var_490_2 < var_490_5 then
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
	Play108002123 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 108002123
		arg_491_1.duration_ = 2

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play108002124(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["1080ui_story"]) and arg_491_1.var_.characterEffect1080ui_story == nil then
				arg_491_1.var_.characterEffect1080ui_story = arg_491_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_0 = 0.2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["1080ui_story"]) then
				if arg_491_1.var_.characterEffect1080ui_story and not isNil(arg_491_1.actors_["1080ui_story"]) then
					arg_491_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["1080ui_story"]) and arg_491_1.var_.characterEffect1080ui_story then
				arg_491_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_494_2 = 0
			local var_494_3 = 0.1

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_2 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_4 = arg_491_1:GetWordFromCfg(108002123)
				local var_494_5 = arg_491_1:FormatText(var_494_4.content)

				arg_491_1.text_.text = var_494_5

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_7 = 4 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 4)

				if (4 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 4)) > 0 and var_494_3 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_2
					end
				end

				arg_491_1.text_.text = var_494_5
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002123", "story_v_side_old_108002.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002123", "story_v_side_old_108002.awb") / 1000

					if var_494_8 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_2
					end

					if var_494_4.prefab_name ~= "" and arg_491_1.actors_[var_494_4.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_4.prefab_name].transform, "story_v_side_old_108002", "108002123", "story_v_side_old_108002.awb")

						arg_491_1:RecordAudio("108002123", var_494_9)
						arg_491_1:RecordAudio("108002123", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002123", "story_v_side_old_108002.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002123", "story_v_side_old_108002.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_3, arg_491_1.talkMaxDuration)

			if var_494_2 <= arg_491_1.time_ and arg_491_1.time_ < var_494_2 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_2) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_2 + var_494_10 and arg_491_1.time_ < var_494_2 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play108002124 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 108002124
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play108002125(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos1080ui_story = arg_495_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1080ui_story"].transform.position).z)
				arg_495_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1080ui_story"].transform.localEulerAngles = arg_495_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_495_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1080ui_story"].transform.position).z)
				arg_495_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1080ui_story"].transform.localEulerAngles = arg_495_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_498_1 = 0
			local var_498_2 = 0.475

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_3 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(108002124).content)

				arg_495_1.text_.text = var_498_3

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 19 <= 0 and var_498_2 or var_498_2 * (utf8.len(var_498_3) / 19)

				if (19 <= 0 and var_498_2 or var_498_2 * (utf8.len(var_498_3) / 19)) > 0 and var_498_2 < var_498_5 then
					arg_495_1.talkMaxDuration = var_498_5

					if var_498_5 + var_498_1 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + var_498_1
					end
				end

				arg_495_1.text_.text = var_498_3
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_6 = math.max(var_498_2, arg_495_1.talkMaxDuration)

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_6 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_1) / var_498_6

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_1 + var_498_6 and arg_495_1.time_ < var_498_1 + var_498_6 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play108002125 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 108002125
		arg_499_1.duration_ = 2.87

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play108002126(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1080ui_story = arg_499_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_502_0 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 then
				arg_499_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_499_1.time_ - 0) / var_502_0)
				arg_499_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1080ui_story"].transform.position).z)
				arg_499_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1080ui_story"].transform.localEulerAngles = arg_499_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 then
				arg_499_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_499_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_499_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_499_1.actors_["1080ui_story"].transform.position).z)
				arg_499_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_499_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_499_1.actors_["1080ui_story"].transform.localEulerAngles = arg_499_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_502_1 = arg_499_1.actors_["1080ui_story"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1080ui_story == nil then
				arg_499_1.var_.characterEffect1080ui_story = var_502_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_2 and not isNil(var_502_1) then
				if arg_499_1.var_.characterEffect1080ui_story and not isNil(var_502_1) then
					arg_499_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_2 and arg_499_1.time_ < 0 + var_502_2 + arg_502_0 and not isNil(var_502_1) and arg_499_1.var_.characterEffect1080ui_story then
				arg_499_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action4_1")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_502_4 = 0
			local var_502_5 = 0.275

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_4 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_6 = arg_499_1:GetWordFromCfg(108002125)
				local var_502_7 = arg_499_1:FormatText(var_502_6.content)

				arg_499_1.text_.text = var_502_7

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_9 = 11 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 11)

				if (11 <= 0 and var_502_5 or var_502_5 * (utf8.len(var_502_7) / 11)) > 0 and var_502_5 < var_502_9 then
					arg_499_1.talkMaxDuration = var_502_9

					if var_502_9 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_9 + var_502_4
					end
				end

				arg_499_1.text_.text = var_502_7
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002125", "story_v_side_old_108002.awb") ~= 0 then
					local var_502_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002125", "story_v_side_old_108002.awb") / 1000

					if var_502_10 + var_502_4 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_10 + var_502_4
					end

					if var_502_6.prefab_name ~= "" and arg_499_1.actors_[var_502_6.prefab_name] ~= nil then
						local var_502_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_6.prefab_name].transform, "story_v_side_old_108002", "108002125", "story_v_side_old_108002.awb")

						arg_499_1:RecordAudio("108002125", var_502_11)
						arg_499_1:RecordAudio("108002125", var_502_11)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002125", "story_v_side_old_108002.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002125", "story_v_side_old_108002.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_12 = math.max(var_502_5, arg_499_1.talkMaxDuration)

			if var_502_4 <= arg_499_1.time_ and arg_499_1.time_ < var_502_4 + var_502_12 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_4) / var_502_12

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_4 + var_502_12 and arg_499_1.time_ < var_502_4 + var_502_12 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play108002126 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 108002126
		arg_503_1.duration_ = 2.43

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play108002127(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action445")
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_506_0 = 0
			local var_506_1 = 0.325

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_2 = arg_503_1:GetWordFromCfg(108002126)
				local var_506_3 = arg_503_1:FormatText(var_506_2.content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 13 <= 0 and var_506_1 or var_506_1 * (utf8.len(var_506_3) / 13)

				if (13 <= 0 and var_506_1 or var_506_1 * (utf8.len(var_506_3) / 13)) > 0 and var_506_1 < var_506_5 then
					arg_503_1.talkMaxDuration = var_506_5

					if var_506_5 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002126", "story_v_side_old_108002.awb") ~= 0 then
					local var_506_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002126", "story_v_side_old_108002.awb") / 1000

					if var_506_6 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_0
					end

					if var_506_2.prefab_name ~= "" and arg_503_1.actors_[var_506_2.prefab_name] ~= nil then
						local var_506_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_2.prefab_name].transform, "story_v_side_old_108002", "108002126", "story_v_side_old_108002.awb")

						arg_503_1:RecordAudio("108002126", var_506_7)
						arg_503_1:RecordAudio("108002126", var_506_7)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002126", "story_v_side_old_108002.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002126", "story_v_side_old_108002.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_8 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_8 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_8

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_8 and arg_503_1.time_ < var_506_0 + var_506_8 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play108002127 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 108002127
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play108002128(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1080ui_story = arg_507_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1080ui_story"].transform.position).z)
				arg_507_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1080ui_story"].transform.localEulerAngles = arg_507_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_507_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1080ui_story"].transform.position).z)
				arg_507_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1080ui_story"].transform.localEulerAngles = arg_507_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_510_1 = 0
			local var_510_2 = 0.7

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(108002127).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 28 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 28)

				if (28 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 28)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play108002128 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 108002128
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play108002129(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0.625

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, false)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_1 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(108002128).content)

				arg_511_1.text_.text = var_514_1

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_3 = 25 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 25)

				if (25 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 25)) > 0 and var_514_0 < var_514_3 then
					arg_511_1.talkMaxDuration = var_514_3

					if var_514_3 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_3 + 0
					end
				end

				arg_511_1.text_.text = var_514_1
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_4 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_4

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play108002129 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 108002129
		arg_515_1.duration_ = 2.9

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play108002130(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1080ui_story = arg_515_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1080ui_story"].transform.position).z)
				arg_515_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1080ui_story"].transform.localEulerAngles = arg_515_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_515_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1080ui_story"].transform.position).z)
				arg_515_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1080ui_story"].transform.localEulerAngles = arg_515_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_518_1 = arg_515_1.actors_["1080ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1080ui_story == nil then
				arg_515_1.var_.characterEffect1080ui_story = var_518_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_2 and not isNil(var_518_1) then
				if arg_515_1.var_.characterEffect1080ui_story and not isNil(var_518_1) then
					arg_515_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_2 and arg_515_1.time_ < 0 + var_518_2 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1080ui_story then
				arg_515_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_518_4 = 0
			local var_518_5 = 0.2

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_4 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_6 = arg_515_1:GetWordFromCfg(108002129)
				local var_518_7 = arg_515_1:FormatText(var_518_6.content)

				arg_515_1.text_.text = var_518_7

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_9 = 8 <= 0 and var_518_5 or var_518_5 * (utf8.len(var_518_7) / 8)

				if (8 <= 0 and var_518_5 or var_518_5 * (utf8.len(var_518_7) / 8)) > 0 and var_518_5 < var_518_9 then
					arg_515_1.talkMaxDuration = var_518_9

					if var_518_9 + var_518_4 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_9 + var_518_4
					end
				end

				arg_515_1.text_.text = var_518_7
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002129", "story_v_side_old_108002.awb") ~= 0 then
					local var_518_10 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002129", "story_v_side_old_108002.awb") / 1000

					if var_518_10 + var_518_4 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_10 + var_518_4
					end

					if var_518_6.prefab_name ~= "" and arg_515_1.actors_[var_518_6.prefab_name] ~= nil then
						local var_518_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_6.prefab_name].transform, "story_v_side_old_108002", "108002129", "story_v_side_old_108002.awb")

						arg_515_1:RecordAudio("108002129", var_518_11)
						arg_515_1:RecordAudio("108002129", var_518_11)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002129", "story_v_side_old_108002.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002129", "story_v_side_old_108002.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_12 = math.max(var_518_5, arg_515_1.talkMaxDuration)

			if var_518_4 <= arg_515_1.time_ and arg_515_1.time_ < var_518_4 + var_518_12 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_4) / var_518_12

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_4 + var_518_12 and arg_515_1.time_ < var_518_4 + var_518_12 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play108002130 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 108002130
		arg_519_1.duration_ = 4.4

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play108002131(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_522_0 = 0
			local var_522_1 = 0.375

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_2 = arg_519_1:GetWordFromCfg(108002130)
				local var_522_3 = arg_519_1:FormatText(var_522_2.content)

				arg_519_1.text_.text = var_522_3

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 15 <= 0 and var_522_1 or var_522_1 * (utf8.len(var_522_3) / 15)

				if (15 <= 0 and var_522_1 or var_522_1 * (utf8.len(var_522_3) / 15)) > 0 and var_522_1 < var_522_5 then
					arg_519_1.talkMaxDuration = var_522_5

					if var_522_5 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_5 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_3
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002130", "story_v_side_old_108002.awb") ~= 0 then
					local var_522_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002130", "story_v_side_old_108002.awb") / 1000

					if var_522_6 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_6 + var_522_0
					end

					if var_522_2.prefab_name ~= "" and arg_519_1.actors_[var_522_2.prefab_name] ~= nil then
						local var_522_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_2.prefab_name].transform, "story_v_side_old_108002", "108002130", "story_v_side_old_108002.awb")

						arg_519_1:RecordAudio("108002130", var_522_7)
						arg_519_1:RecordAudio("108002130", var_522_7)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002130", "story_v_side_old_108002.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002130", "story_v_side_old_108002.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_8 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_8 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_8

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_8 and arg_519_1.time_ < var_522_0 + var_522_8 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play108002131 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 108002131
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play108002132(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1080ui_story"]) and arg_523_1.var_.characterEffect1080ui_story == nil then
				arg_523_1.var_.characterEffect1080ui_story = arg_523_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.2

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1080ui_story"]) then
				if arg_523_1.var_.characterEffect1080ui_story and not isNil(arg_523_1.actors_["1080ui_story"]) then
					arg_523_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1080ui_story"]) and arg_523_1.var_.characterEffect1080ui_story then
				arg_523_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.8

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(108002131).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 32 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 32)

				if (32 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 32)) > 0 and var_526_2 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_6 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_6 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_6

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_6 and arg_523_1.time_ < var_526_1 + var_526_6 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play108002132 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 108002132
		arg_527_1.duration_ = 2.2

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play108002133(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_530_0 = 0.225

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 then
				local var_530_1, var_530_2 = math.modf((arg_527_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_530_2 * 0.13, var_530_2 * 0.13, var_530_2 * 0.13) + arg_527_1.var_.shakeOldPos
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 then
				manager.ui.mainCamera.transform.localPosition = arg_527_1.var_.shakeOldPos
			end

			local var_530_3 = 0
			local var_530_4 = 0.225

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_3 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_5 = arg_527_1:GetWordFromCfg(108002132)
				local var_530_6 = arg_527_1:FormatText(var_530_5.content)

				arg_527_1.text_.text = var_530_6

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_8 = 9 <= 0 and var_530_4 or var_530_4 * (utf8.len(var_530_6) / 9)

				if (9 <= 0 and var_530_4 or var_530_4 * (utf8.len(var_530_6) / 9)) > 0 and var_530_4 < var_530_8 then
					arg_527_1.talkMaxDuration = var_530_8

					if var_530_8 + var_530_3 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_3
					end
				end

				arg_527_1.text_.text = var_530_6
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002132", "story_v_side_old_108002.awb") ~= 0 then
					local var_530_9 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002132", "story_v_side_old_108002.awb") / 1000

					if var_530_9 + var_530_3 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_9 + var_530_3
					end

					if var_530_5.prefab_name ~= "" and arg_527_1.actors_[var_530_5.prefab_name] ~= nil then
						local var_530_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_5.prefab_name].transform, "story_v_side_old_108002", "108002132", "story_v_side_old_108002.awb")

						arg_527_1:RecordAudio("108002132", var_530_10)
						arg_527_1:RecordAudio("108002132", var_530_10)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002132", "story_v_side_old_108002.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002132", "story_v_side_old_108002.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_11 = math.max(var_530_4, arg_527_1.talkMaxDuration)

			if var_530_3 <= arg_527_1.time_ and arg_527_1.time_ < var_530_3 + var_530_11 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_3) / var_530_11

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_3 + var_530_11 and arg_527_1.time_ < var_530_3 + var_530_11 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play108002133 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 108002133
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play108002134(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos1080ui_story = arg_531_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_534_0 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				arg_531_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_531_1.time_ - 0) / var_534_0)
				arg_531_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1080ui_story"].transform.position).z)
				arg_531_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1080ui_story"].transform.localEulerAngles = arg_531_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				arg_531_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_531_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1080ui_story"].transform.position).z)
				arg_531_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1080ui_story"].transform.localEulerAngles = arg_531_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_534_1 = 0
			local var_534_2 = 0.475

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_3 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(108002133).content)

				arg_531_1.text_.text = var_534_3

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 19 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_3) / 19)

				if (19 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_3) / 19)) > 0 and var_534_2 < var_534_5 then
					arg_531_1.talkMaxDuration = var_534_5

					if var_534_5 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + var_534_1
					end
				end

				arg_531_1.text_.text = var_534_3
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_6 = math.max(var_534_2, arg_531_1.talkMaxDuration)

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_6 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_1) / var_534_6

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_1 + var_534_6 and arg_531_1.time_ < var_534_1 + var_534_6 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play108002134 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 108002134
		arg_535_1.duration_ = 2.93

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play108002135(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if arg_535_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_538_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_535_1.stage_.transform)

				var_538_0.name = "1027ui_story"
				var_538_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_535_1.actors_["1027ui_story"] = var_538_0

				local var_538_1 = var_538_0:GetComponentInChildren(typeof(CharacterEffect))

				var_538_1.enabled = true

				local var_538_2 = GameObjectTools.GetOrAddComponent(var_538_0, typeof(DynamicBoneHelper))

				if var_538_2 then
					var_538_2:EnableDynamicBone(false)
				end

				arg_535_1:ShowWeapon(var_538_1.transform, false)

				arg_535_1.var_["1027ui_story" .. "Animator"] = var_538_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_535_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_535_1.var_["1027ui_story" .. "LipSync"] = var_538_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_538_3 = arg_535_1.actors_["1027ui_story"].transform

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos1027ui_story = var_538_3.localPosition
			end

			local var_538_4 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 then
				var_538_3.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_535_1.time_ - 0) / var_538_4)
				var_538_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_3.position).x, (manager.ui.mainCamera.transform.position - var_538_3.position).y, (manager.ui.mainCamera.transform.position - var_538_3.position).z)
				var_538_3.localEulerAngles.z = 0
				var_538_3.localEulerAngles.x = 0
				var_538_3.localEulerAngles = var_538_3.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 then
				var_538_3.localPosition = Vector3.New(0, -0.81, -5.8)
				var_538_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_3.position).x, (manager.ui.mainCamera.transform.position - var_538_3.position).y, (manager.ui.mainCamera.transform.position - var_538_3.position).z)
				var_538_3.localEulerAngles.z = 0
				var_538_3.localEulerAngles.x = 0
				var_538_3.localEulerAngles = var_538_3.localEulerAngles
			end

			local var_538_5 = arg_535_1.actors_["1027ui_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_5) and arg_535_1.var_.characterEffect1027ui_story == nil then
				arg_535_1.var_.characterEffect1027ui_story = var_538_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_6 = 0.2

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_6 and not isNil(var_538_5) then
				if arg_535_1.var_.characterEffect1027ui_story and not isNil(var_538_5) then
					arg_535_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_6 and arg_535_1.time_ < 0 + var_538_6 + arg_538_0 and not isNil(var_538_5) and arg_535_1.var_.characterEffect1027ui_story then
				arg_535_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_538_8 = 0
			local var_538_9 = 0.225

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_8 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_10 = arg_535_1:GetWordFromCfg(108002134)
				local var_538_11 = arg_535_1:FormatText(var_538_10.content)

				arg_535_1.text_.text = var_538_11

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_13 = 9 <= 0 and var_538_9 or var_538_9 * (utf8.len(var_538_11) / 9)

				if (9 <= 0 and var_538_9 or var_538_9 * (utf8.len(var_538_11) / 9)) > 0 and var_538_9 < var_538_13 then
					arg_535_1.talkMaxDuration = var_538_13

					if var_538_13 + var_538_8 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_13 + var_538_8
					end
				end

				arg_535_1.text_.text = var_538_11
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002134", "story_v_side_old_108002.awb") ~= 0 then
					local var_538_14 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002134", "story_v_side_old_108002.awb") / 1000

					if var_538_14 + var_538_8 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_14 + var_538_8
					end

					if var_538_10.prefab_name ~= "" and arg_535_1.actors_[var_538_10.prefab_name] ~= nil then
						local var_538_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_10.prefab_name].transform, "story_v_side_old_108002", "108002134", "story_v_side_old_108002.awb")

						arg_535_1:RecordAudio("108002134", var_538_15)
						arg_535_1:RecordAudio("108002134", var_538_15)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002134", "story_v_side_old_108002.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002134", "story_v_side_old_108002.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_16 = math.max(var_538_9, arg_535_1.talkMaxDuration)

			if var_538_8 <= arg_535_1.time_ and arg_535_1.time_ < var_538_8 + var_538_16 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_8) / var_538_16

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_8 + var_538_16 and arg_535_1.time_ < var_538_8 + var_538_16 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play108002135 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 108002135
		arg_539_1.duration_ = 9.6

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
			arg_539_1.auto_ = false
		end

		function arg_539_1.playNext_(arg_541_0)
			arg_539_1.onStoryFinished_()
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action424")
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_542_0 = 0
			local var_542_1 = 0.775

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_2 = arg_539_1:GetWordFromCfg(108002135)
				local var_542_3 = arg_539_1:FormatText(var_542_2.content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 31 <= 0 and var_542_1 or var_542_1 * (utf8.len(var_542_3) / 31)

				if (31 <= 0 and var_542_1 or var_542_1 * (utf8.len(var_542_3) / 31)) > 0 and var_542_1 < var_542_5 then
					arg_539_1.talkMaxDuration = var_542_5

					if var_542_5 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002135", "story_v_side_old_108002.awb") ~= 0 then
					local var_542_6 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002135", "story_v_side_old_108002.awb") / 1000

					if var_542_6 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_6 + var_542_0
					end

					if var_542_2.prefab_name ~= "" and arg_539_1.actors_[var_542_2.prefab_name] ~= nil then
						local var_542_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_2.prefab_name].transform, "story_v_side_old_108002", "108002135", "story_v_side_old_108002.awb")

						arg_539_1:RecordAudio("108002135", var_542_7)
						arg_539_1:RecordAudio("108002135", var_542_7)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002135", "story_v_side_old_108002.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002135", "story_v_side_old_108002.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_8 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_8 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_8

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_8 and arg_539_1.time_ < var_542_0 + var_542_8 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play108002047 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 108002047
		arg_543_1.duration_ = 2

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play108002048(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1039ui_story"]) and arg_543_1.var_.characterEffect1039ui_story == nil then
				arg_543_1.var_.characterEffect1039ui_story = arg_543_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.2

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1039ui_story"]) then
				if arg_543_1.var_.characterEffect1039ui_story and not isNil(arg_543_1.actors_["1039ui_story"]) then
					arg_543_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1039ui_story"]) and arg_543_1.var_.characterEffect1039ui_story then
				arg_543_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_546_2 = "1039ui_story"

			if arg_543_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_546_3 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_543_1.stage_.transform)

				var_546_3.name = var_546_2
				var_546_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_543_1.actors_[var_546_2] = var_546_3

				local var_546_4 = var_546_3:GetComponentInChildren(typeof(CharacterEffect))

				var_546_4.enabled = true

				local var_546_5 = GameObjectTools.GetOrAddComponent(var_546_3, typeof(DynamicBoneHelper))

				if var_546_5 then
					var_546_5:EnableDynamicBone(false)
				end

				arg_543_1:ShowWeapon(var_546_4.transform, false)

				arg_543_1.var_[var_546_2 .. "Animator"] = var_546_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_543_1.var_[var_546_2 .. "Animator"].applyRootMotion = true
				arg_543_1.var_[var_546_2 .. "LipSync"] = var_546_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_546_6 = 0
			local var_546_7 = 0.375

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_6 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_8 = arg_543_1:GetWordFromCfg(108002047)
				local var_546_9 = arg_543_1:FormatText(var_546_8.content)

				arg_543_1.text_.text = var_546_9

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_11 = 15 <= 0 and var_546_7 or var_546_7 * (utf8.len(var_546_9) / 15)

				if (15 <= 0 and var_546_7 or var_546_7 * (utf8.len(var_546_9) / 15)) > 0 and var_546_7 < var_546_11 then
					arg_543_1.talkMaxDuration = var_546_11

					if var_546_11 + var_546_6 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_11 + var_546_6
					end
				end

				arg_543_1.text_.text = var_546_9
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_108002", "108002047", "story_v_side_old_108002.awb") ~= 0 then
					local var_546_12 = manager.audio:GetVoiceLength("story_v_side_old_108002", "108002047", "story_v_side_old_108002.awb") / 1000

					if var_546_12 + var_546_6 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_12 + var_546_6
					end

					if var_546_8.prefab_name ~= "" and arg_543_1.actors_[var_546_8.prefab_name] ~= nil then
						local var_546_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_8.prefab_name].transform, "story_v_side_old_108002", "108002047", "story_v_side_old_108002.awb")

						arg_543_1:RecordAudio("108002047", var_546_13)
						arg_543_1:RecordAudio("108002047", var_546_13)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_old_108002", "108002047", "story_v_side_old_108002.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_old_108002", "108002047", "story_v_side_old_108002.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_14 = math.max(var_546_7, arg_543_1.talkMaxDuration)

			if var_546_6 <= arg_543_1.time_ and arg_543_1.time_ < var_546_6 + var_546_14 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_6) / var_546_14

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_6 + var_546_14 and arg_543_1.time_ < var_546_6 + var_546_14 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/ST14"
	},
	voices = {
		"story_v_side_old_108002.awb"
	}
}
