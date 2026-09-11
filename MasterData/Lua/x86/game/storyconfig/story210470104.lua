return {
	Play1104704001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104704001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104704002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST22a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22a")
				var_4_0.name = "ST22a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22a

				arg_1_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1104704001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 32 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 32)

				if (32 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 32)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1104704002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1104704002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1104704003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.025

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1104704002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 41 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 41)

				if (41 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 41)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1104704003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1104704003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1104704004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.3

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1104704003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 12 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 12)

				if (12 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 12)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1104704004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1104704004
		arg_16_1.duration_ = 2.07

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1104704005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1047ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1047ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1047ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1047ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1047ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1047ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = arg_16_1.actors_["1047ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1047ui_story == nil then
				arg_16_1.var_.characterEffect1047ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1047ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1047ui_story then
				arg_16_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_8 = 0
			local var_19_9 = 0.2

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(1104704004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 8 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 8)

				if (8 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 8)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb")

						arg_16_1:RecordAudio("1104704004", var_19_15)
						arg_16_1:RecordAudio("1104704004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704004", "story_v_side_new_1104704.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play1104704005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1104704005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1104704006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1047ui_story"]) and arg_20_1.var_.characterEffect1047ui_story == nil then
				arg_20_1.var_.characterEffect1047ui_story = arg_20_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1047ui_story"]) then
				if arg_20_1.var_.characterEffect1047ui_story and not isNil(arg_20_1.actors_["1047ui_story"]) then
					arg_20_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1047ui_story"]) and arg_20_1.var_.characterEffect1047ui_story then
				arg_20_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_23_1 = arg_20_1.actors_["1047ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1047ui_story = var_23_1.localPosition
			end

			local var_23_2 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_2 then
				var_23_1.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_2)
				var_23_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_1.position).x, (manager.ui.mainCamera.transform.position - var_23_1.position).y, (manager.ui.mainCamera.transform.position - var_23_1.position).z)
				var_23_1.localEulerAngles.z = 0
				var_23_1.localEulerAngles.x = 0
				var_23_1.localEulerAngles = var_23_1.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_2 and arg_20_1.time_ < 0 + var_23_2 + arg_23_0 then
				var_23_1.localPosition = Vector3.New(0, 100, 0)
				var_23_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_1.position).x, (manager.ui.mainCamera.transform.position - var_23_1.position).y, (manager.ui.mainCamera.transform.position - var_23_1.position).z)
				var_23_1.localEulerAngles.z = 0
				var_23_1.localEulerAngles.x = 0
				var_23_1.localEulerAngles = var_23_1.localEulerAngles
			end

			local var_23_3 = 0
			local var_23_4 = 0.675

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_5 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(1104704005).content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 27 <= 0 and var_23_4 or var_23_4 * (utf8.len(var_23_5) / 27)

				if (27 <= 0 and var_23_4 or var_23_4 * (utf8.len(var_23_5) / 27)) > 0 and var_23_4 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_3 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_3
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_4, arg_20_1.talkMaxDuration)

			if var_23_3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_3 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_3) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_3 + var_23_8 and arg_20_1.time_ < var_23_3 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play1104704006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1104704006
		arg_24_1.duration_ = 5.1

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1104704007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1047ui_story = arg_24_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_27_0 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				arg_24_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1047ui_story"].transform.position).z)
				arg_24_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1047ui_story"].transform.localEulerAngles = arg_24_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				arg_24_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_24_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1047ui_story"].transform.position).z)
				arg_24_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1047ui_story"].transform.localEulerAngles = arg_24_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_27_1 = arg_24_1.actors_["1047ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1047ui_story == nil then
				arg_24_1.var_.characterEffect1047ui_story = var_27_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 and not isNil(var_27_1) then
				if arg_24_1.var_.characterEffect1047ui_story and not isNil(var_27_1) then
					arg_24_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1047ui_story then
				arg_24_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_4 = 0
			local var_27_5 = 0.425

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(1104704006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 17 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 17)

				if (17 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 17)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb")

						arg_24_1:RecordAudio("1104704006", var_27_11)
						arg_24_1:RecordAudio("1104704006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704006", "story_v_side_new_1104704.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_12 and arg_24_1.time_ < var_27_4 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play1104704007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1104704007
		arg_28_1.duration_ = 1

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"

			SetActive(arg_28_1.choicesGo_, true)

			for iter_29_0, iter_29_1 in ipairs(arg_28_1.choices_) do
				SetActive(iter_29_1.go, iter_29_0 <= 1)
			end

			arg_28_1.choices_[1].txt.text = arg_28_1:FormatText(StoryChoiceCfg[1657].name)
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1104704008(arg_28_1)
			end

			arg_28_1:RecordChoiceLog(1104704007, 1657)
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) and arg_28_1.var_.characterEffect1047ui_story == nil then
				arg_28_1.var_.characterEffect1047ui_story = arg_28_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) then
				if arg_28_1.var_.characterEffect1047ui_story and not isNil(arg_28_1.actors_["1047ui_story"]) then
					arg_28_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) and arg_28_1.var_.characterEffect1047ui_story then
				arg_28_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1104704008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1104704008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1104704009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1047ui_story = arg_32_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1047ui_story"].transform.position).z)
				arg_32_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1047ui_story"].transform.localEulerAngles = arg_32_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1047ui_story"].transform.position).z)
				arg_32_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1047ui_story"].transform.localEulerAngles = arg_32_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_35_1 = 0
			local var_35_2 = 0.375

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(1104704008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 15 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 15)

				if (15 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 15)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play1104704009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1104704009
		arg_36_1.duration_ = 4.17

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1104704010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1047ui_story = arg_36_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1047ui_story"].transform.position).z)
				arg_36_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1047ui_story"].transform.localEulerAngles = arg_36_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_36_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1047ui_story"].transform.position).z)
				arg_36_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1047ui_story"].transform.localEulerAngles = arg_36_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1047ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1047ui_story == nil then
				arg_36_1.var_.characterEffect1047ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 and not isNil(var_39_1) then
				if arg_36_1.var_.characterEffect1047ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1047ui_story then
				arg_36_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action476")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_4 = 0
			local var_39_5 = 0.375

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(1104704009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 15 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 15)

				if (15 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 15)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb")

						arg_36_1:RecordAudio("1104704009", var_39_11)
						arg_36_1:RecordAudio("1104704009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704009", "story_v_side_new_1104704.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play1104704010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1104704010
		arg_40_1.duration_ = 1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"

			SetActive(arg_40_1.choicesGo_, true)

			for iter_41_0, iter_41_1 in ipairs(arg_40_1.choices_) do
				SetActive(iter_41_1.go, iter_41_0 <= 1)
			end

			arg_40_1.choices_[1].txt.text = arg_40_1:FormatText(StoryChoiceCfg[1658].name)
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1104704011(arg_40_1)
			end

			arg_40_1:RecordChoiceLog(1104704010, 1658)
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) and arg_40_1.var_.characterEffect1047ui_story == nil then
				arg_40_1.var_.characterEffect1047ui_story = arg_40_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) then
				if arg_40_1.var_.characterEffect1047ui_story and not isNil(arg_40_1.actors_["1047ui_story"]) then
					arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) and arg_40_1.var_.characterEffect1047ui_story then
				arg_40_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1104704011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1104704011
		arg_44_1.duration_ = 5.57

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1104704012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1047ui_story = arg_44_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1047ui_story"].transform.position).z)
				arg_44_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1047ui_story"].transform.localEulerAngles = arg_44_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_44_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1047ui_story"].transform.position).z)
				arg_44_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1047ui_story"].transform.localEulerAngles = arg_44_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1047ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1047ui_story == nil then
				arg_44_1.var_.characterEffect1047ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1047ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1047ui_story then
				arg_44_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.5

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(1104704011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 20 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 20)

				if (20 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 20)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb")

						arg_44_1:RecordAudio("1104704011", var_47_11)
						arg_44_1:RecordAudio("1104704011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704011", "story_v_side_new_1104704.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play1104704012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1104704012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1104704013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1047ui_story"]) and arg_48_1.var_.characterEffect1047ui_story == nil then
				arg_48_1.var_.characterEffect1047ui_story = arg_48_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1047ui_story"]) then
				if arg_48_1.var_.characterEffect1047ui_story and not isNil(arg_48_1.actors_["1047ui_story"]) then
					arg_48_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1047ui_story"]) and arg_48_1.var_.characterEffect1047ui_story then
				arg_48_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_51_1 = arg_48_1.actors_["1047ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1047ui_story = var_51_1.localPosition
			end

			local var_51_2 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 then
				var_51_1.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_2)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 then
				var_51_1.localPosition = Vector3.New(0, 100, 0)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			local var_51_3 = 0
			local var_51_4 = 0.375

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_3 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1104704012).content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 15 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_5) / 15)

				if (15 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_5) / 15)) > 0 and var_51_4 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_3 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_3
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_4, arg_48_1.talkMaxDuration)

			if var_51_3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_3 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_3) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_3 + var_51_8 and arg_48_1.time_ < var_51_3 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play1104704013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1104704013
		arg_52_1.duration_ = 2.2

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1104704014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1047ui_story = arg_52_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).z)
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles = arg_52_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_52_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).z)
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles = arg_52_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1047ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1047ui_story == nil then
				arg_52_1.var_.characterEffect1047ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1047ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1047ui_story then
				arg_52_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(1104704013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 4 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 4)

				if (4 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 4)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb")

						arg_52_1:RecordAudio("1104704013", var_55_11)
						arg_52_1:RecordAudio("1104704013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704013", "story_v_side_new_1104704.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play1104704014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1104704014
		arg_56_1.duration_ = 2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1104704015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1047ui_story = arg_56_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1047ui_story"].transform.position).z)
				arg_56_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1047ui_story"].transform.localEulerAngles = arg_56_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_56_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1047ui_story"].transform.position).z)
				arg_56_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1047ui_story"].transform.localEulerAngles = arg_56_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_1 = 0
			local var_59_2 = 0.175

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(1104704014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 7 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 7)

				if (7 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 7)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb")

						arg_56_1:RecordAudio("1104704014", var_59_8)
						arg_56_1:RecordAudio("1104704014", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704014", "story_v_side_new_1104704.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_9 and arg_56_1.time_ < var_59_1 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play1104704015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1104704015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1104704016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1047ui_story"]) and arg_60_1.var_.characterEffect1047ui_story == nil then
				arg_60_1.var_.characterEffect1047ui_story = arg_60_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1047ui_story"]) then
				if arg_60_1.var_.characterEffect1047ui_story and not isNil(arg_60_1.actors_["1047ui_story"]) then
					arg_60_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1047ui_story"]) and arg_60_1.var_.characterEffect1047ui_story then
				arg_60_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_63_1 = arg_60_1.actors_["1047ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1047ui_story = var_63_1.localPosition
			end

			local var_63_2 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 then
				var_63_1.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_2)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 then
				var_63_1.localPosition = Vector3.New(0, 100, 0)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			local var_63_3 = 0
			local var_63_4 = 1.275

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_3 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_5 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(1104704015).content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 51 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_5) / 51)

				if (51 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_5) / 51)) > 0 and var_63_4 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_3 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_3
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_4, arg_60_1.talkMaxDuration)

			if var_63_3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_3 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_3) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_3 + var_63_8 and arg_60_1.time_ < var_63_3 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play1104704016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1104704016
		arg_64_1.duration_ = 9.9

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1104704017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1047ui_story = arg_64_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1047ui_story"].transform.position).z)
				arg_64_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1047ui_story"].transform.localEulerAngles = arg_64_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_64_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1047ui_story"].transform.position).z)
				arg_64_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1047ui_story"].transform.localEulerAngles = arg_64_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1047ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1047ui_story == nil then
				arg_64_1.var_.characterEffect1047ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect1047ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1047ui_story then
				arg_64_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action436")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_4 = 0
			local var_67_5 = 0.85

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(1104704016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 34 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 34)

				if (34 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 34)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb")

						arg_64_1:RecordAudio("1104704016", var_67_11)
						arg_64_1:RecordAudio("1104704016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704016", "story_v_side_new_1104704.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play1104704017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1104704017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1104704018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) and arg_68_1.var_.characterEffect1047ui_story == nil then
				arg_68_1.var_.characterEffect1047ui_story = arg_68_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) then
				if arg_68_1.var_.characterEffect1047ui_story and not isNil(arg_68_1.actors_["1047ui_story"]) then
					arg_68_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) and arg_68_1.var_.characterEffect1047ui_story then
				arg_68_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.575

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(1104704017).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 23 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 23)

				if (23 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 23)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1104704018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1104704018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1104704019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.625

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(1104704018).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 25 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 25)

				if (25 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 25)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1104704019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1104704019
		arg_76_1.duration_ = 5.8

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1104704020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1047ui_story = arg_76_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1047ui_story"].transform.position).z)
				arg_76_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1047ui_story"].transform.localEulerAngles = arg_76_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_76_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1047ui_story"].transform.position).z)
				arg_76_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1047ui_story"].transform.localEulerAngles = arg_76_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1047ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1047ui_story == nil then
				arg_76_1.var_.characterEffect1047ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1047ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1047ui_story then
				arg_76_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action464")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_4 = 0
			local var_79_5 = 0.6

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(1104704019)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 24 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 24)

				if (24 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 24)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb")

						arg_76_1:RecordAudio("1104704019", var_79_11)
						arg_76_1:RecordAudio("1104704019", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704019", "story_v_side_new_1104704.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play1104704020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1104704020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1104704021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1047ui_story"]) and arg_80_1.var_.characterEffect1047ui_story == nil then
				arg_80_1.var_.characterEffect1047ui_story = arg_80_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1047ui_story"]) then
				if arg_80_1.var_.characterEffect1047ui_story and not isNil(arg_80_1.actors_["1047ui_story"]) then
					arg_80_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1047ui_story"]) and arg_80_1.var_.characterEffect1047ui_story then
				arg_80_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.65

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(1104704020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 26 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 26)

				if (26 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 26)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1104704021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1104704021
		arg_84_1.duration_ = 3.07

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1104704022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1047ui_story = arg_84_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1047ui_story"].transform.position).z)
				arg_84_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1047ui_story"].transform.localEulerAngles = arg_84_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_84_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1047ui_story"].transform.position).z)
				arg_84_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1047ui_story"].transform.localEulerAngles = arg_84_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["1047ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1047ui_story == nil then
				arg_84_1.var_.characterEffect1047ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 and not isNil(var_87_1) then
				if arg_84_1.var_.characterEffect1047ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1047ui_story then
				arg_84_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action446")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_87_4 = 0
			local var_87_5 = 0.3

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(1104704021)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 12 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 12)

				if (12 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 12)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb")

						arg_84_1:RecordAudio("1104704021", var_87_11)
						arg_84_1:RecordAudio("1104704021", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704021", "story_v_side_new_1104704.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play1104704022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1104704022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1104704023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1047ui_story"]) and arg_88_1.var_.characterEffect1047ui_story == nil then
				arg_88_1.var_.characterEffect1047ui_story = arg_88_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1047ui_story"]) then
				if arg_88_1.var_.characterEffect1047ui_story and not isNil(arg_88_1.actors_["1047ui_story"]) then
					arg_88_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1047ui_story"]) and arg_88_1.var_.characterEffect1047ui_story then
				arg_88_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_91_1 = arg_88_1.actors_["1047ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1047ui_story = var_91_1.localPosition
			end

			local var_91_2 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 then
				var_91_1.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_2)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 then
				var_91_1.localPosition = Vector3.New(0, 100, 0)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			local var_91_3 = 0
			local var_91_4 = 0.525

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(1104704022).content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 21 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_5) / 21)

				if (21 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_5) / 21)) > 0 and var_91_4 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_3
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_4, arg_88_1.talkMaxDuration)

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_3) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_3 + var_91_8 and arg_88_1.time_ < var_91_3 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play1104704023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1104704023
		arg_92_1.duration_ = 6.77

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1104704024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1047ui_story = arg_92_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).z)
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles = arg_92_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_92_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).z)
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles = arg_92_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_95_1 = arg_92_1.actors_["1047ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1047ui_story == nil then
				arg_92_1.var_.characterEffect1047ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 and not isNil(var_95_1) then
				if arg_92_1.var_.characterEffect1047ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1047ui_story then
				arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_95_4 = 0
			local var_95_5 = 0.8

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(1104704023)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 32 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 32)

				if (32 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 32)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb")

						arg_92_1:RecordAudio("1104704023", var_95_11)
						arg_92_1:RecordAudio("1104704023", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704023", "story_v_side_new_1104704.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_12 and arg_92_1.time_ < var_95_4 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play1104704024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1104704024
		arg_96_1.duration_ = 4.4

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1104704025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1047ui_story = arg_96_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1047ui_story"].transform.position).z)
				arg_96_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1047ui_story"].transform.localEulerAngles = arg_96_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_96_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1047ui_story"].transform.position).z)
				arg_96_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1047ui_story"].transform.localEulerAngles = arg_96_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_1 = 0
			local var_99_2 = 0.45

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:GetWordFromCfg(1104704024)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_6 = 18 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_4) / 18)

				if (18 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_4) / 18)) > 0 and var_99_2 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb") ~= 0 then
					local var_99_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb") / 1000

					if var_99_7 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_1
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb")

						arg_96_1:RecordAudio("1104704024", var_99_8)
						arg_96_1:RecordAudio("1104704024", var_99_8)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704024", "story_v_side_new_1104704.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_9 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_9 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_9

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_9 and arg_96_1.time_ < var_99_1 + var_99_9 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play1104704025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1104704025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1104704026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) and arg_100_1.var_.characterEffect1047ui_story == nil then
				arg_100_1.var_.characterEffect1047ui_story = arg_100_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) then
				if arg_100_1.var_.characterEffect1047ui_story and not isNil(arg_100_1.actors_["1047ui_story"]) then
					arg_100_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) and arg_100_1.var_.characterEffect1047ui_story then
				arg_100_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.55

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(1104704025).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 22 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 22)

				if (22 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 22)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1104704026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1104704026
		arg_104_1.duration_ = 5.93

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1104704027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1047ui_story"]) and arg_104_1.var_.characterEffect1047ui_story == nil then
				arg_104_1.var_.characterEffect1047ui_story = arg_104_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1047ui_story"]) then
				if arg_104_1.var_.characterEffect1047ui_story and not isNil(arg_104_1.actors_["1047ui_story"]) then
					arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1047ui_story"]) and arg_104_1.var_.characterEffect1047ui_story then
				arg_104_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_2 = 0
			local var_107_3 = 0.575

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:GetWordFromCfg(1104704026)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 23 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 23)

				if (23 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 23)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb")

						arg_104_1:RecordAudio("1104704026", var_107_9)
						arg_104_1:RecordAudio("1104704026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704026", "story_v_side_new_1104704.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1104704027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1104704027
		arg_108_1.duration_ = 5.63

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1104704028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.675

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(1104704027)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 27 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 27)

				if (27 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 27)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb")

						arg_108_1:RecordAudio("1104704027", var_111_6)
						arg_108_1:RecordAudio("1104704027", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704027", "story_v_side_new_1104704.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1104704028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1104704028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1104704029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) and arg_112_1.var_.characterEffect1047ui_story == nil then
				arg_112_1.var_.characterEffect1047ui_story = arg_112_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) then
				if arg_112_1.var_.characterEffect1047ui_story and not isNil(arg_112_1.actors_["1047ui_story"]) then
					arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) and arg_112_1.var_.characterEffect1047ui_story then
				arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_115_1 = arg_112_1.actors_["1047ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1047ui_story = var_115_1.localPosition
			end

			local var_115_2 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 then
				var_115_1.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_2)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 then
				var_115_1.localPosition = Vector3.New(0, 100, 0)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			local var_115_3 = 0
			local var_115_4 = 0.125

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_3 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_5 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(1104704028).content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 5 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 5)

				if (5 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 5)) > 0 and var_115_4 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_3 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_3
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_4, arg_112_1.talkMaxDuration)

			if var_115_3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_3 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_3) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_3 + var_115_8 and arg_112_1.time_ < var_115_3 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play1104704029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1104704029
		arg_116_1.duration_ = 5.63

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1104704030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1047ui_story = arg_116_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).z)
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles = arg_116_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_116_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1047ui_story"].transform.position).z)
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1047ui_story"].transform.localEulerAngles = arg_116_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1047ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1047ui_story == nil then
				arg_116_1.var_.characterEffect1047ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1047ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1047ui_story then
				arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_119_4 = 0
			local var_119_5 = 0.625

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(1104704029)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 25 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 25)

				if (25 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 25)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb")

						arg_116_1:RecordAudio("1104704029", var_119_11)
						arg_116_1:RecordAudio("1104704029", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704029", "story_v_side_new_1104704.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play1104704030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1104704030
		arg_120_1.duration_ = 10.13

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1104704031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.075

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(1104704030)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 43 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 43)

				if (43 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 43)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb")

						arg_120_1:RecordAudio("1104704030", var_123_6)
						arg_120_1:RecordAudio("1104704030", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704030", "story_v_side_new_1104704.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1104704031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1104704031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1104704032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1047ui_story"]) and arg_124_1.var_.characterEffect1047ui_story == nil then
				arg_124_1.var_.characterEffect1047ui_story = arg_124_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1047ui_story"]) then
				if arg_124_1.var_.characterEffect1047ui_story and not isNil(arg_124_1.actors_["1047ui_story"]) then
					arg_124_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1047ui_story"]) and arg_124_1.var_.characterEffect1047ui_story then
				arg_124_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_127_1 = 0
			local var_127_2 = 0.525

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(1104704031).content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 21 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 21)

				if (21 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 21)) > 0 and var_127_2 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_6 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_6 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_6

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_6 and arg_124_1.time_ < var_127_1 + var_127_6 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1104704032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1104704032
		arg_128_1.duration_ = 4

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1104704033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1047ui_story = arg_128_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).z)
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles = arg_128_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_128_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1047ui_story"].transform.position).z)
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1047ui_story"].transform.localEulerAngles = arg_128_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["1047ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1047ui_story == nil then
				arg_128_1.var_.characterEffect1047ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1047ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1047ui_story then
				arg_128_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action437")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_4 = 0
			local var_131_5 = 0.45

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(1104704032)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 18 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 18)

				if (18 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 18)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb")

						arg_128_1:RecordAudio("1104704032", var_131_11)
						arg_128_1:RecordAudio("1104704032", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704032", "story_v_side_new_1104704.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play1104704033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1104704033
		arg_132_1.duration_ = 12.5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1104704034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1047ui_story = arg_132_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1047ui_story"].transform.position).z)
				arg_132_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1047ui_story"].transform.localEulerAngles = arg_132_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_132_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1047ui_story"].transform.position).z)
				arg_132_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1047ui_story"].transform.localEulerAngles = arg_132_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_1 = 0
			local var_135_2 = 1.475

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(1104704033)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 59 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 59)

				if (59 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 59)) > 0 and var_135_2 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb") ~= 0 then
					local var_135_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb") / 1000

					if var_135_7 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_1
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb")

						arg_132_1:RecordAudio("1104704033", var_135_8)
						arg_132_1:RecordAudio("1104704033", var_135_8)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704033", "story_v_side_new_1104704.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_9 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_9 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_9

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_9 and arg_132_1.time_ < var_135_1 + var_135_9 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play1104704034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1104704034
		arg_136_1.duration_ = 5.7

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1104704035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.55

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:GetWordFromCfg(1104704034)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 22 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 22)

				if (22 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 22)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb")

						arg_136_1:RecordAudio("1104704034", var_139_6)
						arg_136_1:RecordAudio("1104704034", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704034", "story_v_side_new_1104704.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1104704035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1104704035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1104704036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) and arg_140_1.var_.characterEffect1047ui_story == nil then
				arg_140_1.var_.characterEffect1047ui_story = arg_140_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) then
				if arg_140_1.var_.characterEffect1047ui_story and not isNil(arg_140_1.actors_["1047ui_story"]) then
					arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1047ui_story"]) and arg_140_1.var_.characterEffect1047ui_story then
				arg_140_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.05

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1104704035).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 2 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 2)

				if (2 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 2)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1104704036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1104704036
		arg_144_1.duration_ = 17.5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1104704037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1047ui_story"]) and arg_144_1.var_.characterEffect1047ui_story == nil then
				arg_144_1.var_.characterEffect1047ui_story = arg_144_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1047ui_story"]) then
				if arg_144_1.var_.characterEffect1047ui_story and not isNil(arg_144_1.actors_["1047ui_story"]) then
					arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1047ui_story"]) and arg_144_1.var_.characterEffect1047ui_story then
				arg_144_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_147_2 = 0
			local var_147_3 = 1.6

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(1104704036)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 64 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 64)

				if (64 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 64)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb")

						arg_144_1:RecordAudio("1104704036", var_147_9)
						arg_144_1:RecordAudio("1104704036", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704036", "story_v_side_new_1104704.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1104704037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1104704037
		arg_148_1.duration_ = 5.3

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1104704038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1047ui_story = arg_148_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1047ui_story"].transform.position).z)
				arg_148_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1047ui_story"].transform.localEulerAngles = arg_148_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_148_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1047ui_story"].transform.position).z)
				arg_148_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1047ui_story"].transform.localEulerAngles = arg_148_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_151_1 = 0
			local var_151_2 = 0.6

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(1104704037)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 24 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 24)

				if (24 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 24)) > 0 and var_151_2 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb") ~= 0 then
					local var_151_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb") / 1000

					if var_151_7 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_1
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb")

						arg_148_1:RecordAudio("1104704037", var_151_8)
						arg_148_1:RecordAudio("1104704037", var_151_8)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704037", "story_v_side_new_1104704.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_9 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_9 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_9

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_9 and arg_148_1.time_ < var_151_1 + var_151_9 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play1104704038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1104704038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1104704039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1047ui_story"]) and arg_152_1.var_.characterEffect1047ui_story == nil then
				arg_152_1.var_.characterEffect1047ui_story = arg_152_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1047ui_story"]) then
				if arg_152_1.var_.characterEffect1047ui_story and not isNil(arg_152_1.actors_["1047ui_story"]) then
					arg_152_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_0)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1047ui_story"]) and arg_152_1.var_.characterEffect1047ui_story then
				arg_152_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_155_1 = 0
			local var_155_2 = 0.3

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(1104704038).content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 12 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 12)

				if (12 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 12)) > 0 and var_155_2 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_6 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_6 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_6

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_6 and arg_152_1.time_ < var_155_1 + var_155_6 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1104704039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1104704039
		arg_156_1.duration_ = 4.77

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1104704040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1047ui_story = arg_156_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).z)
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles = arg_156_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_156_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1047ui_story"].transform.position).z)
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1047ui_story"].transform.localEulerAngles = arg_156_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1047ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1047ui_story == nil then
				arg_156_1.var_.characterEffect1047ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1047ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1047ui_story then
				arg_156_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action464")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_159_4 = 0
			local var_159_5 = 0.4

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(1104704039)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 16 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 16)

				if (16 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 16)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb")

						arg_156_1:RecordAudio("1104704039", var_159_11)
						arg_156_1:RecordAudio("1104704039", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704039", "story_v_side_new_1104704.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_12 and arg_156_1.time_ < var_159_4 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play1104704040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1104704040
		arg_160_1.duration_ = 5.13

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1104704041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1047ui_story = arg_160_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1047ui_story"].transform.position).z)
				arg_160_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1047ui_story"].transform.localEulerAngles = arg_160_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_160_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1047ui_story"].transform.position).z)
				arg_160_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1047ui_story"].transform.localEulerAngles = arg_160_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_163_1 = 0
			local var_163_2 = 0.475

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(1104704040)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_6 = 19 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_4) / 19)

				if (19 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_4) / 19)) > 0 and var_163_2 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb") ~= 0 then
					local var_163_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb") / 1000

					if var_163_7 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_1
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb")

						arg_160_1:RecordAudio("1104704040", var_163_8)
						arg_160_1:RecordAudio("1104704040", var_163_8)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704040", "story_v_side_new_1104704.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_9 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_9 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_9

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_9 and arg_160_1.time_ < var_163_1 + var_163_9 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play1104704041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1104704041
		arg_164_1.duration_ = 4.67

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1104704042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.525

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:GetWordFromCfg(1104704041)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 21 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 21)

				if (21 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 21)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb")

						arg_164_1:RecordAudio("1104704041", var_167_6)
						arg_164_1:RecordAudio("1104704041", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704041", "story_v_side_new_1104704.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1104704042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1104704042
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1104704043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1047ui_story"]) and arg_168_1.var_.characterEffect1047ui_story == nil then
				arg_168_1.var_.characterEffect1047ui_story = arg_168_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1047ui_story"]) then
				if arg_168_1.var_.characterEffect1047ui_story and not isNil(arg_168_1.actors_["1047ui_story"]) then
					arg_168_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_0)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1047ui_story"]) and arg_168_1.var_.characterEffect1047ui_story then
				arg_168_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_171_1 = 0
			local var_171_2 = 0.25

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_3 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(1104704042).content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 10 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 10)

				if (10 <= 0 and var_171_2 or var_171_2 * (utf8.len(var_171_3) / 10)) > 0 and var_171_2 < var_171_5 then
					arg_168_1.talkMaxDuration = var_171_5

					if var_171_5 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + var_171_1
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_6 = math.max(var_171_2, arg_168_1.talkMaxDuration)

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_6 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_1) / var_171_6

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_1 + var_171_6 and arg_168_1.time_ < var_171_1 + var_171_6 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1104704043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1104704043
		arg_172_1.duration_ = 2

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1104704044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1047ui_story = arg_172_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_175_0 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 then
				arg_172_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_172_1.time_ - 0) / var_175_0)
				arg_172_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1047ui_story"].transform.position).z)
				arg_172_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1047ui_story"].transform.localEulerAngles = arg_172_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 then
				arg_172_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_172_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1047ui_story"].transform.position).z)
				arg_172_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1047ui_story"].transform.localEulerAngles = arg_172_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_175_1 = arg_172_1.actors_["1047ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1047ui_story == nil then
				arg_172_1.var_.characterEffect1047ui_story = var_175_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 and not isNil(var_175_1) then
				if arg_172_1.var_.characterEffect1047ui_story and not isNil(var_175_1) then
					arg_172_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1047ui_story then
				arg_172_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_175_4 = 0
			local var_175_5 = 0.05

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:GetWordFromCfg(1104704043)
				local var_175_7 = arg_172_1:FormatText(var_175_6.content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 2 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 2)

				if (2 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 2)) > 0 and var_175_5 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb") ~= 0 then
					local var_175_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb") / 1000

					if var_175_10 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_4
					end

					if var_175_6.prefab_name ~= "" and arg_172_1.actors_[var_175_6.prefab_name] ~= nil then
						local var_175_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_6.prefab_name].transform, "story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb")

						arg_172_1:RecordAudio("1104704043", var_175_11)
						arg_172_1:RecordAudio("1104704043", var_175_11)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704043", "story_v_side_new_1104704.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_12 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_12 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_12

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_12 and arg_172_1.time_ < var_175_4 + var_175_12 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1104704044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1104704044
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1104704045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1047ui_story"]) and arg_176_1.var_.characterEffect1047ui_story == nil then
				arg_176_1.var_.characterEffect1047ui_story = arg_176_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1047ui_story"]) then
				if arg_176_1.var_.characterEffect1047ui_story and not isNil(arg_176_1.actors_["1047ui_story"]) then
					arg_176_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_0)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1047ui_story"]) and arg_176_1.var_.characterEffect1047ui_story then
				arg_176_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_179_1 = arg_176_1.actors_["1047ui_story"].transform

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1047ui_story = var_179_1.localPosition
			end

			local var_179_2 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 then
				var_179_1.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_176_1.time_ - 0) / var_179_2)
				var_179_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_1.position).x, (manager.ui.mainCamera.transform.position - var_179_1.position).y, (manager.ui.mainCamera.transform.position - var_179_1.position).z)
				var_179_1.localEulerAngles.z = 0
				var_179_1.localEulerAngles.x = 0
				var_179_1.localEulerAngles = var_179_1.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 then
				var_179_1.localPosition = Vector3.New(0, 100, 0)
				var_179_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_179_1.position).x, (manager.ui.mainCamera.transform.position - var_179_1.position).y, (manager.ui.mainCamera.transform.position - var_179_1.position).z)
				var_179_1.localEulerAngles.z = 0
				var_179_1.localEulerAngles.x = 0
				var_179_1.localEulerAngles = var_179_1.localEulerAngles
			end

			local var_179_3 = 0
			local var_179_4 = 0.55

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_3 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_5 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(1104704044).content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 22 <= 0 and var_179_4 or var_179_4 * (utf8.len(var_179_5) / 22)

				if (22 <= 0 and var_179_4 or var_179_4 * (utf8.len(var_179_5) / 22)) > 0 and var_179_4 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_3 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_3
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_8 = math.max(var_179_4, arg_176_1.talkMaxDuration)

			if var_179_3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_3 + var_179_8 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_3) / var_179_8

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_3 + var_179_8 and arg_176_1.time_ < var_179_3 + var_179_8 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play1104704045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1104704045
		arg_180_1.duration_ = 6.63

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1104704046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1047ui_story = arg_180_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1047ui_story"].transform.position).z)
				arg_180_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1047ui_story"].transform.localEulerAngles = arg_180_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_180_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1047ui_story"].transform.position).z)
				arg_180_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1047ui_story"].transform.localEulerAngles = arg_180_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["1047ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1047ui_story == nil then
				arg_180_1.var_.characterEffect1047ui_story = var_183_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 and not isNil(var_183_1) then
				if arg_180_1.var_.characterEffect1047ui_story and not isNil(var_183_1) then
					arg_180_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1047ui_story then
				arg_180_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_183_4 = 0
			local var_183_5 = 0.575

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_6 = arg_180_1:GetWordFromCfg(1104704045)
				local var_183_7 = arg_180_1:FormatText(var_183_6.content)

				arg_180_1.text_.text = var_183_7

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_9 = 23 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 23)

				if (23 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 23)) > 0 and var_183_5 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_4
					end
				end

				arg_180_1.text_.text = var_183_7
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb") / 1000

					if var_183_10 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_4
					end

					if var_183_6.prefab_name ~= "" and arg_180_1.actors_[var_183_6.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_6.prefab_name].transform, "story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb")

						arg_180_1:RecordAudio("1104704045", var_183_11)
						arg_180_1:RecordAudio("1104704045", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704045", "story_v_side_new_1104704.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_5, arg_180_1.talkMaxDuration)

			if var_183_4 <= arg_180_1.time_ and arg_180_1.time_ < var_183_4 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_4) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_4 + var_183_12 and arg_180_1.time_ < var_183_4 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play1104704046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1104704046
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1104704047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1047ui_story"]) and arg_184_1.var_.characterEffect1047ui_story == nil then
				arg_184_1.var_.characterEffect1047ui_story = arg_184_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1047ui_story"]) then
				if arg_184_1.var_.characterEffect1047ui_story and not isNil(arg_184_1.actors_["1047ui_story"]) then
					arg_184_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1047ui_story"]) and arg_184_1.var_.characterEffect1047ui_story then
				arg_184_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_187_1 = arg_184_1.actors_["1047ui_story"].transform

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos1047ui_story = var_187_1.localPosition
			end

			local var_187_2 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_2 then
				var_187_1.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_184_1.time_ - 0) / var_187_2)
				var_187_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_1.position).x, (manager.ui.mainCamera.transform.position - var_187_1.position).y, (manager.ui.mainCamera.transform.position - var_187_1.position).z)
				var_187_1.localEulerAngles.z = 0
				var_187_1.localEulerAngles.x = 0
				var_187_1.localEulerAngles = var_187_1.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_2 and arg_184_1.time_ < 0 + var_187_2 + arg_187_0 then
				var_187_1.localPosition = Vector3.New(0, 100, 0)
				var_187_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_187_1.position).x, (manager.ui.mainCamera.transform.position - var_187_1.position).y, (manager.ui.mainCamera.transform.position - var_187_1.position).z)
				var_187_1.localEulerAngles.z = 0
				var_187_1.localEulerAngles.x = 0
				var_187_1.localEulerAngles = var_187_1.localEulerAngles
			end

			local var_187_3 = 0
			local var_187_4 = 0.075

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_3 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_5 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(1104704046).content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 3 <= 0 and var_187_4 or var_187_4 * (utf8.len(var_187_5) / 3)

				if (3 <= 0 and var_187_4 or var_187_4 * (utf8.len(var_187_5) / 3)) > 0 and var_187_4 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_3 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_3
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_8 = math.max(var_187_4, arg_184_1.talkMaxDuration)

			if var_187_3 <= arg_184_1.time_ and arg_184_1.time_ < var_187_3 + var_187_8 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_3) / var_187_8

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_3 + var_187_8 and arg_184_1.time_ < var_187_3 + var_187_8 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play1104704047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1104704047
		arg_188_1.duration_ = 1

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"

			SetActive(arg_188_1.choicesGo_, true)

			for iter_189_0, iter_189_1 in ipairs(arg_188_1.choices_) do
				SetActive(iter_189_1.go, iter_189_0 <= 2)
			end

			arg_188_1.choices_[1].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1659].name)
			arg_188_1.choices_[2].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1660].name)
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1104704048(arg_188_1)
			end

			if arg_190_0 == 2 then
				arg_188_0:Play1104704048(arg_188_1)
			end

			arg_188_1:RecordChoiceLog(1104704047, 1659, 1660)
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			if arg_188_1.time_ >= 0 + 1 and arg_188_1.time_ < 0 + 1 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1104704048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1104704048
		arg_192_1.duration_ = 3.7

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1104704049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1047ui_story = arg_192_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_195_0 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 then
				arg_192_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_192_1.time_ - 0) / var_195_0)
				arg_192_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1047ui_story"].transform.position).z)
				arg_192_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1047ui_story"].transform.localEulerAngles = arg_192_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 then
				arg_192_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_192_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1047ui_story"].transform.position).z)
				arg_192_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1047ui_story"].transform.localEulerAngles = arg_192_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_195_1 = arg_192_1.actors_["1047ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_1) and arg_192_1.var_.characterEffect1047ui_story == nil then
				arg_192_1.var_.characterEffect1047ui_story = var_195_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_2 and not isNil(var_195_1) then
				if arg_192_1.var_.characterEffect1047ui_story and not isNil(var_195_1) then
					arg_192_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_2 and arg_192_1.time_ < 0 + var_195_2 + arg_195_0 and not isNil(var_195_1) and arg_192_1.var_.characterEffect1047ui_story then
				arg_192_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_195_4 = "1047ui_story"

			if arg_192_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_195_5 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_192_1.stage_.transform)

				var_195_5.name = var_195_4
				var_195_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_[var_195_4] = var_195_5

				local var_195_6 = var_195_5:GetComponentInChildren(typeof(CharacterEffect))

				var_195_6.enabled = true

				local var_195_7 = GameObjectTools.GetOrAddComponent(var_195_5, typeof(DynamicBoneHelper))

				if var_195_7 then
					var_195_7:EnableDynamicBone(false)
				end

				arg_192_1:ShowWeapon(var_195_6.transform, false)

				arg_192_1.var_[var_195_4 .. "Animator"] = var_195_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_192_1.var_[var_195_4 .. "Animator"].applyRootMotion = true
				arg_192_1.var_[var_195_4 .. "LipSync"] = var_195_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_195_8 = "1047ui_story"

			if arg_192_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_195_9 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_192_1.stage_.transform)

				var_195_9.name = var_195_8
				var_195_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_[var_195_8] = var_195_9

				local var_195_10 = var_195_9:GetComponentInChildren(typeof(CharacterEffect))

				var_195_10.enabled = true

				local var_195_11 = GameObjectTools.GetOrAddComponent(var_195_9, typeof(DynamicBoneHelper))

				if var_195_11 then
					var_195_11:EnableDynamicBone(false)
				end

				arg_192_1:ShowWeapon(var_195_10.transform, false)

				arg_192_1.var_[var_195_8 .. "Animator"] = var_195_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_192_1.var_[var_195_8 .. "Animator"].applyRootMotion = true
				arg_192_1.var_[var_195_8 .. "LipSync"] = var_195_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_195_12 = 0
			local var_195_13 = 0.275

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_14 = arg_192_1:GetWordFromCfg(1104704048)
				local var_195_15 = arg_192_1:FormatText(var_195_14.content)

				arg_192_1.text_.text = var_195_15

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_17 = 11 <= 0 and var_195_13 or var_195_13 * (utf8.len(var_195_15) / 11)

				if (11 <= 0 and var_195_13 or var_195_13 * (utf8.len(var_195_15) / 11)) > 0 and var_195_13 < var_195_17 then
					arg_192_1.talkMaxDuration = var_195_17

					if var_195_17 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_17 + var_195_12
					end
				end

				arg_192_1.text_.text = var_195_15
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb") ~= 0 then
					local var_195_18 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb") / 1000

					if var_195_18 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_18 + var_195_12
					end

					if var_195_14.prefab_name ~= "" and arg_192_1.actors_[var_195_14.prefab_name] ~= nil then
						local var_195_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_14.prefab_name].transform, "story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb")

						arg_192_1:RecordAudio("1104704048", var_195_19)
						arg_192_1:RecordAudio("1104704048", var_195_19)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704048", "story_v_side_new_1104704.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_20 = math.max(var_195_13, arg_192_1.talkMaxDuration)

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_20 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_12) / var_195_20

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_12 + var_195_20 and arg_192_1.time_ < var_195_12 + var_195_20 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play1104704049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1104704049
		arg_196_1.duration_ = 4.7

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1104704050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_199_0 = 0
			local var_199_1 = 0.5

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_2 = arg_196_1:GetWordFromCfg(1104704049)
				local var_199_3 = arg_196_1:FormatText(var_199_2.content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 20 <= 0 and var_199_1 or var_199_1 * (utf8.len(var_199_3) / 20)

				if (20 <= 0 and var_199_1 or var_199_1 * (utf8.len(var_199_3) / 20)) > 0 and var_199_1 < var_199_5 then
					arg_196_1.talkMaxDuration = var_199_5

					if var_199_5 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb") ~= 0 then
					local var_199_6 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb") / 1000

					if var_199_6 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_0
					end

					if var_199_2.prefab_name ~= "" and arg_196_1.actors_[var_199_2.prefab_name] ~= nil then
						local var_199_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_2.prefab_name].transform, "story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb")

						arg_196_1:RecordAudio("1104704049", var_199_7)
						arg_196_1:RecordAudio("1104704049", var_199_7)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704049", "story_v_side_new_1104704.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_8 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_8 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_8

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_8 and arg_196_1.time_ < var_199_0 + var_199_8 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1104704050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1104704050
		arg_200_1.duration_ = 6.53

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1104704051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_9000

			if arg_200_1.bgs_.ST27a == nil then
				local var_203_0 = Object.Instantiate(arg_200_1.paintGo_)

				var_203_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST27a")
				var_203_0.name = "ST27a"
				var_203_0.transform.parent = arg_200_1.stage_.transform
				var_203_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_200_1.bgs_.ST27a = var_203_0
			end

			if 0.566666666666667 < arg_200_1.time_ and arg_200_1.time_ <= 0.566666666666667 + arg_203_0 then
				local var_203_1 = arg_200_1.bgs_.ST27a

				arg_200_1.bgs_.ST27a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_203_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_203_2 = var_203_1:GetComponent("SpriteRenderer")

				if var_203_2 and var_203_2.sprite then
					local var_203_3 = 2 * (var_203_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_203_1.transform.localScale = Vector3.New(var_203_3 / var_203_2.sprite.bounds.size.y < var_203_3 * manager.ui.mainCameraCom_.aspect / var_203_2.sprite.bounds.size.x and var_203_3 * manager.ui.mainCameraCom_.aspect / var_203_2.sprite.bounds.size.x or var_203_3 / var_203_2.sprite.bounds.size.y, var_203_3 / var_203_2.sprite.bounds.size.y < var_203_3 * manager.ui.mainCameraCom_.aspect / var_203_2.sprite.bounds.size.x and var_203_3 * manager.ui.mainCameraCom_.aspect / var_203_2.sprite.bounds.size.x or var_203_3 / var_203_2.sprite.bounds.size.y, 0)
				end

				for iter_203_0, iter_203_1 in pairs(arg_200_1.bgs_) do
					if iter_203_0 ~= "ST27a" then
						iter_203_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_203_4 = 0.866666666666667

			if 0.866666666666667 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			if arg_200_1.time_ >= var_203_4 + 0.3 and arg_200_1.time_ < var_203_4 + 0.3 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			local var_203_5 = arg_200_1.actors_["1047ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_5) and arg_200_1.var_.characterEffect1047ui_story == nil then
				arg_200_1.var_.characterEffect1047ui_story = var_203_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_6 = 0.034000001847744

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_6 and not isNil(var_203_5) then
				if arg_200_1.var_.characterEffect1047ui_story and not isNil(var_203_5) then
					arg_200_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_6)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_6 and arg_200_1.time_ < 0 + var_203_6 + arg_203_0 and not isNil(var_203_5) and arg_200_1.var_.characterEffect1047ui_story then
				arg_200_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_203_7 = arg_200_1.actors_["1047ui_story"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1047ui_story = var_203_7.localPosition
			end

			local var_203_8 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_8 then
				var_203_7.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_200_1.time_ - 0) / var_203_8)
				var_203_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_7.position).x, (manager.ui.mainCamera.transform.position - var_203_7.position).y, (manager.ui.mainCamera.transform.position - var_203_7.position).z)
				var_203_7.localEulerAngles.z = 0
				var_203_7.localEulerAngles.x = 0
				var_203_7.localEulerAngles = var_203_7.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_8 and arg_200_1.time_ < 0 + var_203_8 + arg_203_0 then
				var_203_7.localPosition = Vector3.New(0, 100, 0)
				var_203_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_7.position).x, (manager.ui.mainCamera.transform.position - var_203_7.position).y, (manager.ui.mainCamera.transform.position - var_203_7.position).z)
				var_203_7.localEulerAngles.z = 0
				var_203_7.localEulerAngles.x = 0
				var_203_7.localEulerAngles = var_203_7.localEulerAngles
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				local var_203_9 = arg_200_1.var_.effectzhuanchangyixia1

				if not arg_200_1.var_.effectzhuanchangyixia1 then
					var_203_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_203_9.name = "zhuanchangyixia1"
					arg_200_1.var_.effectzhuanchangyixia1 = var_203_9
				else
					var_203_9.transform:SetParent(var_203_9000)
				end

				var_203_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_203_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_203_11 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_203_9.transform.localScale = Vector3.New(var_203_9.transform.localScale.x * var_203_11, var_203_9.transform.localScale.y * var_203_11, var_203_9.transform.localScale.z * var_203_11)
			end

			local var_203_12 = 0

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_12 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			if arg_200_1.time_ >= var_203_12 + 1.674999999999 and arg_200_1.time_ < var_203_12 + 1.674999999999 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			if 1.2 < arg_200_1.time_ and arg_200_1.time_ <= 1.2 + arg_203_0 then
				arg_200_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_club", "")
			end

			if 0.1 < arg_200_1.time_ and arg_200_1.time_ <= 0.1 + arg_203_0 then
				arg_200_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_15 = 1.53333333333333
			local var_203_16 = 0.95

			if 1.53333333333333 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_17 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_17:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_18 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(1104704050).content)

				arg_200_1.text_.text = var_203_18

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_20 = 38 <= 0 and var_203_16 or var_203_16 * (utf8.len(var_203_18) / 38)

				if (38 <= 0 and var_203_16 or var_203_16 * (utf8.len(var_203_18) / 38)) > 0 and var_203_16 < var_203_20 then
					arg_200_1.talkMaxDuration = var_203_20
					var_203_15 = var_203_15 + 0.3

					if var_203_20 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_20 + var_203_15
					end
				end

				arg_200_1.text_.text = var_203_18
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_21 = var_203_15 + 0.3
			local var_203_22 = math.max(var_203_16, arg_200_1.talkMaxDuration)

			if var_203_15 + 0.3 <= arg_200_1.time_ and arg_200_1.time_ < var_203_21 + var_203_22 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_21) / var_203_22

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_21 + var_203_22 and arg_200_1.time_ < var_203_21 + var_203_22 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play1104704051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1104704051
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1104704052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.75

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(1104704051).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 30 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 30)

				if (30 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 30)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1104704052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1104704052
		arg_210_1.duration_ = 3.33

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1104704053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1047ui_story = arg_210_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1047ui_story"].transform.position).z)
				arg_210_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1047ui_story"].transform.localEulerAngles = arg_210_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_210_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1047ui_story"].transform.position).z)
				arg_210_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1047ui_story"].transform.localEulerAngles = arg_210_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1047ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1047ui_story == nil then
				arg_210_1.var_.characterEffect1047ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect1047ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1047ui_story then
				arg_210_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_213_4 = 0
			local var_213_5 = 0.3

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(1104704052)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 12 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 12)

				if (12 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 12)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb")

						arg_210_1:RecordAudio("1104704052", var_213_11)
						arg_210_1:RecordAudio("1104704052", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704052", "story_v_side_new_1104704.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play1104704053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1104704053
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1104704054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1047ui_story"]) and arg_214_1.var_.characterEffect1047ui_story == nil then
				arg_214_1.var_.characterEffect1047ui_story = arg_214_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1047ui_story"]) then
				if arg_214_1.var_.characterEffect1047ui_story and not isNil(arg_214_1.actors_["1047ui_story"]) then
					arg_214_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1047ui_story"]) and arg_214_1.var_.characterEffect1047ui_story then
				arg_214_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.725

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(1104704053).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 29 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 29)

				if (29 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 29)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1104704054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1104704054
		arg_218_1.duration_ = 3.4

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1104704055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1047ui_story = arg_218_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).z)
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles = arg_218_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_218_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1047ui_story"].transform.position).z)
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1047ui_story"].transform.localEulerAngles = arg_218_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["1047ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1047ui_story == nil then
				arg_218_1.var_.characterEffect1047ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect1047ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1047ui_story then
				arg_218_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_221_4 = 0
			local var_221_5 = 0.4

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(1104704054)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 16 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 16)

				if (16 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 16)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb")

						arg_218_1:RecordAudio("1104704054", var_221_11)
						arg_218_1:RecordAudio("1104704054", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704054", "story_v_side_new_1104704.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play1104704055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1104704055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1104704056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1047ui_story"]) and arg_222_1.var_.characterEffect1047ui_story == nil then
				arg_222_1.var_.characterEffect1047ui_story = arg_222_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1047ui_story"]) then
				if arg_222_1.var_.characterEffect1047ui_story and not isNil(arg_222_1.actors_["1047ui_story"]) then
					arg_222_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_0)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1047ui_story"]) and arg_222_1.var_.characterEffect1047ui_story then
				arg_222_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_225_1 = 0
			local var_225_2 = 0.225

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(1104704055).content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 9 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 9)

				if (9 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 9)) > 0 and var_225_2 < var_225_5 then
					arg_222_1.talkMaxDuration = var_225_5

					if var_225_5 + var_225_1 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + var_225_1
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_6 = math.max(var_225_2, arg_222_1.talkMaxDuration)

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_6 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_1) / var_225_6

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_1 + var_225_6 and arg_222_1.time_ < var_225_1 + var_225_6 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1104704056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1104704056
		arg_226_1.duration_ = 6.27

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1104704057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1047ui_story = arg_226_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1047ui_story"].transform.position).z)
				arg_226_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1047ui_story"].transform.localEulerAngles = arg_226_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_226_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1047ui_story"].transform.position).z)
				arg_226_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1047ui_story"].transform.localEulerAngles = arg_226_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["1047ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1047ui_story == nil then
				arg_226_1.var_.characterEffect1047ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 and not isNil(var_229_1) then
				if arg_226_1.var_.characterEffect1047ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1047ui_story then
				arg_226_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_229_4 = 0
			local var_229_5 = 0.75

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(1104704056)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 30 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 30)

				if (30 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 30)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb")

						arg_226_1:RecordAudio("1104704056", var_229_11)
						arg_226_1:RecordAudio("1104704056", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704056", "story_v_side_new_1104704.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_12 and arg_226_1.time_ < var_229_4 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play1104704057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1104704057
		arg_230_1.duration_ = 4.63

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1104704058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1047ui_story = arg_230_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).z)
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles = arg_230_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_230_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).z)
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles = arg_230_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_233_1 = 0
			local var_233_2 = 0.525

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:GetWordFromCfg(1104704057)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_6 = 21 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_4) / 21)

				if (21 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_4) / 21)) > 0 and var_233_2 < var_233_6 then
					arg_230_1.talkMaxDuration = var_233_6

					if var_233_6 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb") ~= 0 then
					local var_233_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb") / 1000

					if var_233_7 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_1
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb")

						arg_230_1:RecordAudio("1104704057", var_233_8)
						arg_230_1:RecordAudio("1104704057", var_233_8)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704057", "story_v_side_new_1104704.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_9 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_9 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_9

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_9 and arg_230_1.time_ < var_233_1 + var_233_9 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play1104704058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1104704058
		arg_234_1.duration_ = 8.4

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1104704059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_0 = 0
			local var_237_1 = 1.025

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_2 = arg_234_1:GetWordFromCfg(1104704058)
				local var_237_3 = arg_234_1:FormatText(var_237_2.content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 41 <= 0 and var_237_1 or var_237_1 * (utf8.len(var_237_3) / 41)

				if (41 <= 0 and var_237_1 or var_237_1 * (utf8.len(var_237_3) / 41)) > 0 and var_237_1 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb") ~= 0 then
					local var_237_6 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb") / 1000

					if var_237_6 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_0
					end

					if var_237_2.prefab_name ~= "" and arg_234_1.actors_[var_237_2.prefab_name] ~= nil then
						local var_237_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_2.prefab_name].transform, "story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb")

						arg_234_1:RecordAudio("1104704058", var_237_7)
						arg_234_1:RecordAudio("1104704058", var_237_7)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704058", "story_v_side_new_1104704.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_8 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_8 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_8

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_8 and arg_234_1.time_ < var_237_0 + var_237_8 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1104704059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1104704059
		arg_238_1.duration_ = 3.5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1104704060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.3

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:GetWordFromCfg(1104704059)
				local var_241_2 = arg_238_1:FormatText(var_241_1.content)

				arg_238_1.text_.text = var_241_2

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 12 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 12)

				if (12 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 12)) > 0 and var_241_0 < var_241_4 then
					arg_238_1.talkMaxDuration = var_241_4

					if var_241_4 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_4 + 0
					end
				end

				arg_238_1.text_.text = var_241_2
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb") ~= 0 then
					local var_241_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb") / 1000

					if var_241_5 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + 0
					end

					if var_241_1.prefab_name ~= "" and arg_238_1.actors_[var_241_1.prefab_name] ~= nil then
						local var_241_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_1.prefab_name].transform, "story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb")

						arg_238_1:RecordAudio("1104704059", var_241_6)
						arg_238_1:RecordAudio("1104704059", var_241_6)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704059", "story_v_side_new_1104704.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1104704060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1104704060
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1104704061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1047ui_story"]) and arg_242_1.var_.characterEffect1047ui_story == nil then
				arg_242_1.var_.characterEffect1047ui_story = arg_242_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1047ui_story"]) then
				if arg_242_1.var_.characterEffect1047ui_story and not isNil(arg_242_1.actors_["1047ui_story"]) then
					arg_242_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1047ui_story"]) and arg_242_1.var_.characterEffect1047ui_story then
				arg_242_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_245_1 = arg_242_1.actors_["1047ui_story"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1047ui_story = var_245_1.localPosition
			end

			local var_245_2 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 then
				var_245_1.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_2)
				var_245_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_1.position).x, (manager.ui.mainCamera.transform.position - var_245_1.position).y, (manager.ui.mainCamera.transform.position - var_245_1.position).z)
				var_245_1.localEulerAngles.z = 0
				var_245_1.localEulerAngles.x = 0
				var_245_1.localEulerAngles = var_245_1.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 then
				var_245_1.localPosition = Vector3.New(0, 100, 0)
				var_245_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_245_1.position).x, (manager.ui.mainCamera.transform.position - var_245_1.position).y, (manager.ui.mainCamera.transform.position - var_245_1.position).z)
				var_245_1.localEulerAngles.z = 0
				var_245_1.localEulerAngles.x = 0
				var_245_1.localEulerAngles = var_245_1.localEulerAngles
			end

			local var_245_3 = 0
			local var_245_4 = 0.75

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_3 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_5 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(1104704060).content)

				arg_242_1.text_.text = var_245_5

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_7 = 30 <= 0 and var_245_4 or var_245_4 * (utf8.len(var_245_5) / 30)

				if (30 <= 0 and var_245_4 or var_245_4 * (utf8.len(var_245_5) / 30)) > 0 and var_245_4 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_3 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_3
					end
				end

				arg_242_1.text_.text = var_245_5
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_8 = math.max(var_245_4, arg_242_1.talkMaxDuration)

			if var_245_3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_3 + var_245_8 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_3) / var_245_8

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_3 + var_245_8 and arg_242_1.time_ < var_245_3 + var_245_8 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1104704061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1104704061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1104704062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.35

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(1104704061).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 14 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 14)

				if (14 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 14)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1104704062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1104704062
		arg_250_1.duration_ = 7.63

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1104704063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1047ui_story = arg_250_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).z)
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles = arg_250_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_250_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).z)
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles = arg_250_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_253_1 = arg_250_1.actors_["1047ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1047ui_story == nil then
				arg_250_1.var_.characterEffect1047ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect1047ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1047ui_story then
				arg_250_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_253_4 = 0
			local var_253_5 = 0.7

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_6 = arg_250_1:GetWordFromCfg(1104704062)
				local var_253_7 = arg_250_1:FormatText(var_253_6.content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 28 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 28)

				if (28 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 28)) > 0 and var_253_5 < var_253_9 then
					arg_250_1.talkMaxDuration = var_253_9

					if var_253_9 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_9 + var_253_4
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb") ~= 0 then
					local var_253_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb") / 1000

					if var_253_10 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_4
					end

					if var_253_6.prefab_name ~= "" and arg_250_1.actors_[var_253_6.prefab_name] ~= nil then
						local var_253_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_6.prefab_name].transform, "story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb")

						arg_250_1:RecordAudio("1104704062", var_253_11)
						arg_250_1:RecordAudio("1104704062", var_253_11)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704062", "story_v_side_new_1104704.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_12 = math.max(var_253_5, arg_250_1.talkMaxDuration)

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_12 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_4) / var_253_12

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_4 + var_253_12 and arg_250_1.time_ < var_253_4 + var_253_12 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play1104704063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1104704063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1104704064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1047ui_story"]) and arg_254_1.var_.characterEffect1047ui_story == nil then
				arg_254_1.var_.characterEffect1047ui_story = arg_254_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1047ui_story"]) then
				if arg_254_1.var_.characterEffect1047ui_story and not isNil(arg_254_1.actors_["1047ui_story"]) then
					arg_254_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1047ui_story"]) and arg_254_1.var_.characterEffect1047ui_story then
				arg_254_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_257_1 = arg_254_1.actors_["1047ui_story"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1047ui_story = var_257_1.localPosition
			end

			local var_257_2 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 then
				var_257_1.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_2)
				var_257_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_1.position).x, (manager.ui.mainCamera.transform.position - var_257_1.position).y, (manager.ui.mainCamera.transform.position - var_257_1.position).z)
				var_257_1.localEulerAngles.z = 0
				var_257_1.localEulerAngles.x = 0
				var_257_1.localEulerAngles = var_257_1.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 then
				var_257_1.localPosition = Vector3.New(0, 100, 0)
				var_257_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_1.position).x, (manager.ui.mainCamera.transform.position - var_257_1.position).y, (manager.ui.mainCamera.transform.position - var_257_1.position).z)
				var_257_1.localEulerAngles.z = 0
				var_257_1.localEulerAngles.x = 0
				var_257_1.localEulerAngles = var_257_1.localEulerAngles
			end

			local var_257_3 = 0
			local var_257_4 = 1.425

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_3 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_5 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(1104704063).content)

				arg_254_1.text_.text = var_257_5

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_7 = 57 <= 0 and var_257_4 or var_257_4 * (utf8.len(var_257_5) / 57)

				if (57 <= 0 and var_257_4 or var_257_4 * (utf8.len(var_257_5) / 57)) > 0 and var_257_4 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_3 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_3
					end
				end

				arg_254_1.text_.text = var_257_5
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_8 = math.max(var_257_4, arg_254_1.talkMaxDuration)

			if var_257_3 <= arg_254_1.time_ and arg_254_1.time_ < var_257_3 + var_257_8 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_3) / var_257_8

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_3 + var_257_8 and arg_254_1.time_ < var_257_3 + var_257_8 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play1104704064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1104704064
		arg_258_1.duration_ = 6.77

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1104704065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1047ui_story = arg_258_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1047ui_story"].transform.position).z)
				arg_258_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1047ui_story"].transform.localEulerAngles = arg_258_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_258_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1047ui_story"].transform.position).z)
				arg_258_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1047ui_story"].transform.localEulerAngles = arg_258_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["1047ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1047ui_story == nil then
				arg_258_1.var_.characterEffect1047ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect1047ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1047ui_story then
				arg_258_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_261_4 = 0
			local var_261_5 = 0.55

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_6 = arg_258_1:GetWordFromCfg(1104704064)
				local var_261_7 = arg_258_1:FormatText(var_261_6.content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 22 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 22)

				if (22 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 22)) > 0 and var_261_5 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb") ~= 0 then
					local var_261_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb") / 1000

					if var_261_10 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_10 + var_261_4
					end

					if var_261_6.prefab_name ~= "" and arg_258_1.actors_[var_261_6.prefab_name] ~= nil then
						local var_261_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_6.prefab_name].transform, "story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb")

						arg_258_1:RecordAudio("1104704064", var_261_11)
						arg_258_1:RecordAudio("1104704064", var_261_11)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704064", "story_v_side_new_1104704.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_12 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_12 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_12

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_12 and arg_258_1.time_ < var_261_4 + var_261_12 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1104704065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1104704065
		arg_262_1.duration_ = 6.2

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1104704066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1047ui_story = arg_262_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_265_0 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 then
				arg_262_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_262_1.time_ - 0) / var_265_0)
				arg_262_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).z)
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles = arg_262_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 then
				arg_262_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_262_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1047ui_story"].transform.position).z)
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1047ui_story"].transform.localEulerAngles = arg_262_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action472")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_265_1 = 0
			local var_265_2 = 0.675

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_3 = arg_262_1:GetWordFromCfg(1104704065)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_6 = 27 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_4) / 27)

				if (27 <= 0 and var_265_2 or var_265_2 * (utf8.len(var_265_4) / 27)) > 0 and var_265_2 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_1
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb") ~= 0 then
					local var_265_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb") / 1000

					if var_265_7 + var_265_1 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_1
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb")

						arg_262_1:RecordAudio("1104704065", var_265_8)
						arg_262_1:RecordAudio("1104704065", var_265_8)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704065", "story_v_side_new_1104704.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_9 = math.max(var_265_2, arg_262_1.talkMaxDuration)

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_9 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_1) / var_265_9

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_1 + var_265_9 and arg_262_1.time_ < var_265_1 + var_265_9 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play1104704066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1104704066
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1104704067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1047ui_story"]) and arg_266_1.var_.characterEffect1047ui_story == nil then
				arg_266_1.var_.characterEffect1047ui_story = arg_266_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1047ui_story"]) then
				if arg_266_1.var_.characterEffect1047ui_story and not isNil(arg_266_1.actors_["1047ui_story"]) then
					arg_266_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1047ui_story"]) and arg_266_1.var_.characterEffect1047ui_story then
				arg_266_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_269_1 = arg_266_1.actors_["1047ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1047ui_story = var_269_1.localPosition
			end

			local var_269_2 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 then
				var_269_1.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_2)
				var_269_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_1.position).x, (manager.ui.mainCamera.transform.position - var_269_1.position).y, (manager.ui.mainCamera.transform.position - var_269_1.position).z)
				var_269_1.localEulerAngles.z = 0
				var_269_1.localEulerAngles.x = 0
				var_269_1.localEulerAngles = var_269_1.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 then
				var_269_1.localPosition = Vector3.New(0, 100, 0)
				var_269_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_1.position).x, (manager.ui.mainCamera.transform.position - var_269_1.position).y, (manager.ui.mainCamera.transform.position - var_269_1.position).z)
				var_269_1.localEulerAngles.z = 0
				var_269_1.localEulerAngles.x = 0
				var_269_1.localEulerAngles = var_269_1.localEulerAngles
			end

			local var_269_3 = 0
			local var_269_4 = 1.125

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_3 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_5 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(1104704066).content)

				arg_266_1.text_.text = var_269_5

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_7 = 45 <= 0 and var_269_4 or var_269_4 * (utf8.len(var_269_5) / 45)

				if (45 <= 0 and var_269_4 or var_269_4 * (utf8.len(var_269_5) / 45)) > 0 and var_269_4 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_3 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_3
					end
				end

				arg_266_1.text_.text = var_269_5
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_8 = math.max(var_269_4, arg_266_1.talkMaxDuration)

			if var_269_3 <= arg_266_1.time_ and arg_266_1.time_ < var_269_3 + var_269_8 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_3) / var_269_8

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_3 + var_269_8 and arg_266_1.time_ < var_269_3 + var_269_8 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play1104704067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1104704067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1104704068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.275

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(1104704067).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 11 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 11)

				if (11 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 11)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1104704068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1104704068
		arg_274_1.duration_ = 2

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1104704069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1047ui_story = arg_274_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1047ui_story"].transform.position).z)
				arg_274_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1047ui_story"].transform.localEulerAngles = arg_274_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_274_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1047ui_story"].transform.position).z)
				arg_274_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1047ui_story"].transform.localEulerAngles = arg_274_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["1047ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1047ui_story == nil then
				arg_274_1.var_.characterEffect1047ui_story = var_277_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 and not isNil(var_277_1) then
				if arg_274_1.var_.characterEffect1047ui_story and not isNil(var_277_1) then
					arg_274_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 and not isNil(var_277_1) and arg_274_1.var_.characterEffect1047ui_story then
				arg_274_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action426")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_277_4 = 0
			local var_277_5 = 0.05

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_6 = arg_274_1:GetWordFromCfg(1104704068)
				local var_277_7 = arg_274_1:FormatText(var_277_6.content)

				arg_274_1.text_.text = var_277_7

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_9 = 2 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 2)

				if (2 <= 0 and var_277_5 or var_277_5 * (utf8.len(var_277_7) / 2)) > 0 and var_277_5 < var_277_9 then
					arg_274_1.talkMaxDuration = var_277_9

					if var_277_9 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_4
					end
				end

				arg_274_1.text_.text = var_277_7
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb") ~= 0 then
					local var_277_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb") / 1000

					if var_277_10 + var_277_4 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_4
					end

					if var_277_6.prefab_name ~= "" and arg_274_1.actors_[var_277_6.prefab_name] ~= nil then
						local var_277_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_6.prefab_name].transform, "story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb")

						arg_274_1:RecordAudio("1104704068", var_277_11)
						arg_274_1:RecordAudio("1104704068", var_277_11)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704068", "story_v_side_new_1104704.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_12 = math.max(var_277_5, arg_274_1.talkMaxDuration)

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_12 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_4) / var_277_12

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_4 + var_277_12 and arg_274_1.time_ < var_277_4 + var_277_12 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play1104704069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1104704069
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1104704070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1047ui_story"]) and arg_278_1.var_.characterEffect1047ui_story == nil then
				arg_278_1.var_.characterEffect1047ui_story = arg_278_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1047ui_story"]) then
				if arg_278_1.var_.characterEffect1047ui_story and not isNil(arg_278_1.actors_["1047ui_story"]) then
					arg_278_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_0)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1047ui_story"]) and arg_278_1.var_.characterEffect1047ui_story then
				arg_278_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_281_1 = 0
			local var_281_2 = 0.9

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(1104704069).content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 36 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_3) / 36)

				if (36 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_3) / 36)) > 0 and var_281_2 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_1
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_6 = math.max(var_281_2, arg_278_1.talkMaxDuration)

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_6 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_1) / var_281_6

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_1 + var_281_6 and arg_278_1.time_ < var_281_1 + var_281_6 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1104704070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1104704070
		arg_282_1.duration_ = 2

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1104704071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1047ui_story = arg_282_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1047ui_story"].transform.position).z)
				arg_282_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1047ui_story"].transform.localEulerAngles = arg_282_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_282_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1047ui_story"].transform.position).z)
				arg_282_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1047ui_story"].transform.localEulerAngles = arg_282_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_285_1 = arg_282_1.actors_["1047ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1047ui_story == nil then
				arg_282_1.var_.characterEffect1047ui_story = var_285_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_2 and not isNil(var_285_1) then
				if arg_282_1.var_.characterEffect1047ui_story and not isNil(var_285_1) then
					arg_282_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_2 and arg_282_1.time_ < 0 + var_285_2 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1047ui_story then
				arg_282_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_285_4 = 0
			local var_285_5 = 0.05

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_6 = arg_282_1:GetWordFromCfg(1104704070)
				local var_285_7 = arg_282_1:FormatText(var_285_6.content)

				arg_282_1.text_.text = var_285_7

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_9 = 2 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 2)

				if (2 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 2)) > 0 and var_285_5 < var_285_9 then
					arg_282_1.talkMaxDuration = var_285_9

					if var_285_9 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_9 + var_285_4
					end
				end

				arg_282_1.text_.text = var_285_7
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb") ~= 0 then
					local var_285_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb") / 1000

					if var_285_10 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_4
					end

					if var_285_6.prefab_name ~= "" and arg_282_1.actors_[var_285_6.prefab_name] ~= nil then
						local var_285_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_6.prefab_name].transform, "story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb")

						arg_282_1:RecordAudio("1104704070", var_285_11)
						arg_282_1:RecordAudio("1104704070", var_285_11)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704070", "story_v_side_new_1104704.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_12 = math.max(var_285_5, arg_282_1.talkMaxDuration)

			if var_285_4 <= arg_282_1.time_ and arg_282_1.time_ < var_285_4 + var_285_12 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_4) / var_285_12

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_4 + var_285_12 and arg_282_1.time_ < var_285_4 + var_285_12 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1104704071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1104704071
		arg_286_1.duration_ = 8.53

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1104704072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.8

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_1 = arg_286_1:GetWordFromCfg(1104704071)
				local var_289_2 = arg_286_1:FormatText(var_289_1.content)

				arg_286_1.text_.text = var_289_2

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 32 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 32)

				if (32 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 32)) > 0 and var_289_0 < var_289_4 then
					arg_286_1.talkMaxDuration = var_289_4

					if var_289_4 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_4 + 0
					end
				end

				arg_286_1.text_.text = var_289_2
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb") ~= 0 then
					local var_289_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb") / 1000

					if var_289_5 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + 0
					end

					if var_289_1.prefab_name ~= "" and arg_286_1.actors_[var_289_1.prefab_name] ~= nil then
						local var_289_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_1.prefab_name].transform, "story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb")

						arg_286_1:RecordAudio("1104704071", var_289_6)
						arg_286_1:RecordAudio("1104704071", var_289_6)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704071", "story_v_side_new_1104704.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1104704072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1104704072
		arg_290_1.duration_ = 5.2

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1104704073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_293_0 = 0
			local var_293_1 = 0.425

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_2 = arg_290_1:GetWordFromCfg(1104704072)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 17 <= 0 and var_293_1 or var_293_1 * (utf8.len(var_293_3) / 17)

				if (17 <= 0 and var_293_1 or var_293_1 * (utf8.len(var_293_3) / 17)) > 0 and var_293_1 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb") ~= 0 then
					local var_293_6 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb") / 1000

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end

					if var_293_2.prefab_name ~= "" and arg_290_1.actors_[var_293_2.prefab_name] ~= nil then
						local var_293_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_2.prefab_name].transform, "story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb")

						arg_290_1:RecordAudio("1104704072", var_293_7)
						arg_290_1:RecordAudio("1104704072", var_293_7)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704072", "story_v_side_new_1104704.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_8 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_8

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_8 and arg_290_1.time_ < var_293_0 + var_293_8 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1104704073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1104704073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1104704074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1047ui_story"]) and arg_294_1.var_.characterEffect1047ui_story == nil then
				arg_294_1.var_.characterEffect1047ui_story = arg_294_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1047ui_story"]) then
				if arg_294_1.var_.characterEffect1047ui_story and not isNil(arg_294_1.actors_["1047ui_story"]) then
					arg_294_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_0)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1047ui_story"]) and arg_294_1.var_.characterEffect1047ui_story then
				arg_294_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_297_1 = arg_294_1.actors_["1047ui_story"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1047ui_story = var_297_1.localPosition
			end

			local var_297_2 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_2 then
				var_297_1.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_294_1.time_ - 0) / var_297_2)
				var_297_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_1.position).x, (manager.ui.mainCamera.transform.position - var_297_1.position).y, (manager.ui.mainCamera.transform.position - var_297_1.position).z)
				var_297_1.localEulerAngles.z = 0
				var_297_1.localEulerAngles.x = 0
				var_297_1.localEulerAngles = var_297_1.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_2 and arg_294_1.time_ < 0 + var_297_2 + arg_297_0 then
				var_297_1.localPosition = Vector3.New(0, 100, 0)
				var_297_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_297_1.position).x, (manager.ui.mainCamera.transform.position - var_297_1.position).y, (manager.ui.mainCamera.transform.position - var_297_1.position).z)
				var_297_1.localEulerAngles.z = 0
				var_297_1.localEulerAngles.x = 0
				var_297_1.localEulerAngles = var_297_1.localEulerAngles
			end

			if 0.1 < arg_294_1.time_ and arg_294_1.time_ <= 0.1 + arg_297_0 then
				arg_294_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_297_4 = 0
			local var_297_5 = 0.825

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_6 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(1104704073).content)

				arg_294_1.text_.text = var_297_6

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_8 = 33 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_6) / 33)

				if (33 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_6) / 33)) > 0 and var_297_5 < var_297_8 then
					arg_294_1.talkMaxDuration = var_297_8

					if var_297_8 + var_297_4 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_4
					end
				end

				arg_294_1.text_.text = var_297_6
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_9 = math.max(var_297_5, arg_294_1.talkMaxDuration)

			if var_297_4 <= arg_294_1.time_ and arg_294_1.time_ < var_297_4 + var_297_9 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_4) / var_297_9

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_4 + var_297_9 and arg_294_1.time_ < var_297_4 + var_297_9 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play1104704074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1104704074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1104704075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.2

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(1104704074).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 8 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 8)

				if (8 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 8)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1104704075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1104704075
		arg_302_1.duration_ = 2

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1104704076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1047ui_story = arg_302_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1047ui_story"].transform.position).z)
				arg_302_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1047ui_story"].transform.localEulerAngles = arg_302_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_302_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1047ui_story"].transform.position).z)
				arg_302_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1047ui_story"].transform.localEulerAngles = arg_302_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["1047ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1047ui_story == nil then
				arg_302_1.var_.characterEffect1047ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1047ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1047ui_story then
				arg_302_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_305_4 = 0
			local var_305_5 = 0.05

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:GetWordFromCfg(1104704075)
				local var_305_7 = arg_302_1:FormatText(var_305_6.content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 2 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 2)

				if (2 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 2)) > 0 and var_305_5 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb") / 1000

					if var_305_10 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_4
					end

					if var_305_6.prefab_name ~= "" and arg_302_1.actors_[var_305_6.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_6.prefab_name].transform, "story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb")

						arg_302_1:RecordAudio("1104704075", var_305_11)
						arg_302_1:RecordAudio("1104704075", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704075", "story_v_side_new_1104704.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_12 and arg_302_1.time_ < var_305_4 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play1104704076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1104704076
		arg_306_1.duration_ = 7

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1104704077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if arg_306_1.bgs_.ST84a == nil then
				local var_309_0 = Object.Instantiate(arg_306_1.paintGo_)

				var_309_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST84a")
				var_309_0.name = "ST84a"
				var_309_0.transform.parent = arg_306_1.stage_.transform
				var_309_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_306_1.bgs_.ST84a = var_309_0
			end

			if 0.466666666666667 < arg_306_1.time_ and arg_306_1.time_ <= 0.466666666666667 + arg_309_0 then
				local var_309_1 = arg_306_1.bgs_.ST84a

				arg_306_1.bgs_.ST84a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_309_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_309_2 = var_309_1:GetComponent("SpriteRenderer")

				if var_309_2 and var_309_2.sprite then
					local var_309_3 = 2 * (var_309_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_309_1.transform.localScale = Vector3.New(var_309_3 / var_309_2.sprite.bounds.size.y < var_309_3 * manager.ui.mainCameraCom_.aspect / var_309_2.sprite.bounds.size.x and var_309_3 * manager.ui.mainCameraCom_.aspect / var_309_2.sprite.bounds.size.x or var_309_3 / var_309_2.sprite.bounds.size.y, var_309_3 / var_309_2.sprite.bounds.size.y < var_309_3 * manager.ui.mainCameraCom_.aspect / var_309_2.sprite.bounds.size.x and var_309_3 * manager.ui.mainCameraCom_.aspect / var_309_2.sprite.bounds.size.x or var_309_3 / var_309_2.sprite.bounds.size.y, 0)
				end

				for iter_309_0, iter_309_1 in pairs(arg_306_1.bgs_) do
					if iter_309_0 ~= "ST84a" then
						iter_309_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_309_4 = 2

			if 2 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1.allBtn_.enabled = false
			end

			if arg_306_1.time_ >= var_309_4 + 0.3 and arg_306_1.time_ < var_309_4 + 0.3 + arg_309_0 then
				arg_306_1.allBtn_.enabled = true
			end

			local var_309_5 = 0.466666666666667

			if 0.466666666666667 < arg_306_1.time_ and arg_306_1.time_ <= var_309_5 + arg_309_0 then
				arg_306_1.mask_.enabled = true
				arg_306_1.mask_.raycastTarget = true

				arg_306_1:SetGaussion(false)
			end

			local var_309_6 = 2

			if var_309_5 <= arg_306_1.time_ and arg_306_1.time_ < var_309_5 + var_309_6 then
				local var_309_7 = Color.New(1, 1, 1)

				var_309_7.a = Mathf.Lerp(1, 0, (arg_306_1.time_ - var_309_5) / var_309_6)
				arg_306_1.mask_.color = var_309_7
			end

			if arg_306_1.time_ >= var_309_5 + var_309_6 and arg_306_1.time_ < var_309_5 + var_309_6 + arg_309_0 then
				local var_309_8 = Color.New(1, 1, 1)

				arg_306_1.mask_.enabled = false
				var_309_8.a = 0
				arg_306_1.mask_.color = var_309_8
			end

			local var_309_9 = arg_306_1.actors_["1047ui_story"]

			if 0.466666666666667 < arg_306_1.time_ and arg_306_1.time_ <= 0.466666666666667 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1047ui_story == nil then
				arg_306_1.var_.characterEffect1047ui_story = var_309_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_10 = 0.034000001847744

			if 0.466666666666667 <= arg_306_1.time_ and arg_306_1.time_ < 0.466666666666667 + var_309_10 and not isNil(var_309_9) then
				if arg_306_1.var_.characterEffect1047ui_story and not isNil(var_309_9) then
					arg_306_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0.466666666666667) / var_309_10)
				end
			end

			if arg_306_1.time_ >= 0.466666666666667 + var_309_10 and arg_306_1.time_ < 0.466666666666667 + var_309_10 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1047ui_story then
				arg_306_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_309_11 = arg_306_1.actors_["1047ui_story"].transform

			if 0.466666666666667 < arg_306_1.time_ and arg_306_1.time_ <= 0.466666666666667 + arg_309_0 then
				arg_306_1.var_.moveOldPos1047ui_story = var_309_11.localPosition
			end

			local var_309_12 = 0.001

			if 0.466666666666667 <= arg_306_1.time_ and arg_306_1.time_ < 0.466666666666667 + var_309_12 then
				var_309_11.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_306_1.time_ - 0.466666666666667) / var_309_12)
				var_309_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_11.position).x, (manager.ui.mainCamera.transform.position - var_309_11.position).y, (manager.ui.mainCamera.transform.position - var_309_11.position).z)
				var_309_11.localEulerAngles.z = 0
				var_309_11.localEulerAngles.x = 0
				var_309_11.localEulerAngles = var_309_11.localEulerAngles
			end

			if arg_306_1.time_ >= 0.466666666666667 + var_309_12 and arg_306_1.time_ < 0.466666666666667 + var_309_12 + arg_309_0 then
				var_309_11.localPosition = Vector3.New(0, 100, 0)
				var_309_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_11.position).x, (manager.ui.mainCamera.transform.position - var_309_11.position).y, (manager.ui.mainCamera.transform.position - var_309_11.position).z)
				var_309_11.localEulerAngles.z = 0
				var_309_11.localEulerAngles.x = 0
				var_309_11.localEulerAngles = var_309_11.localEulerAngles
			end

			local var_309_13 = 0

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_13 + arg_309_0 then
				arg_306_1.allBtn_.enabled = false
			end

			if arg_306_1.time_ >= var_309_13 + 0.6 and arg_306_1.time_ < var_309_13 + 0.6 + arg_309_0 then
				arg_306_1.allBtn_.enabled = true
			end

			if 1.2 < arg_306_1.time_ and arg_306_1.time_ <= 1.2 + arg_309_0 then
				arg_306_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0.1 < arg_306_1.time_ and arg_306_1.time_ <= 0.1 + arg_309_0 then
				arg_306_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_club", "")
			end

			if arg_306_1.frameCnt_ <= 1 then
				arg_306_1.dialog_:SetActive(false)
			end

			local var_309_16 = 2
			local var_309_17 = 0.55

			if 2 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				arg_306_1.dialog_:SetActive(true)

				arg_306_1.dialogCg_.alpha = 0

				local var_309_18 = LeanTween.value(arg_306_1.dialog_, 0, 1, 0.3)

				var_309_18:setOnUpdate(LuaHelper.FloatAction(function(arg_310_0)
					arg_306_1.dialogCg_.alpha = arg_310_0
				end))
				var_309_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_306_1.dialog_)
					var_309_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_306_1.duration_ = arg_306_1.duration_ + 0.3

				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_19 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(1104704076).content)

				arg_306_1.text_.text = var_309_19

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_21 = 22 <= 0 and var_309_17 or var_309_17 * (utf8.len(var_309_19) / 22)

				if (22 <= 0 and var_309_17 or var_309_17 * (utf8.len(var_309_19) / 22)) > 0 and var_309_17 < var_309_21 then
					arg_306_1.talkMaxDuration = var_309_21
					var_309_16 = var_309_16 + 0.3

					if var_309_21 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_21 + var_309_16
					end
				end

				arg_306_1.text_.text = var_309_19
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_22 = var_309_16 + 0.3
			local var_309_23 = math.max(var_309_17, arg_306_1.talkMaxDuration)

			if var_309_16 + 0.3 <= arg_306_1.time_ and arg_306_1.time_ < var_309_22 + var_309_23 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_22) / var_309_23

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_22 + var_309_23 and arg_306_1.time_ < var_309_22 + var_309_23 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play1104704077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1104704077
		arg_312_1.duration_ = 1.9

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1104704078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0.125

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_1 = arg_312_1:GetWordFromCfg(1104704077)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.text_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 5 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 5)

				if (5 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 5)) > 0 and var_315_0 < var_315_4 then
					arg_312_1.talkMaxDuration = var_315_4

					if var_315_4 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_4 + 0
					end
				end

				arg_312_1.text_.text = var_315_2
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb") ~= 0 then
					local var_315_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb") / 1000

					if var_315_5 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + 0
					end

					if var_315_1.prefab_name ~= "" and arg_312_1.actors_[var_315_1.prefab_name] ~= nil then
						local var_315_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_1.prefab_name].transform, "story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb")

						arg_312_1:RecordAudio("1104704077", var_315_6)
						arg_312_1:RecordAudio("1104704077", var_315_6)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704077", "story_v_side_new_1104704.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1104704078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1104704078
		arg_316_1.duration_ = 1.03

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1104704079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.05

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:GetWordFromCfg(1104704078)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 2 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 2)

				if (2 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 2)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb")

						arg_316_1:RecordAudio("1104704078", var_319_6)
						arg_316_1:RecordAudio("1104704078", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704078", "story_v_side_new_1104704.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1104704079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1104704079
		arg_320_1.duration_ = 5.4

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1104704080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_9000

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_323_0 = 0.4

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				local var_323_1, var_323_2 = math.modf((arg_320_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_323_2 * 0.13, var_323_2 * 0.13, var_323_2 * 0.13) + arg_320_1.var_.shakeOldPos
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				manager.ui.mainCamera.transform.localPosition = arg_320_1.var_.shakeOldPos
			end

			if 0.4 < arg_320_1.time_ and arg_320_1.time_ <= 0.4 + arg_323_0 then
				local var_323_3 = arg_320_1.var_.effectboguang1caidai2

				if not arg_320_1.var_.effectboguang1caidai2 then
					var_323_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_323_3.name = "caidai2"
					arg_320_1.var_.effectboguang1caidai2 = var_323_3
				else
					var_323_3.transform:SetParent(var_323_9000)
				end

				var_323_3.transform.localPosition = Vector3.New(0, 0, -5.19)
				var_323_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_323_5 = 0

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_5 + arg_323_0 then
				arg_320_1.allBtn_.enabled = false
			end

			if arg_320_1.time_ >= var_323_5 + 1.674999999999 and arg_320_1.time_ < var_323_5 + 1.674999999999 + arg_323_0 then
				arg_320_1.allBtn_.enabled = true
			end

			if 0.1 < arg_320_1.time_ and arg_320_1.time_ <= 0.1 + arg_323_0 then
				arg_320_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_partypopper", "")
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_7 = 0.4
			local var_323_8 = 1.2

			if 0.4 < arg_320_1.time_ and arg_320_1.time_ <= var_323_7 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_9 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_9:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_10 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(1104704079).content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_12 = 48 <= 0 and var_323_8 or var_323_8 * (utf8.len(var_323_10) / 48)

				if (48 <= 0 and var_323_8 or var_323_8 * (utf8.len(var_323_10) / 48)) > 0 and var_323_8 < var_323_12 then
					arg_320_1.talkMaxDuration = var_323_12
					var_323_7 = var_323_7 + 0.3

					if var_323_12 + var_323_7 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_12 + var_323_7
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_13 = var_323_7 + 0.3
			local var_323_14 = math.max(var_323_8, arg_320_1.talkMaxDuration)

			if var_323_7 + 0.3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_13 + var_323_14 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_13) / var_323_14

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_13 + var_323_14 and arg_320_1.time_ < var_323_13 + var_323_14 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1104704080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1104704080
		arg_326_1.duration_ = 1

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"

			SetActive(arg_326_1.choicesGo_, true)

			for iter_327_0, iter_327_1 in ipairs(arg_326_1.choices_) do
				SetActive(iter_327_1.go, iter_327_0 <= 1)
			end

			arg_326_1.choices_[1].txt.text = arg_326_1:FormatText(StoryChoiceCfg[1661].name)
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1104704081(arg_326_1)
			end

			arg_326_1:RecordChoiceLog(1104704080, 1661)
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.allBtn_.enabled = false
			end

			if arg_326_1.time_ >= 0 + 0.433333333333333 and arg_326_1.time_ < 0 + 0.433333333333333 + arg_329_0 then
				arg_326_1.allBtn_.enabled = true
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1104704081 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1104704081
		arg_330_1.duration_ = 1.8

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1104704082(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.15

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_1 = arg_330_1:GetWordFromCfg(1104704081)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 6 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 6)

				if (6 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 6)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb")

						arg_330_1:RecordAudio("1104704081", var_333_6)
						arg_330_1:RecordAudio("1104704081", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704081", "story_v_side_new_1104704.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1104704082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1104704082
		arg_334_1.duration_ = 2

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1104704083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1047ui_story = arg_334_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1047ui_story"].transform.position).z)
				arg_334_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1047ui_story"].transform.localEulerAngles = arg_334_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_334_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1047ui_story"].transform.position).z)
				arg_334_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1047ui_story"].transform.localEulerAngles = arg_334_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_337_1 = arg_334_1.actors_["1047ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1047ui_story == nil then
				arg_334_1.var_.characterEffect1047ui_story = var_337_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_2 and not isNil(var_337_1) then
				if arg_334_1.var_.characterEffect1047ui_story and not isNil(var_337_1) then
					arg_334_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_2 and arg_334_1.time_ < 0 + var_337_2 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1047ui_story then
				arg_334_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				if arg_334_1.var_.effectboguang1caidai2 then
					Object.Destroy(arg_334_1.var_.effectboguang1caidai2)

					arg_334_1.var_.effectboguang1caidai2 = nil
				end
			end

			local var_337_5 = 0
			local var_337_6 = 0.15

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_7 = arg_334_1:GetWordFromCfg(1104704082)
				local var_337_8 = arg_334_1:FormatText(var_337_7.content)

				arg_334_1.text_.text = var_337_8

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 6 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 6)

				if (6 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 6)) > 0 and var_337_6 < var_337_10 then
					arg_334_1.talkMaxDuration = var_337_10

					if var_337_10 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_5
					end
				end

				arg_334_1.text_.text = var_337_8
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb") ~= 0 then
					local var_337_11 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb") / 1000

					if var_337_11 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_5
					end

					if var_337_7.prefab_name ~= "" and arg_334_1.actors_[var_337_7.prefab_name] ~= nil then
						local var_337_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_7.prefab_name].transform, "story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb")

						arg_334_1:RecordAudio("1104704082", var_337_12)
						arg_334_1:RecordAudio("1104704082", var_337_12)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704082", "story_v_side_new_1104704.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_13 = math.max(var_337_6, arg_334_1.talkMaxDuration)

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_13 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_5) / var_337_13

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_5 + var_337_13 and arg_334_1.time_ < var_337_5 + var_337_13 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play1104704083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1104704083
		arg_338_1.duration_ = 11.67

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1104704084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1047ui_story"]) and arg_338_1.var_.characterEffect1047ui_story == nil then
				arg_338_1.var_.characterEffect1047ui_story = arg_338_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1047ui_story"]) then
				if arg_338_1.var_.characterEffect1047ui_story and not isNil(arg_338_1.actors_["1047ui_story"]) then
					arg_338_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_0)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1047ui_story"]) and arg_338_1.var_.characterEffect1047ui_story then
				arg_338_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_341_1 = arg_338_1.actors_["1047ui_story"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1047ui_story = var_341_1.localPosition
			end

			local var_341_2 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_2 then
				var_341_1.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_338_1.time_ - 0) / var_341_2)
				var_341_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_1.position).x, (manager.ui.mainCamera.transform.position - var_341_1.position).y, (manager.ui.mainCamera.transform.position - var_341_1.position).z)
				var_341_1.localEulerAngles.z = 0
				var_341_1.localEulerAngles.x = 0
				var_341_1.localEulerAngles = var_341_1.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_2 and arg_338_1.time_ < 0 + var_341_2 + arg_341_0 then
				var_341_1.localPosition = Vector3.New(0, 100, 0)
				var_341_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_1.position).x, (manager.ui.mainCamera.transform.position - var_341_1.position).y, (manager.ui.mainCamera.transform.position - var_341_1.position).z)
				var_341_1.localEulerAngles.z = 0
				var_341_1.localEulerAngles.x = 0
				var_341_1.localEulerAngles = var_341_1.localEulerAngles
			end

			local var_341_3 = 0
			local var_341_4 = 1.075

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_3 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_5 = arg_338_1:GetWordFromCfg(1104704083)
				local var_341_6 = arg_338_1:FormatText(var_341_5.content)

				arg_338_1.text_.text = var_341_6

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_8 = 43 <= 0 and var_341_4 or var_341_4 * (utf8.len(var_341_6) / 43)

				if (43 <= 0 and var_341_4 or var_341_4 * (utf8.len(var_341_6) / 43)) > 0 and var_341_4 < var_341_8 then
					arg_338_1.talkMaxDuration = var_341_8

					if var_341_8 + var_341_3 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_3
					end
				end

				arg_338_1.text_.text = var_341_6
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb") ~= 0 then
					local var_341_9 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb") / 1000

					if var_341_9 + var_341_3 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_3
					end

					if var_341_5.prefab_name ~= "" and arg_338_1.actors_[var_341_5.prefab_name] ~= nil then
						local var_341_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_5.prefab_name].transform, "story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb")

						arg_338_1:RecordAudio("1104704083", var_341_10)
						arg_338_1:RecordAudio("1104704083", var_341_10)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704083", "story_v_side_new_1104704.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_11 = math.max(var_341_4, arg_338_1.talkMaxDuration)

			if var_341_3 <= arg_338_1.time_ and arg_338_1.time_ < var_341_3 + var_341_11 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_3) / var_341_11

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_3 + var_341_11 and arg_338_1.time_ < var_341_3 + var_341_11 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play1104704084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1104704084
		arg_342_1.duration_ = 15.1

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1104704085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 1.35

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:GetWordFromCfg(1104704084)
				local var_345_2 = arg_342_1:FormatText(var_345_1.content)

				arg_342_1.text_.text = var_345_2

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 54 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 54)

				if (54 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_2) / 54)) > 0 and var_345_0 < var_345_4 then
					arg_342_1.talkMaxDuration = var_345_4

					if var_345_4 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_4 + 0
					end
				end

				arg_342_1.text_.text = var_345_2
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb") ~= 0 then
					local var_345_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb") / 1000

					if var_345_5 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + 0
					end

					if var_345_1.prefab_name ~= "" and arg_342_1.actors_[var_345_1.prefab_name] ~= nil then
						local var_345_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_1.prefab_name].transform, "story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb")

						arg_342_1:RecordAudio("1104704084", var_345_6)
						arg_342_1:RecordAudio("1104704084", var_345_6)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704084", "story_v_side_new_1104704.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1104704085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1104704085
		arg_346_1.duration_ = 4.03

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1104704086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1047ui_story = arg_346_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1047ui_story"].transform.position).z)
				arg_346_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["1047ui_story"].transform.localEulerAngles = arg_346_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_346_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1047ui_story"].transform.position).z)
				arg_346_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["1047ui_story"].transform.localEulerAngles = arg_346_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_349_1 = arg_346_1.actors_["1047ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect1047ui_story == nil then
				arg_346_1.var_.characterEffect1047ui_story = var_349_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 and not isNil(var_349_1) then
				if arg_346_1.var_.characterEffect1047ui_story and not isNil(var_349_1) then
					arg_346_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect1047ui_story then
				arg_346_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_349_4 = 0
			local var_349_5 = 0.45

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_6 = arg_346_1:GetWordFromCfg(1104704085)
				local var_349_7 = arg_346_1:FormatText(var_349_6.content)

				arg_346_1.text_.text = var_349_7

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 18 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 18)

				if (18 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 18)) > 0 and var_349_5 < var_349_9 then
					arg_346_1.talkMaxDuration = var_349_9

					if var_349_9 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_9 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_7
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb") ~= 0 then
					local var_349_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb") / 1000

					if var_349_10 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_4
					end

					if var_349_6.prefab_name ~= "" and arg_346_1.actors_[var_349_6.prefab_name] ~= nil then
						local var_349_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_6.prefab_name].transform, "story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb")

						arg_346_1:RecordAudio("1104704085", var_349_11)
						arg_346_1:RecordAudio("1104704085", var_349_11)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704085", "story_v_side_new_1104704.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_12 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_12 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_12

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_12 and arg_346_1.time_ < var_349_4 + var_349_12 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play1104704086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1104704086
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1104704087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1047ui_story"]) and arg_350_1.var_.characterEffect1047ui_story == nil then
				arg_350_1.var_.characterEffect1047ui_story = arg_350_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1047ui_story"]) then
				if arg_350_1.var_.characterEffect1047ui_story and not isNil(arg_350_1.actors_["1047ui_story"]) then
					arg_350_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_0)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1047ui_story"]) and arg_350_1.var_.characterEffect1047ui_story then
				arg_350_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_353_1 = arg_350_1.actors_["1047ui_story"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1047ui_story = var_353_1.localPosition
			end

			local var_353_2 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_2 then
				var_353_1.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_350_1.time_ - 0) / var_353_2)
				var_353_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_1.position).x, (manager.ui.mainCamera.transform.position - var_353_1.position).y, (manager.ui.mainCamera.transform.position - var_353_1.position).z)
				var_353_1.localEulerAngles.z = 0
				var_353_1.localEulerAngles.x = 0
				var_353_1.localEulerAngles = var_353_1.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_2 and arg_350_1.time_ < 0 + var_353_2 + arg_353_0 then
				var_353_1.localPosition = Vector3.New(0, 100, 0)
				var_353_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_353_1.position).x, (manager.ui.mainCamera.transform.position - var_353_1.position).y, (manager.ui.mainCamera.transform.position - var_353_1.position).z)
				var_353_1.localEulerAngles.z = 0
				var_353_1.localEulerAngles.x = 0
				var_353_1.localEulerAngles = var_353_1.localEulerAngles
			end

			local var_353_3 = 0
			local var_353_4 = 0.625

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_3 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_5 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1104704086).content)

				arg_350_1.text_.text = var_353_5

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_7 = 25 <= 0 and var_353_4 or var_353_4 * (utf8.len(var_353_5) / 25)

				if (25 <= 0 and var_353_4 or var_353_4 * (utf8.len(var_353_5) / 25)) > 0 and var_353_4 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_3 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_3
					end
				end

				arg_350_1.text_.text = var_353_5
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_4, arg_350_1.talkMaxDuration)

			if var_353_3 <= arg_350_1.time_ and arg_350_1.time_ < var_353_3 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_3) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_3 + var_353_8 and arg_350_1.time_ < var_353_3 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play1104704087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1104704087
		arg_354_1.duration_ = 5.6

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1104704088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.725

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_1 = arg_354_1:GetWordFromCfg(1104704087)
				local var_357_2 = arg_354_1:FormatText(var_357_1.content)

				arg_354_1.text_.text = var_357_2

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_4 = 29 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 29)

				if (29 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_2) / 29)) > 0 and var_357_0 < var_357_4 then
					arg_354_1.talkMaxDuration = var_357_4

					if var_357_4 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_4 + 0
					end
				end

				arg_354_1.text_.text = var_357_2
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb") ~= 0 then
					local var_357_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb") / 1000

					if var_357_5 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + 0
					end

					if var_357_1.prefab_name ~= "" and arg_354_1.actors_[var_357_1.prefab_name] ~= nil then
						local var_357_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_1.prefab_name].transform, "story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb")

						arg_354_1:RecordAudio("1104704087", var_357_6)
						arg_354_1:RecordAudio("1104704087", var_357_6)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704087", "story_v_side_new_1104704.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_7 and arg_354_1.time_ < 0 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1104704088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1104704088
		arg_358_1.duration_ = 8.67

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1104704089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.95

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_1 = arg_358_1:GetWordFromCfg(1104704088)
				local var_361_2 = arg_358_1:FormatText(var_361_1.content)

				arg_358_1.text_.text = var_361_2

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 38 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 38)

				if (38 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 38)) > 0 and var_361_0 < var_361_4 then
					arg_358_1.talkMaxDuration = var_361_4

					if var_361_4 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_4 + 0
					end
				end

				arg_358_1.text_.text = var_361_2
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb") ~= 0 then
					local var_361_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb") / 1000

					if var_361_5 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + 0
					end

					if var_361_1.prefab_name ~= "" and arg_358_1.actors_[var_361_1.prefab_name] ~= nil then
						local var_361_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_1.prefab_name].transform, "story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb")

						arg_358_1:RecordAudio("1104704088", var_361_6)
						arg_358_1:RecordAudio("1104704088", var_361_6)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704088", "story_v_side_new_1104704.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1104704089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1104704089
		arg_362_1.duration_ = 9.1

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1104704090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 1.1

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_1 = arg_362_1:GetWordFromCfg(1104704089)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 44 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 44)

				if (44 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 44)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb")

						arg_362_1:RecordAudio("1104704089", var_365_6)
						arg_362_1:RecordAudio("1104704089", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704089", "story_v_side_new_1104704.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1104704090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1104704090
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1104704091(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.775

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(1104704090).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 31 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 31)

				if (31 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 31)) > 0 and var_369_0 < var_369_3 then
					arg_366_1.talkMaxDuration = var_369_3

					if var_369_3 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_3 + 0
					end
				end

				arg_366_1.text_.text = var_369_1
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_4 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_4

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1104704091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1104704091
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1104704092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 1.5

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(1104704091).content)

				arg_370_1.text_.text = var_373_1

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_3 = 60 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 60)

				if (60 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 60)) > 0 and var_373_0 < var_373_3 then
					arg_370_1.talkMaxDuration = var_373_3

					if var_373_3 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_3 + 0
					end
				end

				arg_370_1.text_.text = var_373_1
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_4 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_4

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1104704092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1104704092
		arg_374_1.duration_ = 4.73

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1104704093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1047ui_story = arg_374_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_377_0 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 then
				arg_374_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_374_1.time_ - 0) / var_377_0)
				arg_374_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1047ui_story"].transform.position).z)
				arg_374_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1047ui_story"].transform.localEulerAngles = arg_374_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 then
				arg_374_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_374_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1047ui_story"].transform.position).z)
				arg_374_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1047ui_story"].transform.localEulerAngles = arg_374_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_377_1 = arg_374_1.actors_["1047ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1047ui_story == nil then
				arg_374_1.var_.characterEffect1047ui_story = var_377_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_2 and not isNil(var_377_1) then
				if arg_374_1.var_.characterEffect1047ui_story and not isNil(var_377_1) then
					arg_374_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_2 and arg_374_1.time_ < 0 + var_377_2 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1047ui_story then
				arg_374_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_377_4 = 0
			local var_377_5 = 0.55

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_6 = arg_374_1:GetWordFromCfg(1104704092)
				local var_377_7 = arg_374_1:FormatText(var_377_6.content)

				arg_374_1.text_.text = var_377_7

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_9 = 22 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 22)

				if (22 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 22)) > 0 and var_377_5 < var_377_9 then
					arg_374_1.talkMaxDuration = var_377_9

					if var_377_9 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_9 + var_377_4
					end
				end

				arg_374_1.text_.text = var_377_7
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb") ~= 0 then
					local var_377_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb") / 1000

					if var_377_10 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_4
					end

					if var_377_6.prefab_name ~= "" and arg_374_1.actors_[var_377_6.prefab_name] ~= nil then
						local var_377_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_6.prefab_name].transform, "story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb")

						arg_374_1:RecordAudio("1104704092", var_377_11)
						arg_374_1:RecordAudio("1104704092", var_377_11)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704092", "story_v_side_new_1104704.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_12 = math.max(var_377_5, arg_374_1.talkMaxDuration)

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_12 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_4) / var_377_12

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_4 + var_377_12 and arg_374_1.time_ < var_377_4 + var_377_12 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play1104704093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1104704093
		arg_378_1.duration_ = 6.47

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1104704094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1047ui_story"]) and arg_378_1.var_.characterEffect1047ui_story == nil then
				arg_378_1.var_.characterEffect1047ui_story = arg_378_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1047ui_story"]) then
				if arg_378_1.var_.characterEffect1047ui_story and not isNil(arg_378_1.actors_["1047ui_story"]) then
					arg_378_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_0)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1047ui_story"]) and arg_378_1.var_.characterEffect1047ui_story then
				arg_378_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_381_1 = 0
			local var_381_2 = 0.725

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:GetWordFromCfg(1104704093)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_6 = 29 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_4) / 29)

				if (29 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_4) / 29)) > 0 and var_381_2 < var_381_6 then
					arg_378_1.talkMaxDuration = var_381_6

					if var_381_6 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb") ~= 0 then
					local var_381_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb") / 1000

					if var_381_7 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_1
					end

					if var_381_3.prefab_name ~= "" and arg_378_1.actors_[var_381_3.prefab_name] ~= nil then
						local var_381_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_3.prefab_name].transform, "story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb")

						arg_378_1:RecordAudio("1104704093", var_381_8)
						arg_378_1:RecordAudio("1104704093", var_381_8)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704093", "story_v_side_new_1104704.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_9 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_9 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_9

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_9 and arg_378_1.time_ < var_381_1 + var_381_9 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1104704094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1104704094
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1104704095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1047ui_story = arg_382_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1047ui_story"].transform.position).z)
				arg_382_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1047ui_story"].transform.localEulerAngles = arg_382_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_382_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1047ui_story"].transform.position).z)
				arg_382_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1047ui_story"].transform.localEulerAngles = arg_382_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_385_1 = 0
			local var_385_2 = 1.325

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(1104704094).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 53 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 53)

				if (53 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 53)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play1104704095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1104704095
		arg_386_1.duration_ = 3.9

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1104704096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos1047ui_story = arg_386_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_389_0 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 then
				arg_386_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_386_1.time_ - 0) / var_389_0)
				arg_386_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1047ui_story"].transform.position).z)
				arg_386_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1047ui_story"].transform.localEulerAngles = arg_386_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 then
				arg_386_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_386_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1047ui_story"].transform.position).z)
				arg_386_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1047ui_story"].transform.localEulerAngles = arg_386_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_389_1 = arg_386_1.actors_["1047ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1047ui_story == nil then
				arg_386_1.var_.characterEffect1047ui_story = var_389_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_2 and not isNil(var_389_1) then
				if arg_386_1.var_.characterEffect1047ui_story and not isNil(var_389_1) then
					arg_386_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_2 and arg_386_1.time_ < 0 + var_389_2 + arg_389_0 and not isNil(var_389_1) and arg_386_1.var_.characterEffect1047ui_story then
				arg_386_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_389_4 = 0
			local var_389_5 = 0.425

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_6 = arg_386_1:GetWordFromCfg(1104704095)
				local var_389_7 = arg_386_1:FormatText(var_389_6.content)

				arg_386_1.text_.text = var_389_7

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_9 = 17 <= 0 and var_389_5 or var_389_5 * (utf8.len(var_389_7) / 17)

				if (17 <= 0 and var_389_5 or var_389_5 * (utf8.len(var_389_7) / 17)) > 0 and var_389_5 < var_389_9 then
					arg_386_1.talkMaxDuration = var_389_9

					if var_389_9 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_9 + var_389_4
					end
				end

				arg_386_1.text_.text = var_389_7
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb") ~= 0 then
					local var_389_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb") / 1000

					if var_389_10 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_4
					end

					if var_389_6.prefab_name ~= "" and arg_386_1.actors_[var_389_6.prefab_name] ~= nil then
						local var_389_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_6.prefab_name].transform, "story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb")

						arg_386_1:RecordAudio("1104704095", var_389_11)
						arg_386_1:RecordAudio("1104704095", var_389_11)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704095", "story_v_side_new_1104704.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_12 = math.max(var_389_5, arg_386_1.talkMaxDuration)

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_12 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_4) / var_389_12

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_4 + var_389_12 and arg_386_1.time_ < var_389_4 + var_389_12 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play1104704096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1104704096
		arg_390_1.duration_ = 10.43

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1104704097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1047ui_story = arg_390_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_393_0 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				arg_390_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1047ui_story"].transform.position).z)
				arg_390_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1047ui_story"].transform.localEulerAngles = arg_390_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				arg_390_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_390_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1047ui_story"].transform.position).z)
				arg_390_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1047ui_story"].transform.localEulerAngles = arg_390_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action467")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_393_1 = 0
			local var_393_2 = 0.9

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_3 = arg_390_1:GetWordFromCfg(1104704096)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_6 = 36 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_4) / 36)

				if (36 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_4) / 36)) > 0 and var_393_2 < var_393_6 then
					arg_390_1.talkMaxDuration = var_393_6

					if var_393_6 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_1
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb") ~= 0 then
					local var_393_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb") / 1000

					if var_393_7 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_1
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb")

						arg_390_1:RecordAudio("1104704096", var_393_8)
						arg_390_1:RecordAudio("1104704096", var_393_8)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704096", "story_v_side_new_1104704.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_9 = math.max(var_393_2, arg_390_1.talkMaxDuration)

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_9 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_1) / var_393_9

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_1 + var_393_9 and arg_390_1.time_ < var_393_1 + var_393_9 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play1104704097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1104704097
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1104704098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1047ui_story"]) and arg_394_1.var_.characterEffect1047ui_story == nil then
				arg_394_1.var_.characterEffect1047ui_story = arg_394_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1047ui_story"]) then
				if arg_394_1.var_.characterEffect1047ui_story and not isNil(arg_394_1.actors_["1047ui_story"]) then
					arg_394_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_0)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1047ui_story"]) and arg_394_1.var_.characterEffect1047ui_story then
				arg_394_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_397_1 = arg_394_1.actors_["1047ui_story"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1047ui_story = var_397_1.localPosition
			end

			local var_397_2 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_2 then
				var_397_1.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_394_1.time_ - 0) / var_397_2)
				var_397_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_397_1.position).x, (manager.ui.mainCamera.transform.position - var_397_1.position).y, (manager.ui.mainCamera.transform.position - var_397_1.position).z)
				var_397_1.localEulerAngles.z = 0
				var_397_1.localEulerAngles.x = 0
				var_397_1.localEulerAngles = var_397_1.localEulerAngles
			end

			if arg_394_1.time_ >= 0 + var_397_2 and arg_394_1.time_ < 0 + var_397_2 + arg_397_0 then
				var_397_1.localPosition = Vector3.New(0, 100, 0)
				var_397_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_397_1.position).x, (manager.ui.mainCamera.transform.position - var_397_1.position).y, (manager.ui.mainCamera.transform.position - var_397_1.position).z)
				var_397_1.localEulerAngles.z = 0
				var_397_1.localEulerAngles.x = 0
				var_397_1.localEulerAngles = var_397_1.localEulerAngles
			end

			local var_397_3 = 0
			local var_397_4 = 0.8

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_3 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_5 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(1104704097).content)

				arg_394_1.text_.text = var_397_5

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_7 = 32 <= 0 and var_397_4 or var_397_4 * (utf8.len(var_397_5) / 32)

				if (32 <= 0 and var_397_4 or var_397_4 * (utf8.len(var_397_5) / 32)) > 0 and var_397_4 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_3 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_3
					end
				end

				arg_394_1.text_.text = var_397_5
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_8 = math.max(var_397_4, arg_394_1.talkMaxDuration)

			if var_397_3 <= arg_394_1.time_ and arg_394_1.time_ < var_397_3 + var_397_8 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_3) / var_397_8

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_3 + var_397_8 and arg_394_1.time_ < var_397_3 + var_397_8 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play1104704098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1104704098
		arg_398_1.duration_ = 4.9

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1104704099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.525

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_1 = arg_398_1:GetWordFromCfg(1104704098)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 21 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 21)

				if (21 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 21)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb")

						arg_398_1:RecordAudio("1104704098", var_401_6)
						arg_398_1:RecordAudio("1104704098", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704098", "story_v_side_new_1104704.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1104704099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1104704099
		arg_402_1.duration_ = 6.03

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1104704100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.85

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:GetWordFromCfg(1104704099)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 34 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 34)

				if (34 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 34)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb")

						arg_402_1:RecordAudio("1104704099", var_405_6)
						arg_402_1:RecordAudio("1104704099", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704099", "story_v_side_new_1104704.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1104704100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1104704100
		arg_406_1.duration_ = 3.1

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1104704101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.35

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:GetWordFromCfg(1104704100)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 14 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 14)

				if (14 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 14)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb")

						arg_406_1:RecordAudio("1104704100", var_409_6)
						arg_406_1:RecordAudio("1104704100", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704100", "story_v_side_new_1104704.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play1104704101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1104704101
		arg_410_1.duration_ = 4.57

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1104704102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.575

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_1 = arg_410_1:GetWordFromCfg(1104704101)
				local var_413_2 = arg_410_1:FormatText(var_413_1.content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 23 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 23)

				if (23 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 23)) > 0 and var_413_0 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + 0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb") ~= 0 then
					local var_413_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb") / 1000

					if var_413_5 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + 0
					end

					if var_413_1.prefab_name ~= "" and arg_410_1.actors_[var_413_1.prefab_name] ~= nil then
						local var_413_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_1.prefab_name].transform, "story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb")

						arg_410_1:RecordAudio("1104704101", var_413_6)
						arg_410_1:RecordAudio("1104704101", var_413_6)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704101", "story_v_side_new_1104704.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1104704102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1104704102
		arg_414_1.duration_ = 4.5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1104704103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1047ui_story = arg_414_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_417_0 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 then
				arg_414_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_414_1.time_ - 0) / var_417_0)
				arg_414_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1047ui_story"].transform.position).z)
				arg_414_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1047ui_story"].transform.localEulerAngles = arg_414_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 then
				arg_414_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_414_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1047ui_story"].transform.position).z)
				arg_414_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1047ui_story"].transform.localEulerAngles = arg_414_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_417_1 = arg_414_1.actors_["1047ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_1) and arg_414_1.var_.characterEffect1047ui_story == nil then
				arg_414_1.var_.characterEffect1047ui_story = var_417_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_2 and not isNil(var_417_1) then
				if arg_414_1.var_.characterEffect1047ui_story and not isNil(var_417_1) then
					arg_414_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_2 and arg_414_1.time_ < 0 + var_417_2 + arg_417_0 and not isNil(var_417_1) and arg_414_1.var_.characterEffect1047ui_story then
				arg_414_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_417_4 = 0
			local var_417_5 = 0.4

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_4 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_6 = arg_414_1:GetWordFromCfg(1104704102)
				local var_417_7 = arg_414_1:FormatText(var_417_6.content)

				arg_414_1.text_.text = var_417_7

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_9 = 16 <= 0 and var_417_5 or var_417_5 * (utf8.len(var_417_7) / 16)

				if (16 <= 0 and var_417_5 or var_417_5 * (utf8.len(var_417_7) / 16)) > 0 and var_417_5 < var_417_9 then
					arg_414_1.talkMaxDuration = var_417_9

					if var_417_9 + var_417_4 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_9 + var_417_4
					end
				end

				arg_414_1.text_.text = var_417_7
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb") ~= 0 then
					local var_417_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb") / 1000

					if var_417_10 + var_417_4 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_10 + var_417_4
					end

					if var_417_6.prefab_name ~= "" and arg_414_1.actors_[var_417_6.prefab_name] ~= nil then
						local var_417_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_6.prefab_name].transform, "story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb")

						arg_414_1:RecordAudio("1104704102", var_417_11)
						arg_414_1:RecordAudio("1104704102", var_417_11)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704102", "story_v_side_new_1104704.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_12 = math.max(var_417_5, arg_414_1.talkMaxDuration)

			if var_417_4 <= arg_414_1.time_ and arg_414_1.time_ < var_417_4 + var_417_12 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_4) / var_417_12

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_4 + var_417_12 and arg_414_1.time_ < var_417_4 + var_417_12 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play1104704103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1104704103
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1104704104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1047ui_story"]) and arg_418_1.var_.characterEffect1047ui_story == nil then
				arg_418_1.var_.characterEffect1047ui_story = arg_418_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1047ui_story"]) then
				if arg_418_1.var_.characterEffect1047ui_story and not isNil(arg_418_1.actors_["1047ui_story"]) then
					arg_418_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_0)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1047ui_story"]) and arg_418_1.var_.characterEffect1047ui_story then
				arg_418_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_421_1 = arg_418_1.actors_["1047ui_story"].transform

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos1047ui_story = var_421_1.localPosition
			end

			local var_421_2 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_2 then
				var_421_1.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_418_1.time_ - 0) / var_421_2)
				var_421_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_1.position).x, (manager.ui.mainCamera.transform.position - var_421_1.position).y, (manager.ui.mainCamera.transform.position - var_421_1.position).z)
				var_421_1.localEulerAngles.z = 0
				var_421_1.localEulerAngles.x = 0
				var_421_1.localEulerAngles = var_421_1.localEulerAngles
			end

			if arg_418_1.time_ >= 0 + var_421_2 and arg_418_1.time_ < 0 + var_421_2 + arg_421_0 then
				var_421_1.localPosition = Vector3.New(0, 100, 0)
				var_421_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_421_1.position).x, (manager.ui.mainCamera.transform.position - var_421_1.position).y, (manager.ui.mainCamera.transform.position - var_421_1.position).z)
				var_421_1.localEulerAngles.z = 0
				var_421_1.localEulerAngles.x = 0
				var_421_1.localEulerAngles = var_421_1.localEulerAngles
			end

			local var_421_3 = 0
			local var_421_4 = 0.45

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_3 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_5 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(1104704103).content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 18 <= 0 and var_421_4 or var_421_4 * (utf8.len(var_421_5) / 18)

				if (18 <= 0 and var_421_4 or var_421_4 * (utf8.len(var_421_5) / 18)) > 0 and var_421_4 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_3 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_3
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_8 = math.max(var_421_4, arg_418_1.talkMaxDuration)

			if var_421_3 <= arg_418_1.time_ and arg_418_1.time_ < var_421_3 + var_421_8 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_3) / var_421_8

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_3 + var_421_8 and arg_418_1.time_ < var_421_3 + var_421_8 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play1104704104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1104704104
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1104704105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.75

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_1 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(1104704104).content)

				arg_422_1.text_.text = var_425_1

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_3 = 30 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 30)

				if (30 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 30)) > 0 and var_425_0 < var_425_3 then
					arg_422_1.talkMaxDuration = var_425_3

					if var_425_3 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_3 + 0
					end
				end

				arg_422_1.text_.text = var_425_1
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_4 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_4

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1104704105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1104704105
		arg_426_1.duration_ = 2.4

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1104704106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos1047ui_story = arg_426_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_429_0 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 then
				arg_426_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_426_1.time_ - 0) / var_429_0)
				arg_426_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1047ui_story"].transform.position).z)
				arg_426_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["1047ui_story"].transform.localEulerAngles = arg_426_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 then
				arg_426_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_426_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1047ui_story"].transform.position).z)
				arg_426_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["1047ui_story"].transform.localEulerAngles = arg_426_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_429_1 = arg_426_1.actors_["1047ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect1047ui_story == nil then
				arg_426_1.var_.characterEffect1047ui_story = var_429_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_2 and not isNil(var_429_1) then
				if arg_426_1.var_.characterEffect1047ui_story and not isNil(var_429_1) then
					arg_426_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= 0 + var_429_2 and arg_426_1.time_ < 0 + var_429_2 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect1047ui_story then
				arg_426_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_429_4 = 0
			local var_429_5 = 0.3

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_4 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_6 = arg_426_1:GetWordFromCfg(1104704105)
				local var_429_7 = arg_426_1:FormatText(var_429_6.content)

				arg_426_1.text_.text = var_429_7

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_9 = 12 <= 0 and var_429_5 or var_429_5 * (utf8.len(var_429_7) / 12)

				if (12 <= 0 and var_429_5 or var_429_5 * (utf8.len(var_429_7) / 12)) > 0 and var_429_5 < var_429_9 then
					arg_426_1.talkMaxDuration = var_429_9

					if var_429_9 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_9 + var_429_4
					end
				end

				arg_426_1.text_.text = var_429_7
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb") ~= 0 then
					local var_429_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb") / 1000

					if var_429_10 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_10 + var_429_4
					end

					if var_429_6.prefab_name ~= "" and arg_426_1.actors_[var_429_6.prefab_name] ~= nil then
						local var_429_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_6.prefab_name].transform, "story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb")

						arg_426_1:RecordAudio("1104704105", var_429_11)
						arg_426_1:RecordAudio("1104704105", var_429_11)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704105", "story_v_side_new_1104704.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_12 = math.max(var_429_5, arg_426_1.talkMaxDuration)

			if var_429_4 <= arg_426_1.time_ and arg_426_1.time_ < var_429_4 + var_429_12 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_4) / var_429_12

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_4 + var_429_12 and arg_426_1.time_ < var_429_4 + var_429_12 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play1104704106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1104704106
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1104704107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1047ui_story"]) and arg_430_1.var_.characterEffect1047ui_story == nil then
				arg_430_1.var_.characterEffect1047ui_story = arg_430_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1047ui_story"]) then
				if arg_430_1.var_.characterEffect1047ui_story and not isNil(arg_430_1.actors_["1047ui_story"]) then
					arg_430_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_430_1.time_ - 0) / var_433_0)
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1047ui_story"]) and arg_430_1.var_.characterEffect1047ui_story then
				arg_430_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_433_1 = arg_430_1.actors_["1047ui_story"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1047ui_story = var_433_1.localPosition
			end

			local var_433_2 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 then
				var_433_1.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_430_1.time_ - 0) / var_433_2)
				var_433_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_1.position).x, (manager.ui.mainCamera.transform.position - var_433_1.position).y, (manager.ui.mainCamera.transform.position - var_433_1.position).z)
				var_433_1.localEulerAngles.z = 0
				var_433_1.localEulerAngles.x = 0
				var_433_1.localEulerAngles = var_433_1.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 then
				var_433_1.localPosition = Vector3.New(0, 100, 0)
				var_433_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_1.position).x, (manager.ui.mainCamera.transform.position - var_433_1.position).y, (manager.ui.mainCamera.transform.position - var_433_1.position).z)
				var_433_1.localEulerAngles.z = 0
				var_433_1.localEulerAngles.x = 0
				var_433_1.localEulerAngles = var_433_1.localEulerAngles
			end

			local var_433_3 = 0
			local var_433_4 = 0.1

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_3 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_5 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(1104704106).content)

				arg_430_1.text_.text = var_433_5

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_7 = 4 <= 0 and var_433_4 or var_433_4 * (utf8.len(var_433_5) / 4)

				if (4 <= 0 and var_433_4 or var_433_4 * (utf8.len(var_433_5) / 4)) > 0 and var_433_4 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_3 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_3
					end
				end

				arg_430_1.text_.text = var_433_5
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_8 = math.max(var_433_4, arg_430_1.talkMaxDuration)

			if var_433_3 <= arg_430_1.time_ and arg_430_1.time_ < var_433_3 + var_433_8 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_3) / var_433_8

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_3 + var_433_8 and arg_430_1.time_ < var_433_3 + var_433_8 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play1104704107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1104704107
		arg_434_1.duration_ = 1.73

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1104704108(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.125

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:GetWordFromCfg(1104704107)
				local var_437_2 = arg_434_1:FormatText(var_437_1.content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 5 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 5)

				if (5 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 5)) > 0 and var_437_0 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + 0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb") ~= 0 then
					local var_437_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb") / 1000

					if var_437_5 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + 0
					end

					if var_437_1.prefab_name ~= "" and arg_434_1.actors_[var_437_1.prefab_name] ~= nil then
						local var_437_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_1.prefab_name].transform, "story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb")

						arg_434_1:RecordAudio("1104704107", var_437_6)
						arg_434_1:RecordAudio("1104704107", var_437_6)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704107", "story_v_side_new_1104704.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1104704108 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1104704108
		arg_438_1.duration_ = 4.27

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1104704109(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = true

				arg_438_1:SetGaussion(false)
			end

			local var_441_0 = 2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 then
				local var_441_1 = Color.New(0, 0, 0)

				var_441_1.a = Mathf.Lerp(0, 1, (arg_438_1.time_ - 0) / var_441_0)
				arg_438_1.mask_.color = var_441_1
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 then
				local var_441_2 = Color.New(0, 0, 0)

				var_441_2.a = 1
				arg_438_1.mask_.color = var_441_2
			end

			local var_441_3 = 2

			if 2 < arg_438_1.time_ and arg_438_1.time_ <= var_441_3 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = true

				arg_438_1:SetGaussion(false)
			end

			local var_441_4 = 2

			if var_441_3 <= arg_438_1.time_ and arg_438_1.time_ < var_441_3 + var_441_4 then
				local var_441_5 = Color.New(0, 0, 0)

				var_441_5.a = Mathf.Lerp(1, 0, (arg_438_1.time_ - var_441_3) / var_441_4)
				arg_438_1.mask_.color = var_441_5
			end

			if arg_438_1.time_ >= var_441_3 + var_441_4 and arg_438_1.time_ < var_441_3 + var_441_4 + arg_441_0 then
				local var_441_6 = Color.New(0, 0, 0)

				arg_438_1.mask_.enabled = false
				var_441_6.a = 0
				arg_438_1.mask_.color = var_441_6
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1104704108,
				charCount = 34,
				enableLayoutChange = true,
				duration = 2.26666666666667,
				groupID = "shengrixuyuan",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play1104704109 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1104704109
		arg_442_1.duration_ = 1.73

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1104704110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			return
		end

		arg_442_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1104704109,
				charCount = 26,
				enableLayoutChange = true,
				duration = 1.73333333333333,
				groupID = "shengrixuyuan",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1104704110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1104704110
		arg_446_1.duration_ = 3.43

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1104704111(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_9000

			if arg_446_1.bgs_.STblack == nil then
				local var_449_0 = Object.Instantiate(arg_446_1.paintGo_)

				var_449_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_449_0.name = "STblack"
				var_449_0.transform.parent = arg_446_1.stage_.transform
				var_449_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_446_1.bgs_.STblack = var_449_0
			end

			if 0.7 < arg_446_1.time_ and arg_446_1.time_ <= 0.7 + arg_449_0 then
				local var_449_1 = arg_446_1.bgs_.STblack

				arg_446_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_449_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_449_2 = var_449_1:GetComponent("SpriteRenderer")

				if var_449_2 and var_449_2.sprite then
					local var_449_3 = 2 * (var_449_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_449_1.transform.localScale = Vector3.New(var_449_3 / var_449_2.sprite.bounds.size.y < var_449_3 * manager.ui.mainCameraCom_.aspect / var_449_2.sprite.bounds.size.x and var_449_3 * manager.ui.mainCameraCom_.aspect / var_449_2.sprite.bounds.size.x or var_449_3 / var_449_2.sprite.bounds.size.y, var_449_3 / var_449_2.sprite.bounds.size.y < var_449_3 * manager.ui.mainCameraCom_.aspect / var_449_2.sprite.bounds.size.x and var_449_3 * manager.ui.mainCameraCom_.aspect / var_449_2.sprite.bounds.size.x or var_449_3 / var_449_2.sprite.bounds.size.y, 0)
				end

				for iter_449_0, iter_449_1 in pairs(arg_446_1.bgs_) do
					if iter_449_0 ~= "STblack" then
						iter_449_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_449_4 = 2

			if 2 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			if arg_446_1.time_ >= var_449_4 + 0.3 and arg_446_1.time_ < var_449_4 + 0.3 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				local var_449_5 = arg_446_1.var_.effectzhuanchangyixia1

				if not arg_446_1.var_.effectzhuanchangyixia1 then
					var_449_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_449_5.name = "zhuanchangyixia1"
					arg_446_1.var_.effectzhuanchangyixia1 = var_449_5
				else
					var_449_5.transform:SetParent(var_449_9000)
				end

				var_449_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_449_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_449_7 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_449_5.transform.localScale = Vector3.New(var_449_5.transform.localScale.x * var_449_7, var_449_5.transform.localScale.y * var_449_7, var_449_5.transform.localScale.z * var_449_7)
			end

			if 0.3 < arg_446_1.time_ and arg_446_1.time_ <= 0.3 + arg_449_0 then
				arg_446_1:AudioAction("play", "effect", "se_story_151", "se_story_151_fire", "")
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				groupID = "shengrixuyuan",
				duration = 0.3,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1104704110,
				charCount = 31,
				enableLayoutChange = true,
				duration = 2.06666666666667,
				groupID = "shengrixuyuan1",
				startTime = 1.36666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play1104704111 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1104704111
		arg_450_1.duration_ = 2.13

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1104704112(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.2

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0

				arg_450_1.dialog_:SetActive(true)

				arg_450_1.dialogCg_.alpha = 0

				local var_453_2 = LeanTween.value(arg_450_1.dialog_, 0, 1, 0.3)

				var_453_2:setOnUpdate(LuaHelper.FloatAction(function(arg_454_0)
					arg_450_1.dialogCg_.alpha = arg_454_0
				end))
				var_453_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_450_1.dialog_)
					var_453_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_450_1.duration_ = arg_450_1.duration_ + 0.3

				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:GetWordFromCfg(1104704111)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_6 = 8 <= 0 and var_453_1 or var_453_1 * (utf8.len(var_453_4) / 8)

				if (8 <= 0 and var_453_1 or var_453_1 * (utf8.len(var_453_4) / 8)) > 0 and var_453_1 < var_453_6 then
					arg_450_1.talkMaxDuration = var_453_6
					var_453_0 = var_453_0 + 0.3

					if var_453_6 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_6 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_4
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb") ~= 0 then
					local var_453_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb") / 1000

					if var_453_7 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_0
					end

					if var_453_3.prefab_name ~= "" and arg_450_1.actors_[var_453_3.prefab_name] ~= nil then
						local var_453_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_3.prefab_name].transform, "story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb")

						arg_450_1:RecordAudio("1104704111", var_453_8)
						arg_450_1:RecordAudio("1104704111", var_453_8)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704111", "story_v_side_new_1104704.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_9 = var_453_0 + 0.3
			local var_453_10 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 + 0.3 <= arg_450_1.time_ and arg_450_1.time_ < var_453_9 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_9) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_9 + var_453_10 and arg_450_1.time_ < var_453_9 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				groupID = "shengrixuyuan2",
				duration = 1,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play1104704112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1104704112
		arg_456_1.duration_ = 1.97

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1104704113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0.225

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_1 = arg_456_1:GetWordFromCfg(1104704112)
				local var_459_2 = arg_456_1:FormatText(var_459_1.content)

				arg_456_1.text_.text = var_459_2

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_4 = 9 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 9)

				if (9 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_2) / 9)) > 0 and var_459_0 < var_459_4 then
					arg_456_1.talkMaxDuration = var_459_4

					if var_459_4 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_4 + 0
					end
				end

				arg_456_1.text_.text = var_459_2
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb") ~= 0 then
					local var_459_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb") / 1000

					if var_459_5 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + 0
					end

					if var_459_1.prefab_name ~= "" and arg_456_1.actors_[var_459_1.prefab_name] ~= nil then
						local var_459_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_1.prefab_name].transform, "story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb")

						arg_456_1:RecordAudio("1104704112", var_459_6)
						arg_456_1:RecordAudio("1104704112", var_459_6)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704112", "story_v_side_new_1104704.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_7 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_7 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_7

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_7 and arg_456_1.time_ < 0 + var_459_7 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1104704113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1104704113
		arg_460_1.duration_ = 7.03

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1104704114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				local var_463_0 = arg_460_1.bgs_.ST84a

				arg_460_1.bgs_.ST84a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_463_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_463_1 = var_463_0:GetComponent("SpriteRenderer")

				if var_463_1 and var_463_1.sprite then
					local var_463_2 = 2 * (var_463_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_463_0.transform.localScale = Vector3.New(var_463_2 / var_463_1.sprite.bounds.size.y < var_463_2 * manager.ui.mainCameraCom_.aspect / var_463_1.sprite.bounds.size.x and var_463_2 * manager.ui.mainCameraCom_.aspect / var_463_1.sprite.bounds.size.x or var_463_2 / var_463_1.sprite.bounds.size.y, var_463_2 / var_463_1.sprite.bounds.size.y < var_463_2 * manager.ui.mainCameraCom_.aspect / var_463_1.sprite.bounds.size.x and var_463_2 * manager.ui.mainCameraCom_.aspect / var_463_1.sprite.bounds.size.x or var_463_2 / var_463_1.sprite.bounds.size.y, 0)
				end

				for iter_463_0, iter_463_1 in pairs(arg_460_1.bgs_) do
					if iter_463_0 ~= "ST84a" then
						iter_463_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_463_3 = 2

			if 2 < arg_460_1.time_ and arg_460_1.time_ <= var_463_3 + arg_463_0 then
				arg_460_1.allBtn_.enabled = false
			end

			if arg_460_1.time_ >= var_463_3 + 0.273181093794604 and arg_460_1.time_ < var_463_3 + 0.273181093794604 + arg_463_0 then
				arg_460_1.allBtn_.enabled = true
			end

			local var_463_4 = 0

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_4 + arg_463_0 then
				arg_460_1.mask_.enabled = true
				arg_460_1.mask_.raycastTarget = true

				arg_460_1:SetGaussion(false)
			end

			local var_463_5 = 2

			if var_463_4 <= arg_460_1.time_ and arg_460_1.time_ < var_463_4 + var_463_5 then
				local var_463_6 = Color.New(0, 0, 0)

				var_463_6.a = Mathf.Lerp(1, 0, (arg_460_1.time_ - var_463_4) / var_463_5)
				arg_460_1.mask_.color = var_463_6
			end

			if arg_460_1.time_ >= var_463_4 + var_463_5 and arg_460_1.time_ < var_463_4 + var_463_5 + arg_463_0 then
				local var_463_7 = Color.New(0, 0, 0)

				arg_460_1.mask_.enabled = false
				var_463_7.a = 0
				arg_460_1.mask_.color = var_463_7
			end

			if 0.3 < arg_460_1.time_ and arg_460_1.time_ <= 0.3 + arg_463_0 then
				arg_460_1:AudioAction("play", "effect", "se_story_147", "se_story_147_light_button_off", "")
			end

			if arg_460_1.frameCnt_ <= 1 then
				arg_460_1.dialog_:SetActive(false)
			end

			local var_463_9 = 2
			local var_463_10 = 0.575

			if 2 < arg_460_1.time_ and arg_460_1.time_ <= var_463_9 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0

				arg_460_1.dialog_:SetActive(true)

				arg_460_1.dialogCg_.alpha = 0

				local var_463_11 = LeanTween.value(arg_460_1.dialog_, 0, 1, 0.3)

				var_463_11:setOnUpdate(LuaHelper.FloatAction(function(arg_464_0)
					arg_460_1.dialogCg_.alpha = arg_464_0
				end))
				var_463_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_460_1.dialog_)
					var_463_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_460_1.duration_ = arg_460_1.duration_ + 0.3

				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_12 = arg_460_1:GetWordFromCfg(1104704113)
				local var_463_13 = arg_460_1:FormatText(var_463_12.content)

				arg_460_1.text_.text = var_463_13

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_15 = 23 <= 0 and var_463_10 or var_463_10 * (utf8.len(var_463_13) / 23)

				if (23 <= 0 and var_463_10 or var_463_10 * (utf8.len(var_463_13) / 23)) > 0 and var_463_10 < var_463_15 then
					arg_460_1.talkMaxDuration = var_463_15
					var_463_9 = var_463_9 + 0.3

					if var_463_15 + var_463_9 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_15 + var_463_9
					end
				end

				arg_460_1.text_.text = var_463_13
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb") ~= 0 then
					local var_463_16 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb") / 1000

					if var_463_16 + var_463_9 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_16 + var_463_9
					end

					if var_463_12.prefab_name ~= "" and arg_460_1.actors_[var_463_12.prefab_name] ~= nil then
						local var_463_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_12.prefab_name].transform, "story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb")

						arg_460_1:RecordAudio("1104704113", var_463_17)
						arg_460_1:RecordAudio("1104704113", var_463_17)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704113", "story_v_side_new_1104704.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_18 = var_463_9 + 0.3
			local var_463_19 = math.max(var_463_10, arg_460_1.talkMaxDuration)

			if var_463_9 + 0.3 <= arg_460_1.time_ and arg_460_1.time_ < var_463_18 + var_463_19 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_18) / var_463_19

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_18 + var_463_19 and arg_460_1.time_ < var_463_18 + var_463_19 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1104704114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1104704114
		arg_466_1.duration_ = 1

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"

			SetActive(arg_466_1.choicesGo_, true)

			for iter_467_0, iter_467_1 in ipairs(arg_466_1.choices_) do
				SetActive(iter_467_1.go, iter_467_0 <= 2)
			end

			arg_466_1.choices_[1].txt.text = arg_466_1:FormatText(StoryChoiceCfg[1662].name)
			arg_466_1.choices_[2].txt.text = arg_466_1:FormatText(StoryChoiceCfg[1663].name)
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1104704115(arg_466_1)
			end

			if arg_468_0 == 2 then
				arg_466_0:Play1104704115(arg_466_1)
			end

			arg_466_1:RecordChoiceLog(1104704114, 1662, 1663)
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.allBtn_.enabled = false
			end

			if arg_466_1.time_ >= 0 + 0.566666666666667 and arg_466_1.time_ < 0 + 0.566666666666667 + arg_469_0 then
				arg_466_1.allBtn_.enabled = true
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1104704115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1104704115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1104704116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0.45

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_1 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(1104704115).content)

				arg_470_1.text_.text = var_473_1

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_3 = 18 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_1) / 18)

				if (18 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_1) / 18)) > 0 and var_473_0 < var_473_3 then
					arg_470_1.talkMaxDuration = var_473_3

					if var_473_3 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_3 + 0
					end
				end

				arg_470_1.text_.text = var_473_1
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_4 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_4 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_4

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_4 and arg_470_1.time_ < 0 + var_473_4 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1104704116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1104704116
		arg_474_1.duration_ = 4.1

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1104704117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0.5

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_1 = arg_474_1:GetWordFromCfg(1104704116)
				local var_477_2 = arg_474_1:FormatText(var_477_1.content)

				arg_474_1.text_.text = var_477_2

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_4 = 20 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_2) / 20)

				if (20 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_2) / 20)) > 0 and var_477_0 < var_477_4 then
					arg_474_1.talkMaxDuration = var_477_4

					if var_477_4 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_4 + 0
					end
				end

				arg_474_1.text_.text = var_477_2
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb") ~= 0 then
					local var_477_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb") / 1000

					if var_477_5 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + 0
					end

					if var_477_1.prefab_name ~= "" and arg_474_1.actors_[var_477_1.prefab_name] ~= nil then
						local var_477_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_1.prefab_name].transform, "story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb")

						arg_474_1:RecordAudio("1104704116", var_477_6)
						arg_474_1:RecordAudio("1104704116", var_477_6)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704116", "story_v_side_new_1104704.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_7 = math.max(var_477_0, arg_474_1.talkMaxDuration)

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_7 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - 0) / var_477_7

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= 0 + var_477_7 and arg_474_1.time_ < 0 + var_477_7 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play1104704117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1104704117
		arg_478_1.duration_ = 2.13

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1104704118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0.2

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_7")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_1 = arg_478_1:GetWordFromCfg(1104704117)
				local var_481_2 = arg_478_1:FormatText(var_481_1.content)

				arg_478_1.text_.text = var_481_2

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_4 = 8 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 8)

				if (8 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_2) / 8)) > 0 and var_481_0 < var_481_4 then
					arg_478_1.talkMaxDuration = var_481_4

					if var_481_4 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_4 + 0
					end
				end

				arg_478_1.text_.text = var_481_2
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb") ~= 0 then
					local var_481_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb") / 1000

					if var_481_5 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + 0
					end

					if var_481_1.prefab_name ~= "" and arg_478_1.actors_[var_481_1.prefab_name] ~= nil then
						local var_481_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_1.prefab_name].transform, "story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb")

						arg_478_1:RecordAudio("1104704117", var_481_6)
						arg_478_1:RecordAudio("1104704117", var_481_6)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704117", "story_v_side_new_1104704.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_7 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_7 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_7

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_7 and arg_478_1.time_ < 0 + var_481_7 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play1104704118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1104704118
		arg_482_1.duration_ = 4.17

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1104704119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.525

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_1 = arg_482_1:GetWordFromCfg(1104704118)
				local var_485_2 = arg_482_1:FormatText(var_485_1.content)

				arg_482_1.text_.text = var_485_2

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 21 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 21)

				if (21 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 21)) > 0 and var_485_0 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end

				arg_482_1.text_.text = var_485_2
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb") ~= 0 then
					local var_485_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb") / 1000

					if var_485_5 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + 0
					end

					if var_485_1.prefab_name ~= "" and arg_482_1.actors_[var_485_1.prefab_name] ~= nil then
						local var_485_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_1.prefab_name].transform, "story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb")

						arg_482_1:RecordAudio("1104704118", var_485_6)
						arg_482_1:RecordAudio("1104704118", var_485_6)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704118", "story_v_side_new_1104704.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1104704119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1104704119
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1104704120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0.825

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_1 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(1104704119).content)

				arg_486_1.text_.text = var_489_1

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_3 = 33 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 33)

				if (33 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_1) / 33)) > 0 and var_489_0 < var_489_3 then
					arg_486_1.talkMaxDuration = var_489_3

					if var_489_3 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_3 + 0
					end
				end

				arg_486_1.text_.text = var_489_1
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_4 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_4 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_4

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_4 and arg_486_1.time_ < 0 + var_489_4 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1104704120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1104704120
		arg_490_1.duration_ = 3.27

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1104704121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0.25

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_1 = arg_490_1:GetWordFromCfg(1104704120)
				local var_493_2 = arg_490_1:FormatText(var_493_1.content)

				arg_490_1.text_.text = var_493_2

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_4 = 10 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 10)

				if (10 <= 0 and var_493_0 or var_493_0 * (utf8.len(var_493_2) / 10)) > 0 and var_493_0 < var_493_4 then
					arg_490_1.talkMaxDuration = var_493_4

					if var_493_4 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_4 + 0
					end
				end

				arg_490_1.text_.text = var_493_2
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb") ~= 0 then
					local var_493_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb") / 1000

					if var_493_5 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + 0
					end

					if var_493_1.prefab_name ~= "" and arg_490_1.actors_[var_493_1.prefab_name] ~= nil then
						local var_493_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_1.prefab_name].transform, "story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb")

						arg_490_1:RecordAudio("1104704120", var_493_6)
						arg_490_1:RecordAudio("1104704120", var_493_6)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704120", "story_v_side_new_1104704.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_7 = math.max(var_493_0, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_7 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - 0) / var_493_7

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_7 and arg_490_1.time_ < 0 + var_493_7 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1104704121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1104704121
		arg_494_1.duration_ = 6.9

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1104704122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 2 < arg_494_1.time_ and arg_494_1.time_ <= 2 + arg_497_0 then
				arg_494_1.allBtn_.enabled = false
			end

			if arg_494_1.time_ >= 2 + 0.3 and arg_494_1.time_ < 2 + 0.3 + arg_497_0 then
				arg_494_1.allBtn_.enabled = true
			end

			local var_497_0 = 0

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_1 = 1

			if var_497_0 <= arg_494_1.time_ and arg_494_1.time_ < var_497_0 + var_497_1 then
				local var_497_2 = Color.New(0, 0, 0)

				var_497_2.a = Mathf.Lerp(0, 1, (arg_494_1.time_ - var_497_0) / var_497_1)
				arg_494_1.mask_.color = var_497_2
			end

			if arg_494_1.time_ >= var_497_0 + var_497_1 and arg_494_1.time_ < var_497_0 + var_497_1 + arg_497_0 then
				local var_497_3 = Color.New(0, 0, 0)

				var_497_3.a = 1
				arg_494_1.mask_.color = var_497_3
			end

			local var_497_4 = 1

			if 1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_4 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_5 = 1

			if var_497_4 <= arg_494_1.time_ and arg_494_1.time_ < var_497_4 + var_497_5 then
				local var_497_6 = Color.New(0, 0, 0)

				var_497_6.a = Mathf.Lerp(1, 0, (arg_494_1.time_ - var_497_4) / var_497_5)
				arg_494_1.mask_.color = var_497_6
			end

			if arg_494_1.time_ >= var_497_4 + var_497_5 and arg_494_1.time_ < var_497_4 + var_497_5 + arg_497_0 then
				local var_497_7 = Color.New(0, 0, 0)

				arg_494_1.mask_.enabled = false
				var_497_7.a = 0
				arg_494_1.mask_.color = var_497_7
			end

			local var_497_8 = 0

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_8 + arg_497_0 then
				arg_494_1.allBtn_.enabled = false
			end

			if arg_494_1.time_ >= var_497_8 + 1.674999999999 and arg_494_1.time_ < var_497_8 + 1.674999999999 + arg_497_0 then
				arg_494_1.allBtn_.enabled = true
			end

			if arg_494_1.frameCnt_ <= 1 then
				arg_494_1.dialog_:SetActive(false)
			end

			local var_497_9 = 2
			local var_497_10 = 0.325

			if 2 < arg_494_1.time_ and arg_494_1.time_ <= var_497_9 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0

				arg_494_1.dialog_:SetActive(true)

				arg_494_1.dialogCg_.alpha = 0

				local var_497_11 = LeanTween.value(arg_494_1.dialog_, 0, 1, 0.3)

				var_497_11:setOnUpdate(LuaHelper.FloatAction(function(arg_498_0)
					arg_494_1.dialogCg_.alpha = arg_498_0
				end))
				var_497_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_494_1.dialog_)
					var_497_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_494_1.duration_ = arg_494_1.duration_ + 0.3

				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_12 = arg_494_1:GetWordFromCfg(1104704121)
				local var_497_13 = arg_494_1:FormatText(var_497_12.content)

				arg_494_1.text_.text = var_497_13

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_15 = 13 <= 0 and var_497_10 or var_497_10 * (utf8.len(var_497_13) / 13)

				if (13 <= 0 and var_497_10 or var_497_10 * (utf8.len(var_497_13) / 13)) > 0 and var_497_10 < var_497_15 then
					arg_494_1.talkMaxDuration = var_497_15
					var_497_9 = var_497_9 + 0.3

					if var_497_15 + var_497_9 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_15 + var_497_9
					end
				end

				arg_494_1.text_.text = var_497_13
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb") ~= 0 then
					local var_497_16 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb") / 1000

					if var_497_16 + var_497_9 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_16 + var_497_9
					end

					if var_497_12.prefab_name ~= "" and arg_494_1.actors_[var_497_12.prefab_name] ~= nil then
						local var_497_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_12.prefab_name].transform, "story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb")

						arg_494_1:RecordAudio("1104704121", var_497_17)
						arg_494_1:RecordAudio("1104704121", var_497_17)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704121", "story_v_side_new_1104704.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_18 = var_497_9 + 0.3
			local var_497_19 = math.max(var_497_10, arg_494_1.talkMaxDuration)

			if var_497_9 + 0.3 <= arg_494_1.time_ and arg_494_1.time_ < var_497_18 + var_497_19 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_18) / var_497_19

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_18 + var_497_19 and arg_494_1.time_ < var_497_18 + var_497_19 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1104704122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1104704122
		arg_500_1.duration_ = 2.8

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1104704123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0.25

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_1 = arg_500_1:GetWordFromCfg(1104704122)
				local var_503_2 = arg_500_1:FormatText(var_503_1.content)

				arg_500_1.text_.text = var_503_2

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_4 = 10 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_2) / 10)

				if (10 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_2) / 10)) > 0 and var_503_0 < var_503_4 then
					arg_500_1.talkMaxDuration = var_503_4

					if var_503_4 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_4 + 0
					end
				end

				arg_500_1.text_.text = var_503_2
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb") ~= 0 then
					local var_503_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb") / 1000

					if var_503_5 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_5 + 0
					end

					if var_503_1.prefab_name ~= "" and arg_500_1.actors_[var_503_1.prefab_name] ~= nil then
						local var_503_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_1.prefab_name].transform, "story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb")

						arg_500_1:RecordAudio("1104704122", var_503_6)
						arg_500_1:RecordAudio("1104704122", var_503_6)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704122", "story_v_side_new_1104704.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_7 and arg_500_1.time_ < 0 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1104704123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1104704123
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1104704124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0.55

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_1 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(1104704123).content)

				arg_504_1.text_.text = var_507_1

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_3 = 22 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 22)

				if (22 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 22)) > 0 and var_507_0 < var_507_3 then
					arg_504_1.talkMaxDuration = var_507_3

					if var_507_3 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_3 + 0
					end
				end

				arg_504_1.text_.text = var_507_1
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_4 = math.max(var_507_0, arg_504_1.talkMaxDuration)

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - 0) / var_507_4

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1104704124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1104704124
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1104704125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 1.175

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, false)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_1 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(1104704124).content)

				arg_508_1.text_.text = var_511_1

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_3 = 47 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_1) / 47)

				if (47 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_1) / 47)) > 0 and var_511_0 < var_511_3 then
					arg_508_1.talkMaxDuration = var_511_3

					if var_511_3 + 0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_3 + 0
					end
				end

				arg_508_1.text_.text = var_511_1
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_4 = math.max(var_511_0, arg_508_1.talkMaxDuration)

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_4 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - 0) / var_511_4

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= 0 + var_511_4 and arg_508_1.time_ < 0 + var_511_4 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1104704125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1104704125
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play1104704126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0.166666666666667 < arg_512_1.time_ and arg_512_1.time_ <= 0.166666666666667 + arg_515_0 then
				arg_512_1:AudioAction("play", "music", "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_515_3 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if "" ~= "" then
					if arg_512_1.bgmTxt_.text ~= var_515_3 and arg_512_1.bgmTxt_.text ~= "" then
						if arg_512_1.bgmTxt2_.text ~= "" then
							arg_512_1.bgmTxt_.text = arg_512_1.bgmTxt2_.text
						end

						arg_512_1.bgmTxt2_.text = var_515_3

						arg_512_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_512_1.bgmTxt_.text = var_515_3
						arg_512_1.bgmTxt2_.text = var_515_3
					end

					if arg_512_1.bgmTimer then
						arg_512_1.bgmTimer:Stop()

						arg_512_1.bgmTimer = nil
					end

					if arg_512_1.settingData.show_music_name == 1 then
						arg_512_1.musicController:SetSelectedState("show")
						arg_512_1.musicAnimator_:Play("open", 0, 0)

						if arg_512_1.settingData.music_time ~= 0 then
							arg_512_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_512_1.settingData.music_time), function()
								if arg_512_1 == nil or isNil(arg_512_1.bgmTxt_) then
									return
								end

								arg_512_1.musicController:SetSelectedState("hide")
								arg_512_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_515_4 = 0
			local var_515_5 = 0.35

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_4 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_6 = arg_512_1:FormatText(arg_512_1:GetWordFromCfg(1104704125).content)

				arg_512_1.text_.text = var_515_6

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_8 = 14 <= 0 and var_515_5 or var_515_5 * (utf8.len(var_515_6) / 14)

				if (14 <= 0 and var_515_5 or var_515_5 * (utf8.len(var_515_6) / 14)) > 0 and var_515_5 < var_515_8 then
					arg_512_1.talkMaxDuration = var_515_8

					if var_515_8 + var_515_4 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_8 + var_515_4
					end
				end

				arg_512_1.text_.text = var_515_6
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_9 = math.max(var_515_5, arg_512_1.talkMaxDuration)

			if var_515_4 <= arg_512_1.time_ and arg_512_1.time_ < var_515_4 + var_515_9 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_4) / var_515_9

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_4 + var_515_9 and arg_512_1.time_ < var_515_4 + var_515_9 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1104704126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104704126
		arg_517_1.duration_ = 9

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1104704127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if arg_517_1.bgs_.R4701 == nil then
				local var_520_0 = Object.Instantiate(arg_517_1.paintGo_)

				var_520_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R4701")
				var_520_0.name = "R4701"
				var_520_0.transform.parent = arg_517_1.stage_.transform
				var_520_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_517_1.bgs_.R4701 = var_520_0
			end

			if 2 < arg_517_1.time_ and arg_517_1.time_ <= 2 + arg_520_0 then
				local var_520_1 = arg_517_1.bgs_.R4701

				arg_517_1.bgs_.R4701.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_520_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_520_2 = var_520_1:GetComponent("SpriteRenderer")

				if var_520_2 and var_520_2.sprite then
					local var_520_3 = 2 * (var_520_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_520_1.transform.localScale = Vector3.New(var_520_3 / var_520_2.sprite.bounds.size.y < var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x and var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x or var_520_3 / var_520_2.sprite.bounds.size.y, var_520_3 / var_520_2.sprite.bounds.size.y < var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x and var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x or var_520_3 / var_520_2.sprite.bounds.size.y, 0)
				end

				for iter_520_0, iter_520_1 in pairs(arg_517_1.bgs_) do
					if iter_520_0 ~= "R4701" then
						iter_520_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_520_4 = 4

			if 4 < arg_517_1.time_ and arg_517_1.time_ <= var_520_4 + arg_520_0 then
				arg_517_1.allBtn_.enabled = false
			end

			if arg_517_1.time_ >= var_520_4 + 0.3 and arg_517_1.time_ < var_520_4 + 0.3 + arg_520_0 then
				arg_517_1.allBtn_.enabled = true
			end

			local var_520_5 = 0

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_5 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_6 = 2

			if var_520_5 <= arg_517_1.time_ and arg_517_1.time_ < var_520_5 + var_520_6 then
				local var_520_7 = Color.New(0, 0, 0)

				var_520_7.a = Mathf.Lerp(0, 1, (arg_517_1.time_ - var_520_5) / var_520_6)
				arg_517_1.mask_.color = var_520_7
			end

			if arg_517_1.time_ >= var_520_5 + var_520_6 and arg_517_1.time_ < var_520_5 + var_520_6 + arg_520_0 then
				local var_520_8 = Color.New(0, 0, 0)

				var_520_8.a = 1
				arg_517_1.mask_.color = var_520_8
			end

			local var_520_9 = 2

			if 2 < arg_517_1.time_ and arg_517_1.time_ <= var_520_9 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_10 = 2

			if var_520_9 <= arg_517_1.time_ and arg_517_1.time_ < var_520_9 + var_520_10 then
				local var_520_11 = Color.New(0, 0, 0)

				var_520_11.a = Mathf.Lerp(1, 0, (arg_517_1.time_ - var_520_9) / var_520_10)
				arg_517_1.mask_.color = var_520_11
			end

			if arg_517_1.time_ >= var_520_9 + var_520_10 and arg_517_1.time_ < var_520_9 + var_520_10 + arg_520_0 then
				local var_520_12 = Color.New(0, 0, 0)

				arg_517_1.mask_.enabled = false
				var_520_12.a = 0
				arg_517_1.mask_.color = var_520_12
			end

			local var_520_13 = arg_517_1.bgs_.R4701.transform

			if 2 < arg_517_1.time_ and arg_517_1.time_ <= 2 + arg_520_0 then
				arg_517_1.var_.moveOldPosR4701 = var_520_13.localPosition
			end

			local var_520_14 = 3.05

			if 2 <= arg_517_1.time_ and arg_517_1.time_ < 2 + var_520_14 then
				var_520_13.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPosR4701, Vector3.New(0, 0, 6), (arg_517_1.time_ - 2) / var_520_14)
			end

			if arg_517_1.time_ >= 2 + var_520_14 and arg_517_1.time_ < 2 + var_520_14 + arg_520_0 then
				var_520_13.localPosition = Vector3.New(0, 0, 6)
			end

			if arg_517_1.frameCnt_ <= 1 then
				arg_517_1.dialog_:SetActive(false)
			end

			local var_520_15 = 4
			local var_520_16 = 1.05

			if 4 < arg_517_1.time_ and arg_517_1.time_ <= var_520_15 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0

				arg_517_1.dialog_:SetActive(true)

				arg_517_1.dialogCg_.alpha = 0

				local var_520_17 = LeanTween.value(arg_517_1.dialog_, 0, 1, 0.3)

				var_520_17:setOnUpdate(LuaHelper.FloatAction(function(arg_521_0)
					arg_517_1.dialogCg_.alpha = arg_521_0
				end))
				var_520_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_517_1.dialog_)
					var_520_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_517_1.duration_ = arg_517_1.duration_ + 0.3

				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_18 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(1104704126).content)

				arg_517_1.text_.text = var_520_18

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_20 = 42 <= 0 and var_520_16 or var_520_16 * (utf8.len(var_520_18) / 42)

				if (42 <= 0 and var_520_16 or var_520_16 * (utf8.len(var_520_18) / 42)) > 0 and var_520_16 < var_520_20 then
					arg_517_1.talkMaxDuration = var_520_20
					var_520_15 = var_520_15 + 0.3

					if var_520_20 + var_520_15 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_20 + var_520_15
					end
				end

				arg_517_1.text_.text = var_520_18
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_21 = var_520_15 + 0.3
			local var_520_22 = math.max(var_520_16, arg_517_1.talkMaxDuration)

			if var_520_15 + 0.3 <= arg_517_1.time_ and arg_517_1.time_ < var_520_21 + var_520_22 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_21) / var_520_22

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_21 + var_520_22 and arg_517_1.time_ < var_520_21 + var_520_22 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R4701",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.05,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 4),
					endPos = Vector3.New(0, 0, 6),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104704127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1104704127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1104704128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0.125

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1104704127).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 5 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 5)

				if (5 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 5)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1104704128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1104704128
		arg_527_1.duration_ = 4.13

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1104704129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.2

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:GetWordFromCfg(1104704128)
				local var_530_2 = arg_527_1:FormatText(var_530_1.content)

				arg_527_1.text_.text = var_530_2

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 8 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 8)

				if (8 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 8)) > 0 and var_530_0 < var_530_4 then
					arg_527_1.talkMaxDuration = var_530_4

					if var_530_4 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_4 + 0
					end
				end

				arg_527_1.text_.text = var_530_2
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb") ~= 0 then
					local var_530_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb") / 1000

					if var_530_5 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + 0
					end

					if var_530_1.prefab_name ~= "" and arg_527_1.actors_[var_530_1.prefab_name] ~= nil then
						local var_530_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_1.prefab_name].transform, "story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb")

						arg_527_1:RecordAudio("1104704128", var_530_6)
						arg_527_1:RecordAudio("1104704128", var_530_6)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704128", "story_v_side_new_1104704.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1104704129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1104704129
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1104704130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.775

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_1 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(1104704129).content)

				arg_531_1.text_.text = var_534_1

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_3 = 31 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 31)

				if (31 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 31)) > 0 and var_534_0 < var_534_3 then
					arg_531_1.talkMaxDuration = var_534_3

					if var_534_3 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_3 + 0
					end
				end

				arg_531_1.text_.text = var_534_1
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_4 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_4 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_4

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_4 and arg_531_1.time_ < 0 + var_534_4 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1104704130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1104704130
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1104704131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPosR4701 = arg_535_1.bgs_.R4701.transform.localPosition
			end

			local var_538_0 = 3.05

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 then
				arg_535_1.bgs_.R4701.transform.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPosR4701, Vector3.New(0, 0, 5.5), (arg_535_1.time_ - 0) / var_538_0)
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 then
				arg_535_1.bgs_.R4701.transform.localPosition = Vector3.New(0, 0, 5.5)
			end

			local var_538_1 = 0
			local var_538_2 = 1.05

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_3 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(1104704130).content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 42 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 42)

				if (42 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 42)) > 0 and var_538_2 < var_538_5 then
					arg_535_1.talkMaxDuration = var_538_5

					if var_538_5 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + var_538_1
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_6 = math.max(var_538_2, arg_535_1.talkMaxDuration)

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_6 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_1) / var_538_6

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_1 + var_538_6 and arg_535_1.time_ < var_538_1 + var_538_6 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R4701",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.05,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 6),
					endPos = Vector3.New(0, 0, 5.5),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play1104704131 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1104704131
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1104704132(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0.375

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_1 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(1104704131).content)

				arg_539_1.text_.text = var_542_1

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_3 = 15 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 15)

				if (15 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 15)) > 0 and var_542_0 < var_542_3 then
					arg_539_1.talkMaxDuration = var_542_3

					if var_542_3 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_3 + 0
					end
				end

				arg_539_1.text_.text = var_542_1
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_4 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_4 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_4

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_4 and arg_539_1.time_ < 0 + var_542_4 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1104704132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1104704132
		arg_543_1.duration_ = 6.7

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1104704133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_9000

			if arg_543_1.bgs_.R4701a == nil then
				local var_546_0 = Object.Instantiate(arg_543_1.paintGo_)

				var_546_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R4701a")
				var_546_0.name = "R4701a"
				var_546_0.transform.parent = arg_543_1.stage_.transform
				var_546_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_543_1.bgs_.R4701a = var_546_0
			end

			if 0.533333333333333 < arg_543_1.time_ and arg_543_1.time_ <= 0.533333333333333 + arg_546_0 then
				local var_546_1 = arg_543_1.bgs_.R4701a

				arg_543_1.bgs_.R4701a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_546_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_546_2 = var_546_1:GetComponent("SpriteRenderer")

				if var_546_2 and var_546_2.sprite then
					local var_546_3 = 2 * (var_546_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_546_1.transform.localScale = Vector3.New(var_546_3 / var_546_2.sprite.bounds.size.y < var_546_3 * manager.ui.mainCameraCom_.aspect / var_546_2.sprite.bounds.size.x and var_546_3 * manager.ui.mainCameraCom_.aspect / var_546_2.sprite.bounds.size.x or var_546_3 / var_546_2.sprite.bounds.size.y, var_546_3 / var_546_2.sprite.bounds.size.y < var_546_3 * manager.ui.mainCameraCom_.aspect / var_546_2.sprite.bounds.size.x and var_546_3 * manager.ui.mainCameraCom_.aspect / var_546_2.sprite.bounds.size.x or var_546_3 / var_546_2.sprite.bounds.size.y, 0)
				end

				for iter_546_0, iter_546_1 in pairs(arg_543_1.bgs_) do
					if iter_546_0 ~= "R4701a" then
						iter_546_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_546_4 = 1.699999999999

			if 1.699999999999 < arg_543_1.time_ and arg_543_1.time_ <= var_546_4 + arg_546_0 then
				arg_543_1.allBtn_.enabled = false
			end

			if arg_543_1.time_ >= var_546_4 + 0.3 and arg_543_1.time_ < var_546_4 + 0.3 + arg_546_0 then
				arg_543_1.allBtn_.enabled = true
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				local var_546_5 = arg_543_1.var_.effectzhuanchangyixia1

				if not arg_543_1.var_.effectzhuanchangyixia1 then
					var_546_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_546_5.name = "zhuanchangyixia1"
					arg_543_1.var_.effectzhuanchangyixia1 = var_546_5
				else
					var_546_5.transform:SetParent(var_546_9000)
				end

				var_546_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_546_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_546_7 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_546_5.transform.localScale = Vector3.New(var_546_5.transform.localScale.x * var_546_7, var_546_5.transform.localScale.y * var_546_7, var_546_5.transform.localScale.z * var_546_7)
			end

			local var_546_8 = arg_543_1.bgs_.R4701.transform

			if 0.533333333333333 < arg_543_1.time_ and arg_543_1.time_ <= 0.533333333333333 + arg_546_0 then
				arg_543_1.var_.moveOldPosR4701 = var_546_8.localPosition
			end

			local var_546_9 = 1.7

			if 0.533333333333333 <= arg_543_1.time_ and arg_543_1.time_ < 0.533333333333333 + var_546_9 then
				var_546_8.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPosR4701, Vector3.New(0, 0, -2000), (arg_543_1.time_ - 0.533333333333333) / var_546_9)
			end

			if arg_543_1.time_ >= 0.533333333333333 + var_546_9 and arg_543_1.time_ < 0.533333333333333 + var_546_9 + arg_546_0 then
				var_546_8.localPosition = Vector3.New(0, 0, -2000)
			end

			if arg_543_1.frameCnt_ <= 1 then
				arg_543_1.dialog_:SetActive(false)
			end

			local var_546_10 = 1.699999999999
			local var_546_11 = 0.825

			if 1.699999999999 < arg_543_1.time_ and arg_543_1.time_ <= var_546_10 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0

				arg_543_1.dialog_:SetActive(true)

				arg_543_1.dialogCg_.alpha = 0

				local var_546_12 = LeanTween.value(arg_543_1.dialog_, 0, 1, 0.3)

				var_546_12:setOnUpdate(LuaHelper.FloatAction(function(arg_547_0)
					arg_543_1.dialogCg_.alpha = arg_547_0
				end))
				var_546_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_543_1.dialog_)
					var_546_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_543_1.duration_ = arg_543_1.duration_ + 0.3

				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_13 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(1104704132).content)

				arg_543_1.text_.text = var_546_13

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_15 = 33 <= 0 and var_546_11 or var_546_11 * (utf8.len(var_546_13) / 33)

				if (33 <= 0 and var_546_11 or var_546_11 * (utf8.len(var_546_13) / 33)) > 0 and var_546_11 < var_546_15 then
					arg_543_1.talkMaxDuration = var_546_15
					var_546_10 = var_546_10 + 0.3

					if var_546_15 + var_546_10 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_15 + var_546_10
					end
				end

				arg_543_1.text_.text = var_546_13
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_16 = var_546_10 + 0.3
			local var_546_17 = math.max(var_546_11, arg_543_1.talkMaxDuration)

			if var_546_10 + 0.3 <= arg_543_1.time_ and arg_543_1.time_ < var_546_16 + var_546_17 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_16) / var_546_17

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_16 + var_546_17 and arg_543_1.time_ < var_546_16 + var_546_17 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R4701",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.7,
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, -2000),
					endPos = Vector3.New(0, 0, -2000),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play1104704133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1104704133
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1104704134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 1

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_1 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(1104704133).content)

				arg_549_1.text_.text = var_552_1

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_3 = 40 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 40)

				if (40 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 40)) > 0 and var_552_0 < var_552_3 then
					arg_549_1.talkMaxDuration = var_552_3

					if var_552_3 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_3 + 0
					end
				end

				arg_549_1.text_.text = var_552_1
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_4 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_4 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_4

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_4 and arg_549_1.time_ < 0 + var_552_4 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1104704134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1104704134
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1104704135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0.875

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_1 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(1104704134).content)

				arg_553_1.text_.text = var_556_1

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_3 = 35 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 35)

				if (35 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 35)) > 0 and var_556_0 < var_556_3 then
					arg_553_1.talkMaxDuration = var_556_3

					if var_556_3 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_3 + 0
					end
				end

				arg_553_1.text_.text = var_556_1
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_4 = math.max(var_556_0, arg_553_1.talkMaxDuration)

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_4 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - 0) / var_556_4

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= 0 + var_556_4 and arg_553_1.time_ < 0 + var_556_4 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1104704135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1104704135
		arg_557_1.duration_ = 8.97

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1104704136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.55

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_1 = arg_557_1:GetWordFromCfg(1104704135)
				local var_560_2 = arg_557_1:FormatText(var_560_1.content)

				arg_557_1.text_.text = var_560_2

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 22 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 22)

				if (22 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 22)) > 0 and var_560_0 < var_560_4 then
					arg_557_1.talkMaxDuration = var_560_4

					if var_560_4 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_4 + 0
					end
				end

				arg_557_1.text_.text = var_560_2
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb") ~= 0 then
					local var_560_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb") / 1000

					if var_560_5 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + 0
					end

					if var_560_1.prefab_name ~= "" and arg_557_1.actors_[var_560_1.prefab_name] ~= nil then
						local var_560_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_1.prefab_name].transform, "story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb")

						arg_557_1:RecordAudio("1104704135", var_560_6)
						arg_557_1:RecordAudio("1104704135", var_560_6)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704135", "story_v_side_new_1104704.awb")
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
	Play1104704136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1104704136
		arg_561_1.duration_ = 6.57

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1104704137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPosR4701a = arg_561_1.bgs_.R4701a.transform.localPosition
			end

			local var_564_0 = 2.46666666666667

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 then
				arg_561_1.bgs_.R4701a.transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPosR4701a, Vector3.New(0, 2, 7), (arg_561_1.time_ - 0) / var_564_0)
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 then
				arg_561_1.bgs_.R4701a.transform.localPosition = Vector3.New(0, 2, 7)
			end

			local var_564_1 = 0

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.allBtn_.enabled = false
			end

			if arg_561_1.time_ >= var_564_1 + 1.674999999999 and arg_561_1.time_ < var_564_1 + 1.674999999999 + arg_564_0 then
				arg_561_1.allBtn_.enabled = true
			end

			if arg_561_1.frameCnt_ <= 1 then
				arg_561_1.dialog_:SetActive(false)
			end

			local var_564_2 = 1.56666666666667
			local var_564_3 = 0.9

			if 1.56666666666667 < arg_561_1.time_ and arg_561_1.time_ <= var_564_2 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0

				arg_561_1.dialog_:SetActive(true)

				arg_561_1.dialogCg_.alpha = 0

				local var_564_4 = LeanTween.value(arg_561_1.dialog_, 0, 1, 0.3)

				var_564_4:setOnUpdate(LuaHelper.FloatAction(function(arg_565_0)
					arg_561_1.dialogCg_.alpha = arg_565_0
				end))
				var_564_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_561_1.dialog_)
					var_564_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_561_1.duration_ = arg_561_1.duration_ + 0.3

				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_5 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(1104704136).content)

				arg_561_1.text_.text = var_564_5

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_7 = 36 <= 0 and var_564_3 or var_564_3 * (utf8.len(var_564_5) / 36)

				if (36 <= 0 and var_564_3 or var_564_3 * (utf8.len(var_564_5) / 36)) > 0 and var_564_3 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7
					var_564_2 = var_564_2 + 0.3

					if var_564_7 + var_564_2 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_2
					end
				end

				arg_561_1.text_.text = var_564_5
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_8 = var_564_2 + 0.3
			local var_564_9 = math.max(var_564_3, arg_561_1.talkMaxDuration)

			if var_564_2 + 0.3 <= arg_561_1.time_ and arg_561_1.time_ < var_564_8 + var_564_9 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_8) / var_564_9

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_8 + var_564_9 and arg_561_1.time_ < var_564_8 + var_564_9 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R4701a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.46666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 2, 7),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play1104704137 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1104704137
		arg_567_1.duration_ = 7.78

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1104704138(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 2 < arg_567_1.time_ and arg_567_1.time_ <= 2 + arg_570_0 then
				local var_570_0 = arg_567_1.bgs_.STblack

				arg_567_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_570_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_570_1 = var_570_0:GetComponent("SpriteRenderer")

				if var_570_1 and var_570_1.sprite then
					local var_570_2 = 2 * (var_570_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_570_0.transform.localScale = Vector3.New(var_570_2 / var_570_1.sprite.bounds.size.y < var_570_2 * manager.ui.mainCameraCom_.aspect / var_570_1.sprite.bounds.size.x and var_570_2 * manager.ui.mainCameraCom_.aspect / var_570_1.sprite.bounds.size.x or var_570_2 / var_570_1.sprite.bounds.size.y, var_570_2 / var_570_1.sprite.bounds.size.y < var_570_2 * manager.ui.mainCameraCom_.aspect / var_570_1.sprite.bounds.size.x and var_570_2 * manager.ui.mainCameraCom_.aspect / var_570_1.sprite.bounds.size.x or var_570_2 / var_570_1.sprite.bounds.size.y, 0)
				end

				for iter_570_0, iter_570_1 in pairs(arg_567_1.bgs_) do
					if iter_570_0 ~= "STblack" then
						iter_570_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_570_3 = 0

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_3 + arg_570_0 then
				arg_567_1.mask_.enabled = true
				arg_567_1.mask_.raycastTarget = true

				arg_567_1:SetGaussion(false)
			end

			local var_570_4 = 2

			if var_570_3 <= arg_567_1.time_ and arg_567_1.time_ < var_570_3 + var_570_4 then
				local var_570_5 = Color.New(0, 0, 0)

				var_570_5.a = Mathf.Lerp(0, 1, (arg_567_1.time_ - var_570_3) / var_570_4)
				arg_567_1.mask_.color = var_570_5
			end

			if arg_567_1.time_ >= var_570_3 + var_570_4 and arg_567_1.time_ < var_570_3 + var_570_4 + arg_570_0 then
				local var_570_6 = Color.New(0, 0, 0)

				var_570_6.a = 1
				arg_567_1.mask_.color = var_570_6
			end

			local var_570_7 = 2

			if 2 < arg_567_1.time_ and arg_567_1.time_ <= var_570_7 + arg_570_0 then
				arg_567_1.mask_.enabled = true
				arg_567_1.mask_.raycastTarget = true

				arg_567_1:SetGaussion(false)
			end

			local var_570_8 = 2

			if var_570_7 <= arg_567_1.time_ and arg_567_1.time_ < var_570_7 + var_570_8 then
				local var_570_9 = Color.New(0, 0, 0)

				var_570_9.a = Mathf.Lerp(1, 0, (arg_567_1.time_ - var_570_7) / var_570_8)
				arg_567_1.mask_.color = var_570_9
			end

			if arg_567_1.time_ >= var_570_7 + var_570_8 and arg_567_1.time_ < var_570_7 + var_570_8 + arg_570_0 then
				local var_570_10 = Color.New(0, 0, 0)

				arg_567_1.mask_.enabled = false
				var_570_10.a = 0
				arg_567_1.mask_.color = var_570_10
			end

			if arg_567_1.frameCnt_ <= 1 then
				arg_567_1.dialog_:SetActive(false)
			end

			local var_570_11 = 2.775
			local var_570_12 = 1.225

			if 2.775 < arg_567_1.time_ and arg_567_1.time_ <= var_570_11 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0

				arg_567_1.dialog_:SetActive(true)

				arg_567_1.dialogCg_.alpha = 0

				local var_570_13 = LeanTween.value(arg_567_1.dialog_, 0, 1, 0.3)

				var_570_13:setOnUpdate(LuaHelper.FloatAction(function(arg_571_0)
					arg_567_1.dialogCg_.alpha = arg_571_0
				end))
				var_570_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_567_1.dialog_)
					var_570_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_567_1.duration_ = arg_567_1.duration_ + 0.3

				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_14 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(1104704137).content)

				arg_567_1.text_.text = var_570_14

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_16 = 49 <= 0 and var_570_12 or var_570_12 * (utf8.len(var_570_14) / 49)

				if (49 <= 0 and var_570_12 or var_570_12 * (utf8.len(var_570_14) / 49)) > 0 and var_570_12 < var_570_16 then
					arg_567_1.talkMaxDuration = var_570_16
					var_570_11 = var_570_11 + 0.3

					if var_570_16 + var_570_11 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_16 + var_570_11
					end
				end

				arg_567_1.text_.text = var_570_14
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_17 = var_570_11 + 0.3
			local var_570_18 = math.max(var_570_12, arg_567_1.talkMaxDuration)

			if var_570_11 + 0.3 <= arg_567_1.time_ and arg_567_1.time_ < var_570_17 + var_570_18 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_17) / var_570_18

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_17 + var_570_18 and arg_567_1.time_ < var_570_17 + var_570_18 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1104704138 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1104704138
		arg_573_1.duration_ = 4.53

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1104704139(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if arg_573_1.bgs_.ST05a == nil then
				local var_576_0 = Object.Instantiate(arg_573_1.paintGo_)

				var_576_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05a")
				var_576_0.name = "ST05a"
				var_576_0.transform.parent = arg_573_1.stage_.transform
				var_576_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_573_1.bgs_.ST05a = var_576_0
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				local var_576_1 = arg_573_1.bgs_.ST05a

				arg_573_1.bgs_.ST05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_576_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_576_2 = var_576_1:GetComponent("SpriteRenderer")

				if var_576_2 and var_576_2.sprite then
					local var_576_3 = 2 * (var_576_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_576_1.transform.localScale = Vector3.New(var_576_3 / var_576_2.sprite.bounds.size.y < var_576_3 * manager.ui.mainCameraCom_.aspect / var_576_2.sprite.bounds.size.x and var_576_3 * manager.ui.mainCameraCom_.aspect / var_576_2.sprite.bounds.size.x or var_576_3 / var_576_2.sprite.bounds.size.y, var_576_3 / var_576_2.sprite.bounds.size.y < var_576_3 * manager.ui.mainCameraCom_.aspect / var_576_2.sprite.bounds.size.x and var_576_3 * manager.ui.mainCameraCom_.aspect / var_576_2.sprite.bounds.size.x or var_576_3 / var_576_2.sprite.bounds.size.y, 0)
				end

				for iter_576_0, iter_576_1 in pairs(arg_573_1.bgs_) do
					if iter_576_0 ~= "ST05a" then
						iter_576_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_576_4 = 1.999999999999

			if 1.999999999999 < arg_573_1.time_ and arg_573_1.time_ <= var_576_4 + arg_576_0 then
				arg_573_1.allBtn_.enabled = false
			end

			if arg_573_1.time_ >= var_576_4 + 0.3 and arg_573_1.time_ < var_576_4 + 0.3 + arg_576_0 then
				arg_573_1.allBtn_.enabled = true
			end

			local var_576_5 = 0

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_5 + arg_576_0 then
				arg_573_1.mask_.enabled = true
				arg_573_1.mask_.raycastTarget = true

				arg_573_1:SetGaussion(false)
			end

			local var_576_6 = 2

			if var_576_5 <= arg_573_1.time_ and arg_573_1.time_ < var_576_5 + var_576_6 then
				local var_576_7 = Color.New(0, 0, 0)

				var_576_7.a = Mathf.Lerp(1, 0, (arg_573_1.time_ - var_576_5) / var_576_6)
				arg_573_1.mask_.color = var_576_7
			end

			if arg_573_1.time_ >= var_576_5 + var_576_6 and arg_573_1.time_ < var_576_5 + var_576_6 + arg_576_0 then
				local var_576_8 = Color.New(0, 0, 0)

				arg_573_1.mask_.enabled = false
				var_576_8.a = 0
				arg_573_1.mask_.color = var_576_8
			end

			if 1.2 < arg_573_1.time_ and arg_573_1.time_ <= 1.2 + arg_576_0 then
				arg_573_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_club", "")
			end

			if 0.1 < arg_573_1.time_ and arg_573_1.time_ <= 0.1 + arg_576_0 then
				arg_573_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_573_1.frameCnt_ <= 1 then
				arg_573_1.dialog_:SetActive(false)
			end

			local var_576_11 = 2
			local var_576_12 = 0.35

			if 2 < arg_573_1.time_ and arg_573_1.time_ <= var_576_11 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0

				arg_573_1.dialog_:SetActive(true)

				arg_573_1.dialogCg_.alpha = 0

				local var_576_13 = LeanTween.value(arg_573_1.dialog_, 0, 1, 0.3)

				var_576_13:setOnUpdate(LuaHelper.FloatAction(function(arg_577_0)
					arg_573_1.dialogCg_.alpha = arg_577_0
				end))
				var_576_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_573_1.dialog_)
					var_576_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_573_1.duration_ = arg_573_1.duration_ + 0.3

				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_14 = arg_573_1:GetWordFromCfg(1104704138)
				local var_576_15 = arg_573_1:FormatText(var_576_14.content)

				arg_573_1.text_.text = var_576_15

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_17 = 14 <= 0 and var_576_12 or var_576_12 * (utf8.len(var_576_15) / 14)

				if (14 <= 0 and var_576_12 or var_576_12 * (utf8.len(var_576_15) / 14)) > 0 and var_576_12 < var_576_17 then
					arg_573_1.talkMaxDuration = var_576_17
					var_576_11 = var_576_11 + 0.3

					if var_576_17 + var_576_11 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_17 + var_576_11
					end
				end

				arg_573_1.text_.text = var_576_15
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb") ~= 0 then
					local var_576_18 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb") / 1000

					if var_576_18 + var_576_11 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_18 + var_576_11
					end

					if var_576_14.prefab_name ~= "" and arg_573_1.actors_[var_576_14.prefab_name] ~= nil then
						local var_576_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_14.prefab_name].transform, "story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb")

						arg_573_1:RecordAudio("1104704138", var_576_19)
						arg_573_1:RecordAudio("1104704138", var_576_19)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704138", "story_v_side_new_1104704.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_20 = var_576_11 + 0.3
			local var_576_21 = math.max(var_576_12, arg_573_1.talkMaxDuration)

			if var_576_11 + 0.3 <= arg_573_1.time_ and arg_573_1.time_ < var_576_20 + var_576_21 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_20) / var_576_21

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_20 + var_576_21 and arg_573_1.time_ < var_576_20 + var_576_21 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1104704139 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1104704139
		arg_579_1.duration_ = 7.4

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1104704140(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0.875

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_1 = arg_579_1:GetWordFromCfg(1104704139)
				local var_582_2 = arg_579_1:FormatText(var_582_1.content)

				arg_579_1.text_.text = var_582_2

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_4 = 35 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 35)

				if (35 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 35)) > 0 and var_582_0 < var_582_4 then
					arg_579_1.talkMaxDuration = var_582_4

					if var_582_4 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_4 + 0
					end
				end

				arg_579_1.text_.text = var_582_2
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb") ~= 0 then
					local var_582_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb") / 1000

					if var_582_5 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + 0
					end

					if var_582_1.prefab_name ~= "" and arg_579_1.actors_[var_582_1.prefab_name] ~= nil then
						local var_582_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_1.prefab_name].transform, "story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb")

						arg_579_1:RecordAudio("1104704139", var_582_6)
						arg_579_1:RecordAudio("1104704139", var_582_6)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704139", "story_v_side_new_1104704.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_7 and arg_579_1.time_ < 0 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1104704140 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1104704140
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1104704141(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.8

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_1 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(1104704140).content)

				arg_583_1.text_.text = var_586_1

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_3 = 32 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 32)

				if (32 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 32)) > 0 and var_586_0 < var_586_3 then
					arg_583_1.talkMaxDuration = var_586_3

					if var_586_3 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_3 + 0
					end
				end

				arg_583_1.text_.text = var_586_1
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_4 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_4 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_4

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_4 and arg_583_1.time_ < 0 + var_586_4 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1104704141 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1104704141
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1104704142(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0.625

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_1 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(1104704141).content)

				arg_587_1.text_.text = var_590_1

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_3 = 25 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 25)

				if (25 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 25)) > 0 and var_590_0 < var_590_3 then
					arg_587_1.talkMaxDuration = var_590_3

					if var_590_3 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_3 + 0
					end
				end

				arg_587_1.text_.text = var_590_1
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_4 = math.max(var_590_0, arg_587_1.talkMaxDuration)

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_4 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - 0) / var_590_4

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= 0 + var_590_4 and arg_587_1.time_ < 0 + var_590_4 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1104704142 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1104704142
		arg_591_1.duration_ = 1.43

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1104704143(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.125

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:GetWordFromCfg(1104704142)
				local var_594_2 = arg_591_1:FormatText(var_594_1.content)

				arg_591_1.text_.text = var_594_2

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_4 = 5 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_2) / 5)

				if (5 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_2) / 5)) > 0 and var_594_0 < var_594_4 then
					arg_591_1.talkMaxDuration = var_594_4

					if var_594_4 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_4 + 0
					end
				end

				arg_591_1.text_.text = var_594_2
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb") ~= 0 then
					local var_594_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb") / 1000

					if var_594_5 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_5 + 0
					end

					if var_594_1.prefab_name ~= "" and arg_591_1.actors_[var_594_1.prefab_name] ~= nil then
						local var_594_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_1.prefab_name].transform, "story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb")

						arg_591_1:RecordAudio("1104704142", var_594_6)
						arg_591_1:RecordAudio("1104704142", var_594_6)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704142", "story_v_side_new_1104704.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_7 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_7 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_7

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_7 and arg_591_1.time_ < 0 + var_594_7 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1104704143 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1104704143
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1104704144(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.725

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, false)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_1 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(1104704143).content)

				arg_595_1.text_.text = var_598_1

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_3 = 29 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 29)

				if (29 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 29)) > 0 and var_598_0 < var_598_3 then
					arg_595_1.talkMaxDuration = var_598_3

					if var_598_3 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_3 + 0
					end
				end

				arg_595_1.text_.text = var_598_1
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_4 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_4 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_4

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_4 and arg_595_1.time_ < 0 + var_598_4 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1104704144 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1104704144
		arg_599_1.duration_ = 4.47

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1104704145(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.var_.moveOldPos1047ui_story = arg_599_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_602_0 = 0.001

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 then
				arg_599_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_599_1.time_ - 0) / var_602_0)
				arg_599_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_599_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["1047ui_story"].transform.position).z)
				arg_599_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_599_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_599_1.actors_["1047ui_story"].transform.localEulerAngles = arg_599_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 then
				arg_599_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_599_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_599_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_599_1.actors_["1047ui_story"].transform.position).z)
				arg_599_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_599_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_599_1.actors_["1047ui_story"].transform.localEulerAngles = arg_599_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_602_1 = arg_599_1.actors_["1047ui_story"]

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(var_602_1) and arg_599_1.var_.characterEffect1047ui_story == nil then
				arg_599_1.var_.characterEffect1047ui_story = var_602_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_2 = 0.200000002980232

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_2 and not isNil(var_602_1) then
				if arg_599_1.var_.characterEffect1047ui_story and not isNil(var_602_1) then
					arg_599_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= 0 + var_602_2 and arg_599_1.time_ < 0 + var_602_2 + arg_602_0 and not isNil(var_602_1) and arg_599_1.var_.characterEffect1047ui_story then
				arg_599_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_602_4 = 0
			local var_602_5 = 0.5

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_4 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_6 = arg_599_1:GetWordFromCfg(1104704144)
				local var_602_7 = arg_599_1:FormatText(var_602_6.content)

				arg_599_1.text_.text = var_602_7

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_9 = 20 <= 0 and var_602_5 or var_602_5 * (utf8.len(var_602_7) / 20)

				if (20 <= 0 and var_602_5 or var_602_5 * (utf8.len(var_602_7) / 20)) > 0 and var_602_5 < var_602_9 then
					arg_599_1.talkMaxDuration = var_602_9

					if var_602_9 + var_602_4 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_9 + var_602_4
					end
				end

				arg_599_1.text_.text = var_602_7
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb") ~= 0 then
					local var_602_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb") / 1000

					if var_602_10 + var_602_4 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_10 + var_602_4
					end

					if var_602_6.prefab_name ~= "" and arg_599_1.actors_[var_602_6.prefab_name] ~= nil then
						local var_602_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_6.prefab_name].transform, "story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb")

						arg_599_1:RecordAudio("1104704144", var_602_11)
						arg_599_1:RecordAudio("1104704144", var_602_11)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704144", "story_v_side_new_1104704.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_12 = math.max(var_602_5, arg_599_1.talkMaxDuration)

			if var_602_4 <= arg_599_1.time_ and arg_599_1.time_ < var_602_4 + var_602_12 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_4) / var_602_12

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_4 + var_602_12 and arg_599_1.time_ < var_602_4 + var_602_12 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_599_1:InitPlayNodeList()
	end,
	Play1104704145 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1104704145
		arg_603_1.duration_ = 1

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"

			SetActive(arg_603_1.choicesGo_, true)

			for iter_604_0, iter_604_1 in ipairs(arg_603_1.choices_) do
				SetActive(iter_604_1.go, iter_604_0 <= 1)
			end

			arg_603_1.choices_[1].txt.text = arg_603_1:FormatText(StoryChoiceCfg[1664].name)
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1104704146(arg_603_1)
			end

			arg_603_1:RecordChoiceLog(1104704145, 1664)
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["1047ui_story"]) and arg_603_1.var_.characterEffect1047ui_story == nil then
				arg_603_1.var_.characterEffect1047ui_story = arg_603_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_0 = 0.200000002980232

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 and not isNil(arg_603_1.actors_["1047ui_story"]) then
				if arg_603_1.var_.characterEffect1047ui_story and not isNil(arg_603_1.actors_["1047ui_story"]) then
					arg_603_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_603_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_603_1.time_ - 0) / var_606_0)
				end
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 and not isNil(arg_603_1.actors_["1047ui_story"]) and arg_603_1.var_.characterEffect1047ui_story then
				arg_603_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_603_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_606_1 = 0

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 then
				arg_603_1.allBtn_.enabled = false
			end

			if arg_603_1.time_ >= var_606_1 + 0.200000002980232 and arg_603_1.time_ < var_606_1 + 0.200000002980232 + arg_606_0 then
				arg_603_1.allBtn_.enabled = true
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1104704146 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1104704146
		arg_607_1.duration_ = 3.1

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1104704147(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(arg_607_1.actors_["1047ui_story"]) and arg_607_1.var_.characterEffect1047ui_story == nil then
				arg_607_1.var_.characterEffect1047ui_story = arg_607_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_0 = 0.200000002980232

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 and not isNil(arg_607_1.actors_["1047ui_story"]) then
				if arg_607_1.var_.characterEffect1047ui_story and not isNil(arg_607_1.actors_["1047ui_story"]) then
					arg_607_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 and not isNil(arg_607_1.actors_["1047ui_story"]) and arg_607_1.var_.characterEffect1047ui_story then
				arg_607_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_610_2 = 0
			local var_610_3 = 0.3

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_2 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_4 = arg_607_1:GetWordFromCfg(1104704146)
				local var_610_5 = arg_607_1:FormatText(var_610_4.content)

				arg_607_1.text_.text = var_610_5

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_7 = 12 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_5) / 12)

				if (12 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_5) / 12)) > 0 and var_610_3 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_2
					end
				end

				arg_607_1.text_.text = var_610_5
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb") ~= 0 then
					local var_610_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb") / 1000

					if var_610_8 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_8 + var_610_2
					end

					if var_610_4.prefab_name ~= "" and arg_607_1.actors_[var_610_4.prefab_name] ~= nil then
						local var_610_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_4.prefab_name].transform, "story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb")

						arg_607_1:RecordAudio("1104704146", var_610_9)
						arg_607_1:RecordAudio("1104704146", var_610_9)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704146", "story_v_side_new_1104704.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_10 = math.max(var_610_3, arg_607_1.talkMaxDuration)

			if var_610_2 <= arg_607_1.time_ and arg_607_1.time_ < var_610_2 + var_610_10 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_2) / var_610_10

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_2 + var_610_10 and arg_607_1.time_ < var_610_2 + var_610_10 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1104704147 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1104704147
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1104704148(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["1047ui_story"]) and arg_611_1.var_.characterEffect1047ui_story == nil then
				arg_611_1.var_.characterEffect1047ui_story = arg_611_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["1047ui_story"]) then
				if arg_611_1.var_.characterEffect1047ui_story and not isNil(arg_611_1.actors_["1047ui_story"]) then
					arg_611_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_611_1.time_ - 0) / var_614_0)
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["1047ui_story"]) and arg_611_1.var_.characterEffect1047ui_story then
				arg_611_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_614_1 = 0
			local var_614_2 = 0.4

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_3 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(1104704147).content)

				arg_611_1.text_.text = var_614_3

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_5 = 16 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_3) / 16)

				if (16 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_3) / 16)) > 0 and var_614_2 < var_614_5 then
					arg_611_1.talkMaxDuration = var_614_5

					if var_614_5 + var_614_1 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_5 + var_614_1
					end
				end

				arg_611_1.text_.text = var_614_3
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_6 = math.max(var_614_2, arg_611_1.talkMaxDuration)

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_6 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_1) / var_614_6

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_1 + var_614_6 and arg_611_1.time_ < var_614_1 + var_614_6 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1104704148 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1104704148
		arg_615_1.duration_ = 3.37

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1104704149(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 and not isNil(arg_615_1.actors_["1047ui_story"]) and arg_615_1.var_.characterEffect1047ui_story == nil then
				arg_615_1.var_.characterEffect1047ui_story = arg_615_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_0 = 0.200000002980232

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_0 and not isNil(arg_615_1.actors_["1047ui_story"]) then
				if arg_615_1.var_.characterEffect1047ui_story and not isNil(arg_615_1.actors_["1047ui_story"]) then
					arg_615_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_615_1.time_ >= 0 + var_618_0 and arg_615_1.time_ < 0 + var_618_0 + arg_618_0 and not isNil(arg_615_1.actors_["1047ui_story"]) and arg_615_1.var_.characterEffect1047ui_story then
				arg_615_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_618_2 = 0
			local var_618_3 = 0.45

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_2 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_4 = arg_615_1:GetWordFromCfg(1104704148)
				local var_618_5 = arg_615_1:FormatText(var_618_4.content)

				arg_615_1.text_.text = var_618_5

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_7 = 18 <= 0 and var_618_3 or var_618_3 * (utf8.len(var_618_5) / 18)

				if (18 <= 0 and var_618_3 or var_618_3 * (utf8.len(var_618_5) / 18)) > 0 and var_618_3 < var_618_7 then
					arg_615_1.talkMaxDuration = var_618_7

					if var_618_7 + var_618_2 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_7 + var_618_2
					end
				end

				arg_615_1.text_.text = var_618_5
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb") ~= 0 then
					local var_618_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb") / 1000

					if var_618_8 + var_618_2 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_8 + var_618_2
					end

					if var_618_4.prefab_name ~= "" and arg_615_1.actors_[var_618_4.prefab_name] ~= nil then
						local var_618_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_4.prefab_name].transform, "story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb")

						arg_615_1:RecordAudio("1104704148", var_618_9)
						arg_615_1:RecordAudio("1104704148", var_618_9)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704148", "story_v_side_new_1104704.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_10 = math.max(var_618_3, arg_615_1.talkMaxDuration)

			if var_618_2 <= arg_615_1.time_ and arg_615_1.time_ < var_618_2 + var_618_10 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_2) / var_618_10

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_2 + var_618_10 and arg_615_1.time_ < var_618_2 + var_618_10 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1104704149 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1104704149
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1104704150(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(arg_619_1.actors_["1047ui_story"]) and arg_619_1.var_.characterEffect1047ui_story == nil then
				arg_619_1.var_.characterEffect1047ui_story = arg_619_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_0 = 0.200000002980232

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 and not isNil(arg_619_1.actors_["1047ui_story"]) then
				if arg_619_1.var_.characterEffect1047ui_story and not isNil(arg_619_1.actors_["1047ui_story"]) then
					arg_619_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_619_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_619_1.time_ - 0) / var_622_0)
				end
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 and not isNil(arg_619_1.actors_["1047ui_story"]) and arg_619_1.var_.characterEffect1047ui_story then
				arg_619_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_619_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_622_1 = 0
			local var_622_2 = 0.35

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_3 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(1104704149).content)

				arg_619_1.text_.text = var_622_3

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_5 = 14 <= 0 and var_622_2 or var_622_2 * (utf8.len(var_622_3) / 14)

				if (14 <= 0 and var_622_2 or var_622_2 * (utf8.len(var_622_3) / 14)) > 0 and var_622_2 < var_622_5 then
					arg_619_1.talkMaxDuration = var_622_5

					if var_622_5 + var_622_1 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_5 + var_622_1
					end
				end

				arg_619_1.text_.text = var_622_3
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_6 = math.max(var_622_2, arg_619_1.talkMaxDuration)

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_6 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_1) / var_622_6

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_1 + var_622_6 and arg_619_1.time_ < var_622_1 + var_622_6 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1104704150 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1104704150
		arg_623_1.duration_ = 3.97

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1104704151(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(arg_623_1.actors_["1047ui_story"]) and arg_623_1.var_.characterEffect1047ui_story == nil then
				arg_623_1.var_.characterEffect1047ui_story = arg_623_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_0 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 and not isNil(arg_623_1.actors_["1047ui_story"]) then
				if arg_623_1.var_.characterEffect1047ui_story and not isNil(arg_623_1.actors_["1047ui_story"]) then
					arg_623_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 and not isNil(arg_623_1.actors_["1047ui_story"]) and arg_623_1.var_.characterEffect1047ui_story then
				arg_623_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action442")
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_626_2 = 0
			local var_626_3 = 0.35

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_2 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_4 = arg_623_1:GetWordFromCfg(1104704150)
				local var_626_5 = arg_623_1:FormatText(var_626_4.content)

				arg_623_1.text_.text = var_626_5

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_7 = 14 <= 0 and var_626_3 or var_626_3 * (utf8.len(var_626_5) / 14)

				if (14 <= 0 and var_626_3 or var_626_3 * (utf8.len(var_626_5) / 14)) > 0 and var_626_3 < var_626_7 then
					arg_623_1.talkMaxDuration = var_626_7

					if var_626_7 + var_626_2 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_7 + var_626_2
					end
				end

				arg_623_1.text_.text = var_626_5
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb") ~= 0 then
					local var_626_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb") / 1000

					if var_626_8 + var_626_2 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_8 + var_626_2
					end

					if var_626_4.prefab_name ~= "" and arg_623_1.actors_[var_626_4.prefab_name] ~= nil then
						local var_626_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_4.prefab_name].transform, "story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb")

						arg_623_1:RecordAudio("1104704150", var_626_9)
						arg_623_1:RecordAudio("1104704150", var_626_9)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704150", "story_v_side_new_1104704.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_10 = math.max(var_626_3, arg_623_1.talkMaxDuration)

			if var_626_2 <= arg_623_1.time_ and arg_623_1.time_ < var_626_2 + var_626_10 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_2) / var_626_10

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_2 + var_626_10 and arg_623_1.time_ < var_626_2 + var_626_10 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1104704151 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1104704151
		arg_627_1.duration_ = 2

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1104704152(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["1047ui_story"]) and arg_627_1.var_.characterEffect1047ui_story == nil then
				arg_627_1.var_.characterEffect1047ui_story = arg_627_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_0 = 0.200000002980232

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["1047ui_story"]) then
				if arg_627_1.var_.characterEffect1047ui_story and not isNil(arg_627_1.actors_["1047ui_story"]) then
					arg_627_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_627_1.time_ - 0) / var_630_0)
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["1047ui_story"]) and arg_627_1.var_.characterEffect1047ui_story then
				arg_627_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_630_1 = 0
			local var_630_2 = 0.15

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_3 = arg_627_1:GetWordFromCfg(1104704151)
				local var_630_4 = arg_627_1:FormatText(var_630_3.content)

				arg_627_1.text_.text = var_630_4

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_6 = 6 <= 0 and var_630_2 or var_630_2 * (utf8.len(var_630_4) / 6)

				if (6 <= 0 and var_630_2 or var_630_2 * (utf8.len(var_630_4) / 6)) > 0 and var_630_2 < var_630_6 then
					arg_627_1.talkMaxDuration = var_630_6

					if var_630_6 + var_630_1 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_6 + var_630_1
					end
				end

				arg_627_1.text_.text = var_630_4
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb") ~= 0 then
					local var_630_7 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb") / 1000

					if var_630_7 + var_630_1 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_7 + var_630_1
					end

					if var_630_3.prefab_name ~= "" and arg_627_1.actors_[var_630_3.prefab_name] ~= nil then
						local var_630_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_3.prefab_name].transform, "story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb")

						arg_627_1:RecordAudio("1104704151", var_630_8)
						arg_627_1:RecordAudio("1104704151", var_630_8)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704151", "story_v_side_new_1104704.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_9 = math.max(var_630_2, arg_627_1.talkMaxDuration)

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_9 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_1) / var_630_9

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_1 + var_630_9 and arg_627_1.time_ < var_630_1 + var_630_9 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1104704152 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1104704152
		arg_631_1.duration_ = 6.9

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1104704153(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["1047ui_story"]) and arg_631_1.var_.characterEffect1047ui_story == nil then
				arg_631_1.var_.characterEffect1047ui_story = arg_631_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.200000002980232

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["1047ui_story"]) then
				if arg_631_1.var_.characterEffect1047ui_story and not isNil(arg_631_1.actors_["1047ui_story"]) then
					arg_631_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["1047ui_story"]) and arg_631_1.var_.characterEffect1047ui_story then
				arg_631_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaB", "EmotionTimelineAnimator")
			end

			local var_634_2 = 0
			local var_634_3 = 0.35

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_2 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_4 = arg_631_1:GetWordFromCfg(1104704152)
				local var_634_5 = arg_631_1:FormatText(var_634_4.content)

				arg_631_1.text_.text = var_634_5

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_7 = 14 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_5) / 14)

				if (14 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_5) / 14)) > 0 and var_634_3 < var_634_7 then
					arg_631_1.talkMaxDuration = var_634_7

					if var_634_7 + var_634_2 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_7 + var_634_2
					end
				end

				arg_631_1.text_.text = var_634_5
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb") ~= 0 then
					local var_634_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb") / 1000

					if var_634_8 + var_634_2 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_8 + var_634_2
					end

					if var_634_4.prefab_name ~= "" and arg_631_1.actors_[var_634_4.prefab_name] ~= nil then
						local var_634_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_4.prefab_name].transform, "story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb")

						arg_631_1:RecordAudio("1104704152", var_634_9)
						arg_631_1:RecordAudio("1104704152", var_634_9)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704152", "story_v_side_new_1104704.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_10 = math.max(var_634_3, arg_631_1.talkMaxDuration)

			if var_634_2 <= arg_631_1.time_ and arg_631_1.time_ < var_634_2 + var_634_10 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_2) / var_634_10

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_2 + var_634_10 and arg_631_1.time_ < var_634_2 + var_634_10 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1104704153 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1104704153
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1104704154(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_638_0 = 0
			local var_638_1 = 0.65

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_2 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(1104704153).content)

				arg_635_1.text_.text = var_638_2

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_4 = 26 <= 0 and var_638_1 or var_638_1 * (utf8.len(var_638_2) / 26)

				if (26 <= 0 and var_638_1 or var_638_1 * (utf8.len(var_638_2) / 26)) > 0 and var_638_1 < var_638_4 then
					arg_635_1.talkMaxDuration = var_638_4

					if var_638_4 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_4 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_2
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_5 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_5 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_5

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_5 and arg_635_1.time_ < var_638_0 + var_638_5 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1104704154 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1104704154
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1104704155(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.var_.moveOldPos1047ui_story = arg_639_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_642_0 = 0.001

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 then
				arg_639_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_639_1.time_ - 0) / var_642_0)
				arg_639_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_639_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1047ui_story"].transform.position).z)
				arg_639_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_639_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_639_1.actors_["1047ui_story"].transform.localEulerAngles = arg_639_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 then
				arg_639_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_639_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_639_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1047ui_story"].transform.position).z)
				arg_639_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_639_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_639_1.actors_["1047ui_story"].transform.localEulerAngles = arg_639_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0.3 < arg_639_1.time_ and arg_639_1.time_ <= 0.3 + arg_642_0 then
				arg_639_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_cheers", "")
			end

			local var_642_2 = 0
			local var_642_3 = 0.35

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_2 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_4 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(1104704154).content)

				arg_639_1.text_.text = var_642_4

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_6 = 14 <= 0 and var_642_3 or var_642_3 * (utf8.len(var_642_4) / 14)

				if (14 <= 0 and var_642_3 or var_642_3 * (utf8.len(var_642_4) / 14)) > 0 and var_642_3 < var_642_6 then
					arg_639_1.talkMaxDuration = var_642_6

					if var_642_6 + var_642_2 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_6 + var_642_2
					end
				end

				arg_639_1.text_.text = var_642_4
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_7 = math.max(var_642_3, arg_639_1.talkMaxDuration)

			if var_642_2 <= arg_639_1.time_ and arg_639_1.time_ < var_642_2 + var_642_7 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_2) / var_642_7

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_2 + var_642_7 and arg_639_1.time_ < var_642_2 + var_642_7 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play1104704155 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1104704155
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1104704156(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 0.95

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_1 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(1104704155).content)

				arg_643_1.text_.text = var_646_1

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_3 = 38 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_1) / 38)

				if (38 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_1) / 38)) > 0 and var_646_0 < var_646_3 then
					arg_643_1.talkMaxDuration = var_646_3

					if var_646_3 + 0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_3 + 0
					end
				end

				arg_643_1.text_.text = var_646_1
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_4 = math.max(var_646_0, arg_643_1.talkMaxDuration)

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_4 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - 0) / var_646_4

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= 0 + var_646_4 and arg_643_1.time_ < 0 + var_646_4 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play1104704156 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1104704156
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1104704157(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0.8

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, true)
				arg_647_1.iconController_:SetSelectedState("hero")

				arg_647_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_647_1.callingController_:SetSelectedState("normal")

				arg_647_1.keyicon_.color = Color.New(1, 1, 1)
				arg_647_1.icon_.color = Color.New(1, 1, 1)

				local var_650_1 = arg_647_1:FormatText(arg_647_1:GetWordFromCfg(1104704156).content)

				arg_647_1.text_.text = var_650_1

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_3 = 32 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_1) / 32)

				if (32 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_1) / 32)) > 0 and var_650_0 < var_650_3 then
					arg_647_1.talkMaxDuration = var_650_3

					if var_650_3 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_3 + 0
					end
				end

				arg_647_1.text_.text = var_650_1
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_4 = math.max(var_650_0, arg_647_1.talkMaxDuration)

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_4 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - 0) / var_650_4

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= 0 + var_650_4 and arg_647_1.time_ < 0 + var_650_4 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play1104704157 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1104704157
		arg_651_1.duration_ = 3.8

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1104704158(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.var_.moveOldPos1047ui_story = arg_651_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_654_0 = 0.001

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_0 then
				arg_651_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_651_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_651_1.time_ - 0) / var_654_0)
				arg_651_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_651_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_651_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_651_1.actors_["1047ui_story"].transform.position).z)
				arg_651_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_651_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_651_1.actors_["1047ui_story"].transform.localEulerAngles = arg_651_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_651_1.time_ >= 0 + var_654_0 and arg_651_1.time_ < 0 + var_654_0 + arg_654_0 then
				arg_651_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_651_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_651_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_651_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_651_1.actors_["1047ui_story"].transform.position).z)
				arg_651_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_651_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_651_1.actors_["1047ui_story"].transform.localEulerAngles = arg_651_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_654_1 = arg_651_1.actors_["1047ui_story"]

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 and not isNil(var_654_1) and arg_651_1.var_.characterEffect1047ui_story == nil then
				arg_651_1.var_.characterEffect1047ui_story = var_654_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_2 = 0.200000002980232

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_2 and not isNil(var_654_1) then
				if arg_651_1.var_.characterEffect1047ui_story and not isNil(var_654_1) then
					arg_651_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_651_1.time_ >= 0 + var_654_2 and arg_651_1.time_ < 0 + var_654_2 + arg_654_0 and not isNil(var_654_1) and arg_651_1.var_.characterEffect1047ui_story then
				arg_651_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_654_4 = 0
			local var_654_5 = 0.4

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_4 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_6 = arg_651_1:GetWordFromCfg(1104704157)
				local var_654_7 = arg_651_1:FormatText(var_654_6.content)

				arg_651_1.text_.text = var_654_7

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_9 = 16 <= 0 and var_654_5 or var_654_5 * (utf8.len(var_654_7) / 16)

				if (16 <= 0 and var_654_5 or var_654_5 * (utf8.len(var_654_7) / 16)) > 0 and var_654_5 < var_654_9 then
					arg_651_1.talkMaxDuration = var_654_9

					if var_654_9 + var_654_4 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_9 + var_654_4
					end
				end

				arg_651_1.text_.text = var_654_7
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb") ~= 0 then
					local var_654_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb") / 1000

					if var_654_10 + var_654_4 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_10 + var_654_4
					end

					if var_654_6.prefab_name ~= "" and arg_651_1.actors_[var_654_6.prefab_name] ~= nil then
						local var_654_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_6.prefab_name].transform, "story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb")

						arg_651_1:RecordAudio("1104704157", var_654_11)
						arg_651_1:RecordAudio("1104704157", var_654_11)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704157", "story_v_side_new_1104704.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_12 = math.max(var_654_5, arg_651_1.talkMaxDuration)

			if var_654_4 <= arg_651_1.time_ and arg_651_1.time_ < var_654_4 + var_654_12 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_4) / var_654_12

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_4 + var_654_12 and arg_651_1.time_ < var_654_4 + var_654_12 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_651_1:InitPlayNodeList()
	end,
	Play1104704158 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1104704158
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1104704159(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(arg_655_1.actors_["1047ui_story"]) and arg_655_1.var_.characterEffect1047ui_story == nil then
				arg_655_1.var_.characterEffect1047ui_story = arg_655_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_658_0 = 0.200000002980232

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 and not isNil(arg_655_1.actors_["1047ui_story"]) then
				if arg_655_1.var_.characterEffect1047ui_story and not isNil(arg_655_1.actors_["1047ui_story"]) then
					arg_655_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_655_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_655_1.time_ - 0) / var_658_0)
				end
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 and not isNil(arg_655_1.actors_["1047ui_story"]) and arg_655_1.var_.characterEffect1047ui_story then
				arg_655_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_655_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_658_1 = 0
			local var_658_2 = 0.4

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_3 = arg_655_1:FormatText(arg_655_1:GetWordFromCfg(1104704158).content)

				arg_655_1.text_.text = var_658_3

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_5 = 16 <= 0 and var_658_2 or var_658_2 * (utf8.len(var_658_3) / 16)

				if (16 <= 0 and var_658_2 or var_658_2 * (utf8.len(var_658_3) / 16)) > 0 and var_658_2 < var_658_5 then
					arg_655_1.talkMaxDuration = var_658_5

					if var_658_5 + var_658_1 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_5 + var_658_1
					end
				end

				arg_655_1.text_.text = var_658_3
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_6 = math.max(var_658_2, arg_655_1.talkMaxDuration)

			if var_658_1 <= arg_655_1.time_ and arg_655_1.time_ < var_658_1 + var_658_6 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_1) / var_658_6

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_1 + var_658_6 and arg_655_1.time_ < var_658_1 + var_658_6 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play1104704159 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1104704159
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1104704160(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 and not isNil(arg_659_1.actors_["1047ui_story"]) and arg_659_1.var_.characterEffect1047ui_story == nil then
				arg_659_1.var_.characterEffect1047ui_story = arg_659_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_0 = 0.200000002980232

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_0 and not isNil(arg_659_1.actors_["1047ui_story"]) then
				if arg_659_1.var_.characterEffect1047ui_story and not isNil(arg_659_1.actors_["1047ui_story"]) then
					arg_659_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_659_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_659_1.time_ - 0) / var_662_0)
				end
			end

			if arg_659_1.time_ >= 0 + var_662_0 and arg_659_1.time_ < 0 + var_662_0 + arg_662_0 and not isNil(arg_659_1.actors_["1047ui_story"]) and arg_659_1.var_.characterEffect1047ui_story then
				arg_659_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_659_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_662_1 = 0
			local var_662_2 = 0.9

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, true)
				arg_659_1.iconController_:SetSelectedState("hero")

				arg_659_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_659_1.callingController_:SetSelectedState("normal")

				arg_659_1.keyicon_.color = Color.New(1, 1, 1)
				arg_659_1.icon_.color = Color.New(1, 1, 1)

				local var_662_3 = arg_659_1:FormatText(arg_659_1:GetWordFromCfg(1104704159).content)

				arg_659_1.text_.text = var_662_3

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_5 = 36 <= 0 and var_662_2 or var_662_2 * (utf8.len(var_662_3) / 36)

				if (36 <= 0 and var_662_2 or var_662_2 * (utf8.len(var_662_3) / 36)) > 0 and var_662_2 < var_662_5 then
					arg_659_1.talkMaxDuration = var_662_5

					if var_662_5 + var_662_1 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_5 + var_662_1
					end
				end

				arg_659_1.text_.text = var_662_3
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_6 = math.max(var_662_2, arg_659_1.talkMaxDuration)

			if var_662_1 <= arg_659_1.time_ and arg_659_1.time_ < var_662_1 + var_662_6 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_1) / var_662_6

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_1 + var_662_6 and arg_659_1.time_ < var_662_1 + var_662_6 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play1104704160 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1104704160
		arg_663_1.duration_ = 2.57

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1104704161(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.var_.moveOldPos1047ui_story = arg_663_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_666_0 = 0.001

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_0 then
				arg_663_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_663_1.time_ - 0) / var_666_0)
				arg_663_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_663_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1047ui_story"].transform.position).z)
				arg_663_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_663_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_663_1.actors_["1047ui_story"].transform.localEulerAngles = arg_663_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_663_1.time_ >= 0 + var_666_0 and arg_663_1.time_ < 0 + var_666_0 + arg_666_0 then
				arg_663_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_663_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_663_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_663_1.actors_["1047ui_story"].transform.position).z)
				arg_663_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_663_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_663_1.actors_["1047ui_story"].transform.localEulerAngles = arg_663_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_666_1 = arg_663_1.actors_["1047ui_story"]

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(var_666_1) and arg_663_1.var_.characterEffect1047ui_story == nil then
				arg_663_1.var_.characterEffect1047ui_story = var_666_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_2 = 0.200000002980232

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_2 and not isNil(var_666_1) then
				if arg_663_1.var_.characterEffect1047ui_story and not isNil(var_666_1) then
					arg_663_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_663_1.time_ >= 0 + var_666_2 and arg_663_1.time_ < 0 + var_666_2 + arg_666_0 and not isNil(var_666_1) and arg_663_1.var_.characterEffect1047ui_story then
				arg_663_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_666_4 = 0
			local var_666_5 = 0.2

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_4 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_6 = arg_663_1:GetWordFromCfg(1104704160)
				local var_666_7 = arg_663_1:FormatText(var_666_6.content)

				arg_663_1.text_.text = var_666_7

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_9 = 8 <= 0 and var_666_5 or var_666_5 * (utf8.len(var_666_7) / 8)

				if (8 <= 0 and var_666_5 or var_666_5 * (utf8.len(var_666_7) / 8)) > 0 and var_666_5 < var_666_9 then
					arg_663_1.talkMaxDuration = var_666_9

					if var_666_9 + var_666_4 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_9 + var_666_4
					end
				end

				arg_663_1.text_.text = var_666_7
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb") ~= 0 then
					local var_666_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb") / 1000

					if var_666_10 + var_666_4 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_10 + var_666_4
					end

					if var_666_6.prefab_name ~= "" and arg_663_1.actors_[var_666_6.prefab_name] ~= nil then
						local var_666_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_6.prefab_name].transform, "story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb")

						arg_663_1:RecordAudio("1104704160", var_666_11)
						arg_663_1:RecordAudio("1104704160", var_666_11)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704160", "story_v_side_new_1104704.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_12 = math.max(var_666_5, arg_663_1.talkMaxDuration)

			if var_666_4 <= arg_663_1.time_ and arg_663_1.time_ < var_666_4 + var_666_12 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_4) / var_666_12

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_4 + var_666_12 and arg_663_1.time_ < var_666_4 + var_666_12 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_663_1:InitPlayNodeList()
	end,
	Play1104704161 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1104704161
		arg_667_1.duration_ = 7.3

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1104704162(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = 0.7

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= 0 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				arg_667_1.leftNameTxt_.text = arg_667_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_1 = arg_667_1:GetWordFromCfg(1104704161)
				local var_670_2 = arg_667_1:FormatText(var_670_1.content)

				arg_667_1.text_.text = var_670_2

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_4 = 28 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_2) / 28)

				if (28 <= 0 and var_670_0 or var_670_0 * (utf8.len(var_670_2) / 28)) > 0 and var_670_0 < var_670_4 then
					arg_667_1.talkMaxDuration = var_670_4

					if var_670_4 + 0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_4 + 0
					end
				end

				arg_667_1.text_.text = var_670_2
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb") ~= 0 then
					local var_670_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb") / 1000

					if var_670_5 + 0 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_5 + 0
					end

					if var_670_1.prefab_name ~= "" and arg_667_1.actors_[var_670_1.prefab_name] ~= nil then
						local var_670_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_1.prefab_name].transform, "story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb")

						arg_667_1:RecordAudio("1104704161", var_670_6)
						arg_667_1:RecordAudio("1104704161", var_670_6)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704161", "story_v_side_new_1104704.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_7 = math.max(var_670_0, arg_667_1.talkMaxDuration)

			if 0 <= arg_667_1.time_ and arg_667_1.time_ < 0 + var_670_7 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - 0) / var_670_7

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= 0 + var_670_7 and arg_667_1.time_ < 0 + var_670_7 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play1104704162 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1104704162
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play1104704163(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 and not isNil(arg_671_1.actors_["1047ui_story"]) and arg_671_1.var_.characterEffect1047ui_story == nil then
				arg_671_1.var_.characterEffect1047ui_story = arg_671_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_0 = 0.200000002980232

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_0 and not isNil(arg_671_1.actors_["1047ui_story"]) then
				if arg_671_1.var_.characterEffect1047ui_story and not isNil(arg_671_1.actors_["1047ui_story"]) then
					arg_671_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_671_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_671_1.time_ - 0) / var_674_0)
				end
			end

			if arg_671_1.time_ >= 0 + var_674_0 and arg_671_1.time_ < 0 + var_674_0 + arg_674_0 and not isNil(arg_671_1.actors_["1047ui_story"]) and arg_671_1.var_.characterEffect1047ui_story then
				arg_671_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_671_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_674_1 = 0
			local var_674_2 = 0.35

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				arg_671_1.leftNameTxt_.text = arg_671_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, true)
				arg_671_1.iconController_:SetSelectedState("hero")

				arg_671_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_671_1.callingController_:SetSelectedState("normal")

				arg_671_1.keyicon_.color = Color.New(1, 1, 1)
				arg_671_1.icon_.color = Color.New(1, 1, 1)

				local var_674_3 = arg_671_1:FormatText(arg_671_1:GetWordFromCfg(1104704162).content)

				arg_671_1.text_.text = var_674_3

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_5 = 14 <= 0 and var_674_2 or var_674_2 * (utf8.len(var_674_3) / 14)

				if (14 <= 0 and var_674_2 or var_674_2 * (utf8.len(var_674_3) / 14)) > 0 and var_674_2 < var_674_5 then
					arg_671_1.talkMaxDuration = var_674_5

					if var_674_5 + var_674_1 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_5 + var_674_1
					end
				end

				arg_671_1.text_.text = var_674_3
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_6 = math.max(var_674_2, arg_671_1.talkMaxDuration)

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_6 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_1) / var_674_6

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_1 + var_674_6 and arg_671_1.time_ < var_674_1 + var_674_6 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play1104704163 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1104704163
		arg_675_1.duration_ = 5.77

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1104704164(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.var_.moveOldPos1047ui_story = arg_675_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_678_0 = 0.001

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_0 then
				arg_675_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_675_1.time_ - 0) / var_678_0)
				arg_675_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_675_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["1047ui_story"].transform.position).z)
				arg_675_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_675_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_675_1.actors_["1047ui_story"].transform.localEulerAngles = arg_675_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_675_1.time_ >= 0 + var_678_0 and arg_675_1.time_ < 0 + var_678_0 + arg_678_0 then
				arg_675_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_675_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_675_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_675_1.actors_["1047ui_story"].transform.position).z)
				arg_675_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_675_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_675_1.actors_["1047ui_story"].transform.localEulerAngles = arg_675_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_678_1 = arg_675_1.actors_["1047ui_story"]

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 and not isNil(var_678_1) and arg_675_1.var_.characterEffect1047ui_story == nil then
				arg_675_1.var_.characterEffect1047ui_story = var_678_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_2 = 0.200000002980232

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_2 and not isNil(var_678_1) then
				if arg_675_1.var_.characterEffect1047ui_story and not isNil(var_678_1) then
					arg_675_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_675_1.time_ >= 0 + var_678_2 and arg_675_1.time_ < 0 + var_678_2 + arg_678_0 and not isNil(var_678_1) and arg_675_1.var_.characterEffect1047ui_story then
				arg_675_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_678_4 = 0
			local var_678_5 = 0.575

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_4 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_6 = arg_675_1:GetWordFromCfg(1104704163)
				local var_678_7 = arg_675_1:FormatText(var_678_6.content)

				arg_675_1.text_.text = var_678_7

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_9 = 23 <= 0 and var_678_5 or var_678_5 * (utf8.len(var_678_7) / 23)

				if (23 <= 0 and var_678_5 or var_678_5 * (utf8.len(var_678_7) / 23)) > 0 and var_678_5 < var_678_9 then
					arg_675_1.talkMaxDuration = var_678_9

					if var_678_9 + var_678_4 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_9 + var_678_4
					end
				end

				arg_675_1.text_.text = var_678_7
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb") ~= 0 then
					local var_678_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb") / 1000

					if var_678_10 + var_678_4 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_10 + var_678_4
					end

					if var_678_6.prefab_name ~= "" and arg_675_1.actors_[var_678_6.prefab_name] ~= nil then
						local var_678_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_6.prefab_name].transform, "story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb")

						arg_675_1:RecordAudio("1104704163", var_678_11)
						arg_675_1:RecordAudio("1104704163", var_678_11)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704163", "story_v_side_new_1104704.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_12 = math.max(var_678_5, arg_675_1.talkMaxDuration)

			if var_678_4 <= arg_675_1.time_ and arg_675_1.time_ < var_678_4 + var_678_12 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_4) / var_678_12

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_4 + var_678_12 and arg_675_1.time_ < var_678_4 + var_678_12 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_675_1:InitPlayNodeList()
	end,
	Play1104704164 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1104704164
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1104704165(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(arg_679_1.actors_["1047ui_story"]) and arg_679_1.var_.characterEffect1047ui_story == nil then
				arg_679_1.var_.characterEffect1047ui_story = arg_679_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_0 = 0.200000002980232

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 and not isNil(arg_679_1.actors_["1047ui_story"]) then
				if arg_679_1.var_.characterEffect1047ui_story and not isNil(arg_679_1.actors_["1047ui_story"]) then
					arg_679_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_679_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_679_1.time_ - 0) / var_682_0)
				end
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 and not isNil(arg_679_1.actors_["1047ui_story"]) and arg_679_1.var_.characterEffect1047ui_story then
				arg_679_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_679_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_682_1 = 0
			local var_682_2 = 0.1

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, true)
				arg_679_1.iconController_:SetSelectedState("hero")

				arg_679_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_679_1.callingController_:SetSelectedState("normal")

				arg_679_1.keyicon_.color = Color.New(1, 1, 1)
				arg_679_1.icon_.color = Color.New(1, 1, 1)

				local var_682_3 = arg_679_1:FormatText(arg_679_1:GetWordFromCfg(1104704164).content)

				arg_679_1.text_.text = var_682_3

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_5 = 4 <= 0 and var_682_2 or var_682_2 * (utf8.len(var_682_3) / 4)

				if (4 <= 0 and var_682_2 or var_682_2 * (utf8.len(var_682_3) / 4)) > 0 and var_682_2 < var_682_5 then
					arg_679_1.talkMaxDuration = var_682_5

					if var_682_5 + var_682_1 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_5 + var_682_1
					end
				end

				arg_679_1.text_.text = var_682_3
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_6 = math.max(var_682_2, arg_679_1.talkMaxDuration)

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_6 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_1) / var_682_6

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_1 + var_682_6 and arg_679_1.time_ < var_682_1 + var_682_6 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play1104704165 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1104704165
		arg_683_1.duration_ = 4.23

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1104704166(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(arg_683_1.actors_["1047ui_story"]) and arg_683_1.var_.characterEffect1047ui_story == nil then
				arg_683_1.var_.characterEffect1047ui_story = arg_683_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_0 = 0.200000002980232

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 and not isNil(arg_683_1.actors_["1047ui_story"]) then
				if arg_683_1.var_.characterEffect1047ui_story and not isNil(arg_683_1.actors_["1047ui_story"]) then
					arg_683_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 and not isNil(arg_683_1.actors_["1047ui_story"]) and arg_683_1.var_.characterEffect1047ui_story then
				arg_683_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_686_2 = 0
			local var_686_3 = 0.5

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_2 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_4 = arg_683_1:GetWordFromCfg(1104704165)
				local var_686_5 = arg_683_1:FormatText(var_686_4.content)

				arg_683_1.text_.text = var_686_5

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_7 = 20 <= 0 and var_686_3 or var_686_3 * (utf8.len(var_686_5) / 20)

				if (20 <= 0 and var_686_3 or var_686_3 * (utf8.len(var_686_5) / 20)) > 0 and var_686_3 < var_686_7 then
					arg_683_1.talkMaxDuration = var_686_7

					if var_686_7 + var_686_2 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_7 + var_686_2
					end
				end

				arg_683_1.text_.text = var_686_5
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb") ~= 0 then
					local var_686_8 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb") / 1000

					if var_686_8 + var_686_2 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_8 + var_686_2
					end

					if var_686_4.prefab_name ~= "" and arg_683_1.actors_[var_686_4.prefab_name] ~= nil then
						local var_686_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_4.prefab_name].transform, "story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb")

						arg_683_1:RecordAudio("1104704165", var_686_9)
						arg_683_1:RecordAudio("1104704165", var_686_9)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704165", "story_v_side_new_1104704.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_10 = math.max(var_686_3, arg_683_1.talkMaxDuration)

			if var_686_2 <= arg_683_1.time_ and arg_683_1.time_ < var_686_2 + var_686_10 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_2) / var_686_10

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_2 + var_686_10 and arg_683_1.time_ < var_686_2 + var_686_10 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play1104704166 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1104704166
		arg_687_1.duration_ = 6.4

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1104704167(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0.75

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_1 = arg_687_1:GetWordFromCfg(1104704166)
				local var_690_2 = arg_687_1:FormatText(var_690_1.content)

				arg_687_1.text_.text = var_690_2

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_4 = 30 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_2) / 30)

				if (30 <= 0 and var_690_0 or var_690_0 * (utf8.len(var_690_2) / 30)) > 0 and var_690_0 < var_690_4 then
					arg_687_1.talkMaxDuration = var_690_4

					if var_690_4 + 0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_4 + 0
					end
				end

				arg_687_1.text_.text = var_690_2
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb") ~= 0 then
					local var_690_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb") / 1000

					if var_690_5 + 0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_5 + 0
					end

					if var_690_1.prefab_name ~= "" and arg_687_1.actors_[var_690_1.prefab_name] ~= nil then
						local var_690_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_1.prefab_name].transform, "story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb")

						arg_687_1:RecordAudio("1104704166", var_690_6)
						arg_687_1:RecordAudio("1104704166", var_690_6)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704166", "story_v_side_new_1104704.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_7 = math.max(var_690_0, arg_687_1.talkMaxDuration)

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_7 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - 0) / var_690_7

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= 0 + var_690_7 and arg_687_1.time_ < 0 + var_690_7 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {}

		arg_687_1:InitPlayNodeList()
	end,
	Play1104704167 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1104704167
		arg_691_1.duration_ = 7.27

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1104704168(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0.725

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_1 = arg_691_1:GetWordFromCfg(1104704167)
				local var_694_2 = arg_691_1:FormatText(var_694_1.content)

				arg_691_1.text_.text = var_694_2

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_4 = 29 <= 0 and var_694_0 or var_694_0 * (utf8.len(var_694_2) / 29)

				if (29 <= 0 and var_694_0 or var_694_0 * (utf8.len(var_694_2) / 29)) > 0 and var_694_0 < var_694_4 then
					arg_691_1.talkMaxDuration = var_694_4

					if var_694_4 + 0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_4 + 0
					end
				end

				arg_691_1.text_.text = var_694_2
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb") ~= 0 then
					local var_694_5 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb") / 1000

					if var_694_5 + 0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_5 + 0
					end

					if var_694_1.prefab_name ~= "" and arg_691_1.actors_[var_694_1.prefab_name] ~= nil then
						local var_694_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_1.prefab_name].transform, "story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb")

						arg_691_1:RecordAudio("1104704167", var_694_6)
						arg_691_1:RecordAudio("1104704167", var_694_6)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704167", "story_v_side_new_1104704.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_7 = math.max(var_694_0, arg_691_1.talkMaxDuration)

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_7 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - 0) / var_694_7

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= 0 + var_694_7 and arg_691_1.time_ < 0 + var_694_7 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play1104704168 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1104704168
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1104704169(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 and not isNil(arg_695_1.actors_["1047ui_story"]) and arg_695_1.var_.characterEffect1047ui_story == nil then
				arg_695_1.var_.characterEffect1047ui_story = arg_695_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_0 = 0.200000002980232

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_0 and not isNil(arg_695_1.actors_["1047ui_story"]) then
				if arg_695_1.var_.characterEffect1047ui_story and not isNil(arg_695_1.actors_["1047ui_story"]) then
					arg_695_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_695_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_695_1.time_ - 0) / var_698_0)
				end
			end

			if arg_695_1.time_ >= 0 + var_698_0 and arg_695_1.time_ < 0 + var_698_0 + arg_698_0 and not isNil(arg_695_1.actors_["1047ui_story"]) and arg_695_1.var_.characterEffect1047ui_story then
				arg_695_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_695_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_698_1 = 0
			local var_698_2 = 0.25

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, true)
				arg_695_1.iconController_:SetSelectedState("hero")

				arg_695_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_695_1.callingController_:SetSelectedState("normal")

				arg_695_1.keyicon_.color = Color.New(1, 1, 1)
				arg_695_1.icon_.color = Color.New(1, 1, 1)

				local var_698_3 = arg_695_1:FormatText(arg_695_1:GetWordFromCfg(1104704168).content)

				arg_695_1.text_.text = var_698_3

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_5 = 10 <= 0 and var_698_2 or var_698_2 * (utf8.len(var_698_3) / 10)

				if (10 <= 0 and var_698_2 or var_698_2 * (utf8.len(var_698_3) / 10)) > 0 and var_698_2 < var_698_5 then
					arg_695_1.talkMaxDuration = var_698_5

					if var_698_5 + var_698_1 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_5 + var_698_1
					end
				end

				arg_695_1.text_.text = var_698_3
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_6 = math.max(var_698_2, arg_695_1.talkMaxDuration)

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_6 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_1) / var_698_6

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_1 + var_698_6 and arg_695_1.time_ < var_698_1 + var_698_6 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play1104704169 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1104704169
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1104704170(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.var_.moveOldPos1047ui_story = arg_699_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_702_0 = 0.001

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 then
				arg_699_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_699_1.time_ - 0) / var_702_0)
				arg_699_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1047ui_story"].transform.position).z)
				arg_699_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["1047ui_story"].transform.localEulerAngles = arg_699_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 then
				arg_699_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_699_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_699_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_699_1.actors_["1047ui_story"].transform.position).z)
				arg_699_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_699_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_699_1.actors_["1047ui_story"].transform.localEulerAngles = arg_699_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_702_1 = 0
			local var_702_2 = 0.425

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, false)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_3 = arg_699_1:FormatText(arg_699_1:GetWordFromCfg(1104704169).content)

				arg_699_1.text_.text = var_702_3

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_5 = 17 <= 0 and var_702_2 or var_702_2 * (utf8.len(var_702_3) / 17)

				if (17 <= 0 and var_702_2 or var_702_2 * (utf8.len(var_702_3) / 17)) > 0 and var_702_2 < var_702_5 then
					arg_699_1.talkMaxDuration = var_702_5

					if var_702_5 + var_702_1 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_5 + var_702_1
					end
				end

				arg_699_1.text_.text = var_702_3
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_6 = math.max(var_702_2, arg_699_1.talkMaxDuration)

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_6 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_1) / var_702_6

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_1 + var_702_6 and arg_699_1.time_ < var_702_1 + var_702_6 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play1104704170 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1104704170
		arg_703_1.duration_ = 3.83

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1104704171(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1.var_.moveOldPos1047ui_story = arg_703_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_706_0 = 0.001

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 then
				arg_703_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_703_1.time_ - 0) / var_706_0)
				arg_703_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1047ui_story"].transform.position).z)
				arg_703_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["1047ui_story"].transform.localEulerAngles = arg_703_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 then
				arg_703_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_703_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_703_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_703_1.actors_["1047ui_story"].transform.position).z)
				arg_703_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_703_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_703_1.actors_["1047ui_story"].transform.localEulerAngles = arg_703_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_706_1 = arg_703_1.actors_["1047ui_story"]

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect1047ui_story == nil then
				arg_703_1.var_.characterEffect1047ui_story = var_706_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_2 = 0.200000002980232

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_2 and not isNil(var_706_1) then
				if arg_703_1.var_.characterEffect1047ui_story and not isNil(var_706_1) then
					arg_703_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_703_1.time_ >= 0 + var_706_2 and arg_703_1.time_ < 0 + var_706_2 + arg_706_0 and not isNil(var_706_1) and arg_703_1.var_.characterEffect1047ui_story then
				arg_703_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_706_4 = 0
			local var_706_5 = 0.325

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_4 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_6 = arg_703_1:GetWordFromCfg(1104704170)
				local var_706_7 = arg_703_1:FormatText(var_706_6.content)

				arg_703_1.text_.text = var_706_7

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_9 = 13 <= 0 and var_706_5 or var_706_5 * (utf8.len(var_706_7) / 13)

				if (13 <= 0 and var_706_5 or var_706_5 * (utf8.len(var_706_7) / 13)) > 0 and var_706_5 < var_706_9 then
					arg_703_1.talkMaxDuration = var_706_9

					if var_706_9 + var_706_4 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_9 + var_706_4
					end
				end

				arg_703_1.text_.text = var_706_7
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb") ~= 0 then
					local var_706_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb") / 1000

					if var_706_10 + var_706_4 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_10 + var_706_4
					end

					if var_706_6.prefab_name ~= "" and arg_703_1.actors_[var_706_6.prefab_name] ~= nil then
						local var_706_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_703_1.actors_[var_706_6.prefab_name].transform, "story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb")

						arg_703_1:RecordAudio("1104704170", var_706_11)
						arg_703_1:RecordAudio("1104704170", var_706_11)
					else
						arg_703_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb")
					end

					arg_703_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704170", "story_v_side_new_1104704.awb")
				end

				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_12 = math.max(var_706_5, arg_703_1.talkMaxDuration)

			if var_706_4 <= arg_703_1.time_ and arg_703_1.time_ < var_706_4 + var_706_12 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_4) / var_706_12

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_4 + var_706_12 and arg_703_1.time_ < var_706_4 + var_706_12 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_703_1:InitPlayNodeList()
	end,
	Play1104704171 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1104704171
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1104704172(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.var_.moveOldPos1047ui_story = arg_707_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_710_0 = 0.001

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_0 then
				arg_707_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_707_1.time_ - 0) / var_710_0)
				arg_707_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_707_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1047ui_story"].transform.position).z)
				arg_707_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_707_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_707_1.actors_["1047ui_story"].transform.localEulerAngles = arg_707_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_707_1.time_ >= 0 + var_710_0 and arg_707_1.time_ < 0 + var_710_0 + arg_710_0 then
				arg_707_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_707_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_707_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_707_1.actors_["1047ui_story"].transform.position).z)
				arg_707_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_707_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_707_1.actors_["1047ui_story"].transform.localEulerAngles = arg_707_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_710_1 = 0
			local var_710_2 = 0.15

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, false)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_3 = arg_707_1:FormatText(arg_707_1:GetWordFromCfg(1104704171).content)

				arg_707_1.text_.text = var_710_3

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_5 = 6 <= 0 and var_710_2 or var_710_2 * (utf8.len(var_710_3) / 6)

				if (6 <= 0 and var_710_2 or var_710_2 * (utf8.len(var_710_3) / 6)) > 0 and var_710_2 < var_710_5 then
					arg_707_1.talkMaxDuration = var_710_5

					if var_710_5 + var_710_1 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_5 + var_710_1
					end
				end

				arg_707_1.text_.text = var_710_3
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_6 = math.max(var_710_2, arg_707_1.talkMaxDuration)

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_6 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_1) / var_710_6

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_1 + var_710_6 and arg_707_1.time_ < var_710_1 + var_710_6 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play1104704172 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1104704172
		arg_711_1.duration_ = 2

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
			arg_711_1.auto_ = false
		end

		function arg_711_1.playNext_(arg_713_0)
			arg_711_1.onStoryFinished_()
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1.var_.moveOldPos1047ui_story = arg_711_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_714_0 = 0.001

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_0 then
				arg_711_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_711_1.time_ - 0) / var_714_0)
				arg_711_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_711_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["1047ui_story"].transform.position).z)
				arg_711_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_711_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_711_1.actors_["1047ui_story"].transform.localEulerAngles = arg_711_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_711_1.time_ >= 0 + var_714_0 and arg_711_1.time_ < 0 + var_714_0 + arg_714_0 then
				arg_711_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_711_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_711_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_711_1.actors_["1047ui_story"].transform.position).z)
				arg_711_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_711_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_711_1.actors_["1047ui_story"].transform.localEulerAngles = arg_711_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_714_1 = arg_711_1.actors_["1047ui_story"]

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 and not isNil(var_714_1) and arg_711_1.var_.characterEffect1047ui_story == nil then
				arg_711_1.var_.characterEffect1047ui_story = var_714_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_2 = 0.200000002980232

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_2 and not isNil(var_714_1) then
				if arg_711_1.var_.characterEffect1047ui_story and not isNil(var_714_1) then
					arg_711_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= 0 + var_714_2 and arg_711_1.time_ < 0 + var_714_2 + arg_714_0 and not isNil(var_714_1) and arg_711_1.var_.characterEffect1047ui_story then
				arg_711_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_714_4 = 0
			local var_714_5 = 0.325

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_4 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_6 = arg_711_1:GetWordFromCfg(1104704172)
				local var_714_7 = arg_711_1:FormatText(var_714_6.content)

				arg_711_1.text_.text = var_714_7

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_9 = 13 <= 0 and var_714_5 or var_714_5 * (utf8.len(var_714_7) / 13)

				if (13 <= 0 and var_714_5 or var_714_5 * (utf8.len(var_714_7) / 13)) > 0 and var_714_5 < var_714_9 then
					arg_711_1.talkMaxDuration = var_714_9

					if var_714_9 + var_714_4 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_9 + var_714_4
					end
				end

				arg_711_1.text_.text = var_714_7
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb") ~= 0 then
					local var_714_10 = manager.audio:GetVoiceLength("story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb") / 1000

					if var_714_10 + var_714_4 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_10 + var_714_4
					end

					if var_714_6.prefab_name ~= "" and arg_711_1.actors_[var_714_6.prefab_name] ~= nil then
						local var_714_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_6.prefab_name].transform, "story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb")

						arg_711_1:RecordAudio("1104704172", var_714_11)
						arg_711_1:RecordAudio("1104704172", var_714_11)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_new_1104704", "1104704172", "story_v_side_new_1104704.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_12 = math.max(var_714_5, arg_711_1.talkMaxDuration)

			if var_714_4 <= arg_711_1.time_ and arg_711_1.time_ < var_714_4 + var_714_12 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_4) / var_714_12

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_4 + var_714_12 and arg_711_1.time_ < var_714_4 + var_714_12 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_711_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22a",
		"TextureConfig/Background/ST27a",
		"TextureConfig/Background/ST84a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/R4701",
		"TextureConfig/Background/R4701a",
		"TextureConfig/Background/ST05a"
	},
	voices = {
		"story_v_side_new_1104704.awb"
	}
}
